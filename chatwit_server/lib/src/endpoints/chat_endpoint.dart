import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart' as protocol;
import 'notification_endpoint.dart';

class ChatEndpoint extends Endpoint {
  static const _postShareMessageMarker = '__CHATWIT_POST_SHARE__:';
  static const _conversationDeletedMarker = '__CHAT_CONVERSATION_DELETED__';
  static const _messageDeletedMarker = '__CHAT_MESSAGE_DELETED__:';

  @override
  bool get requireLogin => true;

  // ── Real-time Messaging ──────────────────────────────────────────────────

  /// Sends a message and persists it to the database.
  /// Also broadcasts it to the recipient's personal message stream.
  Future<protocol.Message> sendMessage(
    Session session,
    String receiverId,
    String text,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw StateError('Authentication is required to send a message.');
    }

    final senderId = authInfo.userIdentifier;

    // 1. Persist to DB
    final message = protocol.Message(
      senderId: senderId,
      senderName: (await _getUserName(session, senderId)) ?? 'Unknown',
      receiverId: receiverId,
      text: text,
      createdAt: DateTime.now(),
    );
    final savedMessage = await protocol.Message.db.insertRow(session, message);

    // 2. Broadcast to recipient
    // Recipient listens on channel: 'chat_user_$receiverId'
    await session.messages.postMessage(
      'chat_user_$receiverId',
      savedMessage,
    );

    // 3. Optional: Trigger Push Notification
    final senderName = message.senderName;
    final notificationBody = text.startsWith(_postShareMessageMarker)
        ? 'Shared a post with you.'
        : text;
    await NotificationEndpoint().sendPushNotification(
      session,
      receiverId,
      'New Message from $senderName',
      notificationBody,
    );
    return savedMessage;
  }

  /// Listen for incoming messages in real-time.
  Stream<protocol.Message> listenToMessages(Session session) async* {
    final authInfo = session.authenticated;
    if (authInfo == null) return;

    final userId = authInfo.userIdentifier;
    final stream = session.messages.createStream<protocol.Message>(
      'chat_user_$userId',
    );

    await for (var message in stream) {
      yield message;
    }
  }

  // ── Message Retrieval ─────────────────────────────────────────────────────

  /// Gets the conversation history between current user and another user.
  Future<List<protocol.Message>> getConversation(
    Session session,
    String otherUserId,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return [];

    final myId = authInfo.userIdentifier;
    final hiddenBefore = await _getHiddenBefore(session, myId, otherUserId);

    final messages = await protocol.Message.db.find(
      session,
      where: (t) =>
          (t.senderId.equals(myId) & t.receiverId.equals(otherUserId)) |
          (t.senderId.equals(otherUserId) & t.receiverId.equals(myId)),
      orderBy: (t) => t.createdAt,
    );
    final visibleMessages = hiddenBefore == null
        ? messages
        : messages
              .where((message) => message.createdAt.isAfter(hiddenBefore))
              .toList();
    final hiddenMessages = await protocol.MessageVisibility.db.find(
      session,
      where: (t) => t.userId.equals(myId),
    );
    final hiddenMessageIds = hiddenMessages
        .map((visibility) => visibility.messageId)
        .toSet();
    return visibleMessages
        .where((message) => !hiddenMessageIds.contains(message.id))
        .toList();
  }

  /// Hides one message from the current participant without affecting others.
  Future<void> deleteMessageForMe(Session session, int messageId) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw StateError('Authentication is required to delete a message.');
    }
    final message = await _getMessageForParticipant(
      session,
      messageId,
      userId,
    );
    final existingVisibility = await protocol.MessageVisibility.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.messageId.equals(messageId),
    );
    if (existingVisibility == null) {
      await protocol.MessageVisibility.db.insertRow(
        session,
        protocol.MessageVisibility(userId: userId, messageId: messageId),
      );
    }
    await session.messages.postMessage(
      'chat_user_$userId',
      protocol.Message(
        senderId: userId,
        senderName: '',
        receiverId: message.senderId == userId
            ? message.receiverId
            : message.senderId,
        text: '$_messageDeletedMarker$messageId',
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Permanently deletes one message for both participants.
  Future<void> deleteMessageForEveryone(
    Session session,
    int messageId,
  ) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw StateError('Authentication is required to delete a message.');
    }
    final message = await _getMessageForParticipant(
      session,
      messageId,
      userId,
    );
    await protocol.MessageVisibility.db.deleteWhere(
      session,
      where: (t) => t.messageId.equals(messageId),
    );
    await protocol.Message.db.deleteWhere(
      session,
      where: (t) => t.id.equals(messageId),
    );
    final event = protocol.Message(
      senderId: userId,
      senderName: '',
      receiverId: message.senderId == userId
          ? message.receiverId
          : message.senderId,
      text: '$_messageDeletedMarker$messageId',
      createdAt: DateTime.now(),
    );
    await session.messages.postMessage('chat_user_${message.senderId}', event);
    if (message.receiverId != message.senderId) {
      await session.messages.postMessage(
        'chat_user_${message.receiverId}',
        event,
      );
    }
  }

  Future<protocol.Message> _getMessageForParticipant(
    Session session,
    int messageId,
    String userId,
  ) async {
    final message = await protocol.Message.db.findById(session, messageId);
    if (message == null ||
        (message.senderId != userId && message.receiverId != userId)) {
      throw StateError('Message not found in this conversation.');
    }
    return message;
  }

  /// Hides all existing messages in this conversation from the current user.
  Future<void> deleteConversationForMe(
    Session session,
    String otherUserId,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;
    final myId = authInfo.userIdentifier;
    if (myId == otherUserId) {
      throw ArgumentError.value(otherUserId, 'otherUserId');
    }

    await protocol.ConversationVisibility.db.upsertRow(
      session,
      protocol.ConversationVisibility(
        userId: myId,
        otherUserId: otherUserId,
        hiddenBefore: DateTime.now(),
      ),
      conflictColumns: (t) => [t.userId, t.otherUserId],
      updateColumns: (t) => [t.hiddenBefore],
    );
    await session.messages.postMessage(
      'chat_user_$myId',
      protocol.Message(
        senderId: myId,
        senderName: '',
        receiverId: otherUserId,
        text: _conversationDeletedMarker,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Permanently deletes messages for both participants.
  Future<void> deleteConversationForEveryone(
    Session session,
    String otherUserId,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;
    final myId = authInfo.userIdentifier;
    if (myId == otherUserId) {
      throw ArgumentError.value(otherUserId, 'otherUserId');
    }

    final conversationMessages = await protocol.Message.db.find(
      session,
      where: (t) =>
          (t.senderId.equals(myId) & t.receiverId.equals(otherUserId)) |
          (t.senderId.equals(otherUserId) & t.receiverId.equals(myId)),
    );
    final messageIds = conversationMessages
        .map((message) => message.id)
        .whereType<int>()
        .toSet();
    if (messageIds.isNotEmpty) {
      await protocol.MessageVisibility.db.deleteWhere(
        session,
        where: (t) => t.messageId.inSet(messageIds),
      );
    }
    await protocol.Message.db.deleteWhere(
      session,
      where: (t) =>
          (t.senderId.equals(myId) & t.receiverId.equals(otherUserId)) |
          (t.senderId.equals(otherUserId) & t.receiverId.equals(myId)),
    );
    await protocol.ConversationVisibility.db.deleteWhere(
      session,
      where: (t) =>
          (t.userId.equals(myId) & t.otherUserId.equals(otherUserId)) |
          (t.userId.equals(otherUserId) & t.otherUserId.equals(myId)),
    );

    final event = protocol.Message(
      senderId: myId,
      senderName: '',
      receiverId: otherUserId,
      text: _conversationDeletedMarker,
      createdAt: DateTime.now(),
    );
    await session.messages.postMessage('chat_user_$myId', event);
    await session.messages.postMessage('chat_user_$otherUserId', event);
  }

  /// Gets the latest message and profile details for each conversation.
  Future<List<protocol.Conversation>> getRecentConversations(
    Session session,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return [];

    final myId = authInfo.userIdentifier;
    final visibility = await protocol.ConversationVisibility.db.find(
      session,
      where: (t) => t.userId.equals(myId),
    );
    final hiddenBeforeByUser = {
      for (final entry in visibility) entry.otherUserId: entry.hiddenBefore,
    };
    final hiddenMessages = await protocol.MessageVisibility.db.find(
      session,
      where: (t) => t.userId.equals(myId),
    );
    final hiddenMessageIds = hiddenMessages
        .map((entry) => entry.messageId)
        .toSet();

    // Find all messages I sent or received
    final messages = await protocol.Message.db.find(
      session,
      where: (t) => t.senderId.equals(myId) | t.receiverId.equals(myId),
      orderBy: (t) => t.createdAt.desc(),
    );

    final Map<String, protocol.Message> latestMessages = {};
    for (var m in messages) {
      final otherUserId = m.senderId == myId ? m.receiverId : m.senderId;
      final hiddenBefore = hiddenBeforeByUser[otherUserId];
      if (hiddenBefore != null && !m.createdAt.isAfter(hiddenBefore)) continue;
      if (m.id != null && hiddenMessageIds.contains(m.id)) continue;
      latestMessages.putIfAbsent(otherUserId, () => m);
    }

    if (latestMessages.isEmpty) return [];

    final uuidSet = latestMessages.keys.map(UuidValue.fromString).toSet();

    // Fetch user details for these IDs
    final users = await protocol.UserRegistration.db.find(
      session,
      where: (t) => t.authUserId.inSet(uuidSet),
    );

    final usersById = {
      for (final user in users) user.authUserId.toString(): user,
    };
    final conversations = <protocol.Conversation>[];
    for (final entry in latestMessages.entries) {
      final user = usersById[entry.key];
      if (user == null) continue;

      var profileImageUrl = user.profileImageUrl;
      if (profileImageUrl != null && !profileImageUrl.startsWith('http')) {
        final uri = await session.storage.publicDownloadUrl(
          storageId: 'public',
          path: profileImageUrl,
        );
        profileImageUrl = uri.toString();
      }

      conversations.add(
        protocol.Conversation(
          otherUserId: entry.key,
          otherUserName: '${user.firstName} ${user.surname}',
          profileImageUrl: profileImageUrl,
          lastMessage:
              entry.value.text?.startsWith(_postShareMessageMarker) ?? false
              ? 'Shared a post'
              : entry.value.text,
          updatedAt: entry.value.createdAt,
        ),
      );
    }

    return conversations;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Future<DateTime?> _getHiddenBefore(
    Session session,
    String userId,
    String otherUserId,
  ) async {
    final visibility = await protocol.ConversationVisibility.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.otherUserId.equals(otherUserId),
    );
    return visibility?.hiddenBefore;
  }

  Future<String?> _getUserName(Session session, String userIdentifier) async {
    final registration = await protocol.UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(UuidValue.fromString(userIdentifier)),
    );
    return registration != null
        ? "${registration.firstName} ${registration.surname}"
        : null;
  }
}
