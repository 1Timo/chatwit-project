/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:chatwit_client/src/protocol/greetings/greeting.dart'
    as _irvwm7lu;
import 'package:chatwit_client/src/protocol/model/call_signal_event.dart'
    as _iioholio;
import 'package:chatwit_client/src/protocol/model/comment.dart' as _in32nkod;
import 'package:chatwit_client/src/protocol/model/conversation.dart'
    as _igejyjm9;
import 'package:chatwit_client/src/protocol/model/follow.dart' as _i8bd7a66;
import 'package:chatwit_client/src/protocol/model/like.dart' as _iv0ugiln;
import 'package:chatwit_client/src/protocol/model/message.dart' as _i96rmjqe;
import 'package:chatwit_client/src/protocol/model/poll.dart' as _ib0b6q21;
import 'package:chatwit_client/src/protocol/model/post.dart' as _ipkjcj6i;
import 'package:chatwit_client/src/protocol/model/profile_photo.dart'
    as _iut9lv6g;
import 'package:chatwit_client/src/protocol/model/story.dart' as _iwsjwlp6;
import 'package:chatwit_client/src/protocol/model/user_notification.dart'
    as _i7uwbyee;
import 'package:chatwit_client/src/protocol/model/user_preference.dart'
    as _i32aro3o;
import 'package:chatwit_client/src/protocol/model/user_registration.dart'
    as _il7jsi9g;
import 'package:chatwit_client/src/protocol/model/voice_recording.dart'
    as _in07n00n;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointBookmark extends _isc.EndpointRef {
  EndpointBookmark(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bookmark';

  _ida.Future<bool> toggleBookmark(int postId) =>
      caller.callServerEndpoint<bool>(
        'bookmark',
        'toggleBookmark',
        {'postId': postId},
      );

  _ida.Future<List<_ipkjcj6i.Post>> getBookmarkedPosts() =>
      caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
        'bookmark',
        'getBookmarkedPosts',
        {},
      );

  _ida.Future<bool> isBookmarked(int postId) => caller.callServerEndpoint<bool>(
    'bookmark',
    'isBookmarked',
    {'postId': postId},
  );
}

/// {@category Endpoint}
class EndpointCallSignal extends _isc.EndpointRef {
  EndpointCallSignal(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'callSignal';

  _ida.Future<void> sendSignal({
    required String roomId,
    required String toUserId,
    required String type,
    String? payload,
  }) => caller.callServerEndpoint<void>(
    'callSignal',
    'sendSignal',
    {
      'roomId': roomId,
      'toUserId': toUserId,
      'type': type,
      'payload': payload,
    },
  );

  _ida.Stream<_iioholio.CallSignalEvent> listenToSignals({
    required String roomId,
  }) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iioholio.CallSignalEvent>,
        _iioholio.CallSignalEvent
      >(
        'callSignal',
        'listenToSignals',
        {'roomId': roomId},
        {},
      );
}

/// {@category Endpoint}
class EndpointChat extends _isc.EndpointRef {
  EndpointChat(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// Sends a message and persists it to the database.
  /// Also broadcasts it to the recipient's personal message stream.
  _ida.Future<_i96rmjqe.Message> sendMessage(
    String receiverId,
    String text,
  ) => caller.callServerEndpoint<_i96rmjqe.Message>(
    'chat',
    'sendMessage',
    {
      'receiverId': receiverId,
      'text': text,
    },
  );

  /// Listen for incoming messages in real-time.
  _ida.Stream<_i96rmjqe.Message> listenToMessages() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i96rmjqe.Message>,
        _i96rmjqe.Message
      >(
        'chat',
        'listenToMessages',
        {},
        {},
      );

  /// Gets the conversation history between current user and another user.
  _ida.Future<List<_i96rmjqe.Message>> getConversation(String otherUserId) =>
      caller.callServerEndpoint<List<_i96rmjqe.Message>>(
        'chat',
        'getConversation',
        {'otherUserId': otherUserId},
      );

  /// Hides one message from the current participant without affecting others.
  _ida.Future<void> deleteMessageForMe(int messageId) =>
      caller.callServerEndpoint<void>(
        'chat',
        'deleteMessageForMe',
        {'messageId': messageId},
      );

  /// Permanently deletes one message for both participants.
  _ida.Future<void> deleteMessageForEveryone(int messageId) =>
      caller.callServerEndpoint<void>(
        'chat',
        'deleteMessageForEveryone',
        {'messageId': messageId},
      );

  /// Hides all existing messages in this conversation from the current user.
  _ida.Future<void> deleteConversationForMe(String otherUserId) =>
      caller.callServerEndpoint<void>(
        'chat',
        'deleteConversationForMe',
        {'otherUserId': otherUserId},
      );

  /// Permanently deletes messages for both participants.
  _ida.Future<void> deleteConversationForEveryone(String otherUserId) =>
      caller.callServerEndpoint<void>(
        'chat',
        'deleteConversationForEveryone',
        {'otherUserId': otherUserId},
      );

  /// Gets the latest message and profile details for each conversation.
  _ida.Future<List<_igejyjm9.Conversation>> getRecentConversations() =>
      caller.callServerEndpoint<List<_igejyjm9.Conversation>>(
        'chat',
        'getRecentConversations',
        {},
      );
}

/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// {@category Endpoint}
class EndpointFile extends _isc.EndpointRef {
  EndpointFile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'file';

  _ida.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'file',
        'getUploadDescription',
        {'path': path},
      );

  _ida.Future<bool> verifyUpload(String path) =>
      caller.callServerEndpoint<bool>(
        'file',
        'verifyUpload',
        {'path': path},
      );

  _ida.Future<String?> getPublicUrl(String path) =>
      caller.callServerEndpoint<String?>(
        'file',
        'getPublicUrl',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointFollow extends _isc.EndpointRef {
  EndpointFollow(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'follow';

  /// Toggle Follow / Unfollow
  _ida.Future<bool> toggleFollow(
    String followingId,
    String followingName,
  ) => caller.callServerEndpoint<bool>(
    'follow',
    'toggleFollow',
    {
      'followingId': followingId,
      'followingName': followingName,
    },
  );

  _ida.Future<List<_i8bd7a66.Follow>> getFollowing() =>
      caller.callServerEndpoint<List<_i8bd7a66.Follow>>(
        'follow',
        'getFollowing',
        {},
      );

  _ida.Future<List<_i8bd7a66.Follow>> getFollowers() =>
      caller.callServerEndpoint<List<_i8bd7a66.Follow>>(
        'follow',
        'getFollowers',
        {},
      );

  _ida.Future<List<_i8bd7a66.Follow>> getUserFollowing(String userId) =>
      caller.callServerEndpoint<List<_i8bd7a66.Follow>>(
        'follow',
        'getUserFollowing',
        {'userId': userId},
      );

  _ida.Future<List<_i8bd7a66.Follow>> getUserFollowers(String userId) =>
      caller.callServerEndpoint<List<_i8bd7a66.Follow>>(
        'follow',
        'getUserFollowers',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// {@category Endpoint}
class EndpointNotificationDatabase extends _isc.EndpointRef {
  EndpointNotificationDatabase(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notificationDatabase';

  /// Get user's notifications (with optional read filter)
  _ida.Future<List<_i7uwbyee.UserNotification>> getNotifications({
    required bool unreadOnly,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i7uwbyee.UserNotification>>(
    'notificationDatabase',
    'getNotifications',
    {
      'unreadOnly': unreadOnly,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Mark a notification as read
  _ida.Future<bool> markAsRead(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'notificationDatabase',
        'markAsRead',
        {'notificationId': notificationId},
      );

  /// Mark all notifications as read
  _ida.Future<bool> markAllAsRead() => caller.callServerEndpoint<bool>(
    'notificationDatabase',
    'markAllAsRead',
    {},
  );

  /// Get unread notification count
  _ida.Future<int> getUnreadCount() => caller.callServerEndpoint<int>(
    'notificationDatabase',
    'getUnreadCount',
    {},
  );

  /// Delete a notification
  _ida.Future<bool> deleteNotification(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'notificationDatabase',
        'deleteNotification',
        {'notificationId': notificationId},
      );
}

/// {@category Endpoint}
class EndpointNotification extends _isc.EndpointRef {
  EndpointNotification(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _ida.Future<void> registerDeviceToken(
    String token,
    String deviceType,
  ) => caller.callServerEndpoint<void>(
    'notification',
    'registerDeviceToken',
    {
      'token': token,
      'deviceType': deviceType,
    },
  );

  _ida.Future<void> unregisterDeviceToken(String token) =>
      caller.callServerEndpoint<void>(
        'notification',
        'unregisterDeviceToken',
        {'token': token},
      );

  /// Sends a real push notification through Firebase Cloud Messaging HTTP v1.
  _ida.Future<void> sendPushNotification(
    String userId,
    String title,
    String body,
  ) => caller.callServerEndpoint<void>(
    'notification',
    'sendPushNotification',
    {
      'userId': userId,
      'title': title,
      'body': body,
    },
  );
}

/// {@category Endpoint}
class EndpointPoll extends _isc.EndpointRef {
  EndpointPoll(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'poll';

  _ida.Future<_ib0b6q21.Poll> createPoll({
    required String question,
    required List<String> options,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<_ib0b6q21.Poll>(
    'poll',
    'createPoll',
    {
      'question': question,
      'options': options,
      'expiresAt': expiresAt,
    },
  );

  _ida.Future<List<_ib0b6q21.Poll>> getPolls({required int limit}) =>
      caller.callServerEndpoint<List<_ib0b6q21.Poll>>(
        'poll',
        'getPolls',
        {'limit': limit},
      );

  _ida.Future<_ib0b6q21.Poll?> getPoll(int pollId) =>
      caller.callServerEndpoint<_ib0b6q21.Poll?>(
        'poll',
        'getPoll',
        {'pollId': pollId},
      );

  _ida.Future<Map<String, dynamic>> vote({
    required int pollId,
    required int optionIndex,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'poll',
    'vote',
    {
      'pollId': pollId,
      'optionIndex': optionIndex,
    },
  );

  _ida.Future<Map<String, dynamic>> getPollSummary(int pollId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'poll',
        'getPollSummary',
        {'pollId': pollId},
      );
}

/// {@category Endpoint}
class EndpointPost extends _isc.EndpointRef {
  EndpointPost(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'post';

  _ida.Future<bool> createPost(
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? category,
    String? location,
    String? audience,
    List<String>? sharedWithUserIds,
  ) => caller.callServerEndpoint<bool>(
    'post',
    'createPost',
    {
      'text': text,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'category': category,
      'location': location,
      'audience': audience,
      'sharedWithUserIds': sharedWithUserIds,
    },
  );

  _ida.Future<List<_ipkjcj6i.Post>> getAllPosts() =>
      caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
        'post',
        'getAllPosts',
        {},
      );

  _ida.Future<List<_ipkjcj6i.Post>> getPaginatedPosts({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'post',
    'getPaginatedPosts',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<List<_ipkjcj6i.Post>> getUserPosts(String userId) =>
      caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
        'post',
        'getUserPosts',
        {'userId': userId},
      );

  _ida.Future<bool> editPost(
    int postId,
    String newText,
  ) => caller.callServerEndpoint<bool>(
    'post',
    'editPost',
    {
      'postId': postId,
      'newText': newText,
    },
  );

  /// Deletes a post and all its related records.
  /// Idempotent: Returns true even if post doesn't exist.
  _ida.Future<bool> deletePost(int postId) => caller.callServerEndpoint<bool>(
    'post',
    'deletePost',
    {'postId': postId},
  );

  _ida.Future<bool> toggleLike(int postId) => caller.callServerEndpoint<bool>(
    'post',
    'toggleLike',
    {'postId': postId},
  );

  _ida.Future<List<_iv0ugiln.Like>> getLikes(int postId) =>
      caller.callServerEndpoint<List<_iv0ugiln.Like>>(
        'post',
        'getLikes',
        {'postId': postId},
      );

  _ida.Future<void> incrementViewCount(int postId) =>
      caller.callServerEndpoint<void>(
        'post',
        'incrementViewCount',
        {'postId': postId},
      );

  _ida.Future<void> batchIncrementViewCounts(List<int> postIds) =>
      caller.callServerEndpoint<void>(
        'post',
        'batchIncrementViewCounts',
        {'postIds': postIds},
      );

  _ida.Future<void> logInteraction(
    String? category,
    int score, {
    String? targetUserId,
  }) => caller.callServerEndpoint<void>(
    'post',
    'logInteraction',
    {
      'category': category,
      'score': score,
      'targetUserId': targetUserId,
    },
  );

  _ida.Future<List<_ipkjcj6i.Post>> getRecommendedFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'post',
    'getRecommendedFeed',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<bool> createComment(
    int postId,
    String? text,
    String? imageUrl,
    String? videoUrl,
  ) => caller.callServerEndpoint<bool>(
    'post',
    'createComment',
    {
      'postId': postId,
      'text': text,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
    },
  );

  _ida.Future<List<_in32nkod.Comment>> getComments(int postId) =>
      caller.callServerEndpoint<List<_in32nkod.Comment>>(
        'post',
        'getComments',
        {'postId': postId},
      );

  _ida.Future<bool> editComment(
    int commentId,
    String newText,
  ) => caller.callServerEndpoint<bool>(
    'post',
    'editComment',
    {
      'commentId': commentId,
      'newText': newText,
    },
  );

  _ida.Future<bool> deleteComment(int commentId) =>
      caller.callServerEndpoint<bool>(
        'post',
        'deleteComment',
        {'commentId': commentId},
      );

  _ida.Future<List<_ipkjcj6i.Post>> searchPosts(String keyword) =>
      caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
        'post',
        'searchPosts',
        {'keyword': keyword},
      );

  _ida.Future<bool> verifyUpload(String path) =>
      caller.callServerEndpoint<bool>(
        'post',
        'verifyUpload',
        {'path': path},
      );

  _ida.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'post',
        'getUploadDescription',
        {'path': path},
      );

  _ida.Future<void> logRecommendationFeedback(
    int postId,
    bool interested,
  ) => caller.callServerEndpoint<void>(
    'post',
    'logRecommendationFeedback',
    {
      'postId': postId,
      'interested': interested,
    },
  );

  /// Get posts by hashtag
  _ida.Future<List<_ipkjcj6i.Post>> getPostsByHashtag({
    required String tag,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'post',
    'getPostsByHashtag',
    {
      'tag': tag,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get trending hashtags
  _ida.Future<List<String>> getTrendingHashtags({required int limit}) =>
      caller.callServerEndpoint<List<String>>(
        'post',
        'getTrendingHashtags',
        {'limit': limit},
      );
}

/// {@category Endpoint}
class EndpointRefreshJwtTokens extends _iacc.EndpointRefreshJwtTokens {
  EndpointRefreshJwtTokens(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'refreshJwtTokens';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'refreshJwtTokens',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointStory extends _isc.EndpointRef {
  EndpointStory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'story';

  _ida.Future<bool> createStory({
    required String mediaUrl,
    required String mediaType,
  }) => caller.callServerEndpoint<bool>(
    'story',
    'createStory',
    {
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
    },
  );

  _ida.Future<bool> deleteStory(int storyId) => caller.callServerEndpoint<bool>(
    'story',
    'deleteStory',
    {'storyId': storyId},
  );

  _ida.Future<List<_iwsjwlp6.Story>> getActiveStories() =>
      caller.callServerEndpoint<List<_iwsjwlp6.Story>>(
        'story',
        'getActiveStories',
        {},
      );

  _ida.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'story',
        'getUploadDescription',
        {'path': path},
      );

  _ida.Future<bool> verifyUpload(String path) =>
      caller.callServerEndpoint<bool>(
        'story',
        'verifyUpload',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointUserPreference extends _isc.EndpointRef {
  EndpointUserPreference(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userPreference';

  /// Get available post categories for the app
  _ida.Future<List<String>> getAvailableCategories() =>
      caller.callServerEndpoint<List<String>>(
        'userPreference',
        'getAvailableCategories',
        {},
      );

  /// Save user's preferred categories
  _ida.Future<_i32aro3o.UserPreference?> saveUserPreferences(
    List<String> categories,
  ) => caller.callServerEndpoint<_i32aro3o.UserPreference?>(
    'userPreference',
    'saveUserPreferences',
    {'categories': categories},
  );

  /// Get user's preferred categories
  _ida.Future<List<String>> getUserPreferences() =>
      caller.callServerEndpoint<List<String>>(
        'userPreference',
        'getUserPreferences',
        {},
      );

  /// Get trending posts by category
  _ida.Future<List<_ipkjcj6i.Post>> getTrendingByCategory({
    required String category,
    required int limit,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'userPreference',
    'getTrendingByCategory',
    {
      'category': category,
      'limit': limit,
    },
  );

  /// Returns a view-ranked feed with a recent-post tie breaker.
  _ida.Future<List<_ipkjcj6i.Post>> getTrendingFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'userPreference',
    'getTrendingFeed',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get posts for user's preferred categories
  _ida.Future<List<_ipkjcj6i.Post>> getPersonalizedFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipkjcj6i.Post>>(
    'userPreference',
    'getPersonalizedFeed',
    {
      'limit': limit,
      'offset': offset,
    },
  );
}

/// {@category Endpoint}
class EndpointUserProfileEdit extends _iacc.EndpointUserProfileEditBase {
  EndpointUserProfileEdit(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfileEdit';

  /// Removes the user's uploaded image, setting it to null.
  ///
  /// The client should handle displaying a placeholder for users without images.
  @override
  _ida.Future<_iacc.UserProfileModel> removeUserImage() =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'removeUserImage',
        {},
      );

  /// Sets a new user image for the signed in user.
  @override
  _ida.Future<_iacc.UserProfileModel> setUserImage(_idt.ByteData image) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'setUserImage',
        {'image': image},
      );

  /// Changes the name of a user.
  @override
  _ida.Future<_iacc.UserProfileModel> changeUserName(String? userName) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'changeUserName',
        {'userName': userName},
      );

  /// Changes the full name of a user.
  @override
  _ida.Future<_iacc.UserProfileModel> changeFullName(String? fullName) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'changeFullName',
        {'fullName': fullName},
      );

  /// Returns the user profile of the current user.
  @override
  _ida.Future<_iacc.UserProfileModel> get() =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'get',
        {},
      );
}

/// {@category Endpoint}
class EndpointUserRegistration extends _isc.EndpointRef {
  EndpointUserRegistration(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userRegistration';

  _ida.Future<bool> isRegistrationComplete() => caller.callServerEndpoint<bool>(
    'userRegistration',
    'isRegistrationComplete',
    {},
  );

  _ida.Future<bool> submitRegistration({
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String sex,
    String? occupation,
    String? location,
    String? website,
  }) => caller.callServerEndpoint<bool>(
    'userRegistration',
    'submitRegistration',
    {
      'firstName': firstName,
      'surname': surname,
      'middleName': middleName,
      'username': username,
      'dateOfBirth': dateOfBirth,
      'sex': sex,
      'occupation': occupation,
      'location': location,
      'website': website,
    },
  );

  _ida.Future<bool> deleteAccount() => caller.callServerEndpoint<bool>(
    'userRegistration',
    'deleteAccount',
    {},
  );

  _ida.Future<_il7jsi9g.UserRegistration?> getUserInfo(String userId) =>
      caller.callServerEndpoint<_il7jsi9g.UserRegistration?>(
        'userRegistration',
        'getUserInfo',
        {'userId': userId},
      );

  _ida.Future<bool> updateBio(String bio) => caller.callServerEndpoint<bool>(
    'userRegistration',
    'updateBio',
    {'bio': bio},
  );

  _ida.Future<bool> updateBackgroundUrl(String backgroundUrl) =>
      caller.callServerEndpoint<bool>(
        'userRegistration',
        'updateBackgroundUrl',
        {'backgroundUrl': backgroundUrl},
      );

  _ida.Future<bool> updateProfileImageUrl(String profileImageUrl) =>
      caller.callServerEndpoint<bool>(
        'userRegistration',
        'updateProfileImageUrl',
        {'profileImageUrl': profileImageUrl},
      );

  _ida.Future<List<_iut9lv6g.ProfilePhoto>> getProfilePhotoHistory(
    String userId,
  ) => caller.callServerEndpoint<List<_iut9lv6g.ProfilePhoto>>(
    'userRegistration',
    'getProfilePhotoHistory',
    {'userId': userId},
  );

  _ida.Future<bool> deleteProfilePhoto(int photoId) =>
      caller.callServerEndpoint<bool>(
        'userRegistration',
        'deleteProfilePhoto',
        {'photoId': photoId},
      );

  _ida.Future<List<_il7jsi9g.UserRegistration>> getAllUsers() =>
      caller.callServerEndpoint<List<_il7jsi9g.UserRegistration>>(
        'userRegistration',
        'getAllUsers',
        {},
      );

  _ida.Future<List<_il7jsi9g.UserRegistration>> searchUsers(String query) =>
      caller.callServerEndpoint<List<_il7jsi9g.UserRegistration>>(
        'userRegistration',
        'searchUsers',
        {'query': query},
      );

  _ida.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'userRegistration',
        'getUploadDescription',
        {'path': path},
      );

  _ida.Future<bool> updateProfile({
    required String firstName,
    required String surname,
    String? bio,
    String? occupation,
    String? website,
    String? location,
    bool? isLocationPublic,
    bool? isDobPublic,
    required DateTime dateOfBirth,
  }) => caller.callServerEndpoint<bool>(
    'userRegistration',
    'updateProfile',
    {
      'firstName': firstName,
      'surname': surname,
      'bio': bio,
      'occupation': occupation,
      'website': website,
      'location': location,
      'isLocationPublic': isLocationPublic,
      'isDobPublic': isDobPublic,
      'dateOfBirth': dateOfBirth,
    },
  );

  _ida.Future<bool> verifyUpload(String path) =>
      caller.callServerEndpoint<bool>(
        'userRegistration',
        'verifyUpload',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointVoiceRecording extends _isc.EndpointRef {
  EndpointVoiceRecording(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'voiceRecording';

  /// Create a voice recording upload description
  /// Client will upload the file separately, then call completeVoiceRecording
  _ida.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'voiceRecording',
        'getUploadDescription',
        {'path': path},
      );

  /// Verify a voice recording upload
  _ida.Future<bool> verifyUpload(String path) =>
      caller.callServerEndpoint<bool>(
        'voiceRecording',
        'verifyUpload',
        {'path': path},
      );

  /// Complete voice recording upload by creating the database record
  /// Call this after uploading the file and verifying
  _ida.Future<_in07n00n.VoiceRecording?> completeVoiceRecording({
    required String callRoomId,
    required String toUserId,
    required String recordingPath,
    required int durationMs,
  }) => caller.callServerEndpoint<_in07n00n.VoiceRecording?>(
    'voiceRecording',
    'completeVoiceRecording',
    {
      'callRoomId': callRoomId,
      'toUserId': toUserId,
      'recordingPath': recordingPath,
      'durationMs': durationMs,
    },
  );

  /// Get all voice recordings for a user (as receiver or sender)
  _ida.Future<List<_in07n00n.VoiceRecording>> getUserVoiceRecordings() =>
      caller.callServerEndpoint<List<_in07n00n.VoiceRecording>>(
        'voiceRecording',
        'getUserVoiceRecordings',
        {},
      );

  /// Get voice recordings for a specific call room
  _ida.Future<List<_in07n00n.VoiceRecording>> getCallVoiceRecordings(
    String callRoomId,
  ) => caller.callServerEndpoint<List<_in07n00n.VoiceRecording>>(
    'voiceRecording',
    'getCallVoiceRecordings',
    {'callRoomId': callRoomId},
  );

  /// Delete a voice recording (only the owner can delete)
  _ida.Future<bool> deleteVoiceRecording(int recordingId) =>
      caller.callServerEndpoint<bool>(
        'voiceRecording',
        'deleteVoiceRecording',
        {'recordingId': recordingId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_irvwm7lu.Greeting> hello(String name) =>
      caller.callServerEndpoint<_irvwm7lu.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller auth;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    bookmark = EndpointBookmark(this);
    callSignal = EndpointCallSignal(this);
    chat = EndpointChat(this);
    emailIdp = EndpointEmailIdp(this);
    file = EndpointFile(this);
    follow = EndpointFollow(this);
    googleIdp = EndpointGoogleIdp(this);
    notificationDatabase = EndpointNotificationDatabase(this);
    notification = EndpointNotification(this);
    poll = EndpointPoll(this);
    post = EndpointPost(this);
    refreshJwtTokens = EndpointRefreshJwtTokens(this);
    story = EndpointStory(this);
    userPreference = EndpointUserPreference(this);
    userProfileEdit = EndpointUserProfileEdit(this);
    userRegistration = EndpointUserRegistration(this);
    voiceRecording = EndpointVoiceRecording(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointBookmark bookmark;

  late final EndpointCallSignal callSignal;

  late final EndpointChat chat;

  late final EndpointEmailIdp emailIdp;

  late final EndpointFile file;

  late final EndpointFollow follow;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointNotificationDatabase notificationDatabase;

  late final EndpointNotification notification;

  late final EndpointPoll poll;

  late final EndpointPost post;

  late final EndpointRefreshJwtTokens refreshJwtTokens;

  late final EndpointStory story;

  late final EndpointUserPreference userPreference;

  late final EndpointUserProfileEdit userProfileEdit;

  late final EndpointUserRegistration userRegistration;

  late final EndpointVoiceRecording voiceRecording;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'bookmark': bookmark,
    'callSignal': callSignal,
    'chat': chat,
    'emailIdp': emailIdp,
    'file': file,
    'follow': follow,
    'googleIdp': googleIdp,
    'notificationDatabase': notificationDatabase,
    'notification': notification,
    'poll': poll,
    'post': post,
    'refreshJwtTokens': refreshJwtTokens,
    'story': story,
    'userPreference': userPreference,
    'userProfileEdit': userProfileEdit,
    'userRegistration': userRegistration,
    'voiceRecording': voiceRecording,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
