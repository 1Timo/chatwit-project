import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/post_share_message.dart';
import 'package:chatwit_flutter/screens/profile_screen.dart';
import 'package:chatwit_flutter/screens/call_screen.dart';
import 'package:chatwit_flutter/widgets/fullscreen_image_viewer.dart';
import 'package:chatwit_flutter/widgets/fullscreen_video_player.dart';
import 'package:chatwit_flutter/core/webrtc_service.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String profileImageUrl;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const _conversationDeletedMarker = '__CHAT_CONVERSATION_DELETED__';
  static const _messageDeletedMarker = '__CHAT_MESSAGE_DELETED__:';
  static const _chatHeaderColor = Color(0xFFFFFFFF);
  static const _chatBodyColor = Color(0xFFF9FAFB);
  static const _chatAccentColor = Color(0xFF374151);

  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messages = [];
  StreamSubscription? _messageSubscription;
  bool _isLoading = true;

  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};
  bool _showAttachmentMenu = false;
  bool _isRecording = false;
  bool _isConversationMuted = false;
  final bool _isRemoteTyping = false; // Typing indicator state
  final WebRTCService _webRTCService = WebRTCService();
  final ImagePicker _picker = ImagePicker();

  MessageModel _messageFromText({
    required String text,
    required bool isMe,
    required String timestamp,
    int? serverId,
    MessageStatus status = MessageStatus.sent,
  }) {
    return MessageModel(
      text: text,
      isMe: isMe,
      timestamp: timestamp,
      serverId: serverId,
      status: status,
    );
  }

  @override
  void initState() {
    super.initState();
    _webRTCService.initialize();
    _loadConversation();
    _subscribeToMessages();
  }

  Future<void> _loadConversation() async {
    try {
      final otherUserId = widget.userId;
      final history = await client.chat.getConversation(otherUserId);

      if (mounted) {
        setState(() {
          _messages.clear();
          _messages.addAll(
            history.map(
              (m) => _messageFromText(
                text: m.text ?? '',
                isMe: m.senderId != otherUserId,
                timestamp: m.createdAt.toLocal().toString().substring(11, 16),
                serverId: m.id,
                status: MessageStatus.read,
              ),
            ),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading conversation: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _subscribeToMessages() {
    _messageSubscription = client.chat.listenToMessages().listen((message) {
      final otherUserId = widget.userId;
      if (!mounted) return;
      if (message.text == _conversationDeletedMarker) {
        setState(_messages.clear);
      } else if (message.text?.startsWith(_messageDeletedMarker) ?? false) {
        final deletedId = int.tryParse(
          message.text!.substring(_messageDeletedMarker.length),
        );
        if (deletedId != null) {
          setState(
            () => _messages.removeWhere((item) => item.serverId == deletedId),
          );
        }
      } else if (message.senderId == otherUserId) {
        setState(() {
          _messages.add(
            _messageFromText(
              text: message.text ?? '',
              isMe: false,
              timestamp: message.createdAt.toLocal().toString().substring(
                11,
                16,
              ),
              serverId: message.id,
              status: MessageStatus.read,
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _webRTCService.dispose();
    _messageController.dispose();
    _messageSubscription?.cancel();
    super.dispose();
  }

  void _toggleAttachmentMenu() {
    setState(() {
      _showAttachmentMenu = !_showAttachmentMenu;
    });
  }

  Future<void> _handleAttachmentSelection(String type) async {
    _toggleAttachmentMenu();
    try {
      if (type == 'Camera') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening Camera..."),
            duration: Duration(seconds: 1),
          ),
        );
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) {
          debugPrint("Photo picked: ${photo.path}");
        }
      } else if (type == 'Gallery') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening Gallery..."),
            duration: Duration(seconds: 1),
          ),
        );
        final XFile? media = await _picker.pickMedia();
        if (media != null) {
          final extension = media.name.split('.').last.toLowerCase();
          final isVideo =
              (extension == 'mp4' || extension == 'mov' || extension == 'm4v');
          setState(() {
            _messages.add(
              MessageModel(
                text: isVideo ? "Sent a video 🎥" : "Sent a photo 🖼️",
                isMe: true,
                timestamp: DateTime.now().toString().substring(11, 16),
                imageUrl: isVideo
                    ? null
                    : media.path, // Using path for local preview demonstration
                videoUrl: isVideo ? media.path : null,
              ),
            );
          });
        }
      } else if (type == 'File') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening File Picker..."),
            duration: Duration(seconds: 1),
          ),
        );
        final PlatformFile? result = await FilePicker.pickFile();
        if (result != null) {
          debugPrint("File picked: ${result.path}");
        }
      }
    } catch (e) {
      debugPrint("Error selecting attachment: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text("Could not open $type: $e"),
          ),
        );
      }
    }
  }

  void _onMessageLongPress(int index) {
    setState(() {
      _isSelectionMode = true;
      _selectedIndices.add(index);
    });
    _showReactionMenu();
  }

  void _showReactionMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        final selectedMessages = _selectedMessages;
        final canDeleteForEveryone =
            selectedMessages.isNotEmpty &&
            selectedMessages.every((message) => message.serverId != null);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ["👍", "❤️", "😂", "😮", "😢", "🙏"].map((emoji) {
                      return InkWell(
                        onTap: () => Navigator.pop(sheetContext),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Delete for me'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmDeleteSelectedMessages(forEveryone: false);
                  },
                ),
                if (canDeleteForEveryone)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Delete for everyone',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _confirmDeleteSelectedMessages(forEveryone: true);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<MessageModel> get _selectedMessages => _selectedIndices
      .where((index) => index >= 0 && index < _messages.length)
      .map((index) => _messages[index])
      .toList();

  Future<void> _deleteMessages({required bool forEveryone}) async {
    final selectedMessages = _selectedMessages;
    if (selectedMessages.isEmpty) return;

    try {
      for (final message in selectedMessages) {
        final messageId = message.serverId;
        if (messageId == null) continue;
        if (forEveryone) {
          await client.chat.deleteMessageForEveryone(messageId);
        } else {
          await client.chat.deleteMessageForMe(messageId);
        }
      }
      if (!mounted) return;
      setState(() {
        _messages.removeWhere(selectedMessages.contains);
        _isSelectionMode = false;
        _selectedIndices.clear();
      });
    } catch (error) {
      debugPrint('Error deleting selected messages: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not delete message: $error')),
        );
      }
    }
  }

  Future<void> _confirmDeleteSelectedMessages({
    required bool forEveryone,
  }) async {
    final count = _selectedMessages.length;
    if (count == 0) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          forEveryone ? 'Delete for everyone?' : 'Delete for me?',
        ),
        content: Text(
          forEveryone
              ? 'This will permanently delete $count message${count == 1 ? '' : 's'} for both participants.'
              : 'This will hide $count message${count == 1 ? '' : 's'} from you only.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              forEveryone ? 'DELETE FOR EVERYONE' : 'DELETE FOR ME',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) await _deleteMessages(forEveryone: forEveryone);
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedIndices.clear();
    });
  }

  void _copyMessages() {
    final texts = _selectedIndices.map((i) => _messages[i].text).join("\n");
    Clipboard.setData(ClipboardData(text: texts));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
    _exitSelectionMode();
  }

  Future<void> _startCall(bool video) async {
    final currentUserId = authManager.authInfo?.authUserId.toString() ?? '';
    final roomId = currentUserId.isNotEmpty
        ? 'call_${currentUserId}_${widget.userId}'
        : 'call_${widget.userId}';

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            webRTCService: _webRTCService,
            userName: widget.userName,
            isVideoCall: video,
            roomId: roomId,
            remoteUserId: widget.userId,
            currentUserId: currentUserId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _chatBodyColor,
      appBar: _isSelectionMode ? _buildSelectionAppBar() : _buildNormalAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        itemCount: _messages.length + (_isRemoteTyping ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length && _isRemoteTyping) {
                            return _buildTypingIndicator();
                          }
                          final msg = _messages[index];
                          final isSelected = _selectedIndices.contains(index);
                          return GestureDetector(
                            onLongPress: () => _onMessageLongPress(index),
                            onTap: () {
                              if (_isSelectionMode) {
                                setState(() {
                                  if (isSelected) {
                                    _selectedIndices.remove(index);
                                    if (_selectedIndices.isEmpty) {
                                      _isSelectionMode = false;
                                    }
                                  } else {
                                    _selectedIndices.add(index);
                                  }
                                });
                              }
                            },
                            child: Container(
                              color: isSelected
                                  ? const Color(0xFFE5E7EB)
                                  : Colors.transparent,
                              child: _buildMessageBubble(msg),
                            ),
                          );
                        },
                      ),
                    ),
                    _buildInputArea(),
                  ],
                ),
                if (_showAttachmentMenu) _buildAttachmentMenu(),
              ],
            ),
    );
  }

  AppBar _buildNormalAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: _chatHeaderColor,
      foregroundColor: _chatAccentColor,
      titleSpacing: 0,

      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userId: widget.userId,
                userName: widget.userName,
              ),
            ),
          );
        },
        child: Row(
          children: [
            ChatwitImage.avatar(widget.profileImageUrl, radius: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF253746),
                    ),
                  ),
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 12, color: Color(0xFF45856F)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_outlined),
          onPressed: () => _startCall(true),
        ),
        IconButton(
          icon: const Icon(Icons.call_outlined),
          onPressed: () => _startCall(false),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'clear') {
              setState(() => _messages.clear());
            } else if (value == 'mute') {
              setState(() => _isConversationMuted = !_isConversationMuted);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isConversationMuted
                        ? "Conversation muted"
                        : "Conversation unmuted",
                  ),
                ),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'search',
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text("Search"),
              ),
            ),
            PopupMenuItem(
              value: 'mute',
              child: ListTile(
                leading: Icon(
                  _isConversationMuted
                      ? Icons.notifications_off_outlined
                      : Icons.notifications_none_outlined,
                ),
                title: Text(
                  _isConversationMuted
                      ? "Unmute conversation"
                      : "Mute conversation",
                ),
              ),
            ),
            const PopupMenuItem(
              value: 'clear',
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text("Clear chat"),
              ),
            ),
            const PopupMenuItem(
              value: 'block',
              child: ListTile(
                leading: Icon(Icons.block, color: Colors.red),
                title: Text("Block", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildSelectionAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: _chatHeaderColor,
      foregroundColor: _chatAccentColor,

      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _exitSelectionMode,
      ),
      title: Text(
        "${_selectedIndices.length}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF253746),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.reply),
          onPressed: () {
            _exitSelectionMode();
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: _showReactionMenu,
        ),
        IconButton(icon: const Icon(Icons.copy), onPressed: _copyMessages),
        IconButton(
          icon: const Icon(Icons.forward),
          onPressed: () {
            _exitSelectionMode();
          },
        ),
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "typing...",
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel msg) {
    final sharedPost = PostShareMessage.decode(msg.text);
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isMe ? const Color(0xFF374151) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: msg.isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: msg.isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sharedPost != null)
              _buildSharedPostPreview(sharedPost, isMe: msg.isMe),
            if (sharedPost == null && msg.imageUrl != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageViewer(
                        imageUrl: msg.imageUrl!,
                        tag:
                            'chat-image-${msg.imageUrl}-${_messages.indexOf(msg)}',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'chat-image-${msg.imageUrl}-${_messages.indexOf(msg)}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: msg.imageUrl!.startsWith('http')
                        ? ChatwitImage.image(
                            msg.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          )
                        : Image.file(
                            File(msg.imageUrl!.replaceFirst('file://', '')),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                  ),
                ),
              ),
            if (sharedPost == null && msg.videoUrl != null)
              GestureDetector(
                onTap: () {
                  final controller = msg.videoUrl!.startsWith('http')
                      ? VideoPlayerController.networkUrl(
                          Uri.parse(msg.videoUrl!),
                        )
                      : VideoPlayerController.file(File(msg.videoUrl!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenVideoPlayer(
                        controller: controller,
                        videoUrl: msg.videoUrl,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            if (sharedPost == null &&
                (msg.imageUrl != null || msg.videoUrl != null) &&
                msg.text.isNotEmpty)
              const SizedBox(height: 8),
            if (sharedPost == null && msg.text.isNotEmpty)
              SelectableText(
                msg.text,
                style: TextStyle(
                  color: msg.isMe ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
                contextMenuBuilder: (context, editableTextState) {
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: editableTextState.contextMenuAnchors,
                    buttonItems: [
                      ContextMenuButtonItem(
                        onPressed: () => editableTextState.copySelection(
                          SelectionChangedCause.toolbar,
                        ),
                        label: 'Copy',
                      ),
                      ContextMenuButtonItem(
                        onPressed: () => editableTextState.cutSelection(
                          SelectionChangedCause.toolbar,
                        ),
                        label: 'Cut',
                      ),
                      ContextMenuButtonItem(
                        onPressed: () {},
                        label: 'Translate',
                      ),
                      ContextMenuButtonItem(onPressed: () {}, label: 'Search'),
                    ],
                  );
                },
              ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    msg.timestamp,
                    style: TextStyle(
                      color: msg.isMe ? Colors.white70 : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  if (msg.isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      msg.status == MessageStatus.read
                          ? Icons.done_all
                          : Icons.done,
                      size: 14,
                      color: msg.status == MessageStatus.read
                          ? Colors.lightBlueAccent
                          : Colors.white70,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharedPostPreview(
    Map<String, dynamic> post, {
    required bool isMe,
  }) {
    final authorName = post['authorName'] is String
        ? post['authorName'] as String
        : 'Chatwit user';
    final postText = post['text'] is String ? post['text'] as String : '';
    final imageUrl = post['imageUrl'] is String
        ? post['imageUrl'] as String
        : null;
    final videoUrl = post['videoUrl'] is String
        ? post['videoUrl'] as String
        : null;
    final foregroundColor = isMe ? Colors.white : Colors.black87;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isMe ? Colors.white.withValues(alpha: 0.12) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: foregroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.article_outlined,
                  size: 16,
                  color: foregroundColor,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Shared post',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              authorName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (postText.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                postText,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ChatwitImage.image(
                  imageUrl,
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 130,
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined),
                  ),
                ),
              ),
            ] else if (videoUrl != null && videoUrl.isNotEmpty) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  final controller = VideoPlayerController.networkUrl(
                    Uri.parse(videoUrl),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenVideoPlayer(
                        controller: controller,
                        videoUrl: videoUrl,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 42,
                    color: foregroundColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                _showAttachmentMenu ? Icons.close : Icons.add_circle_outline,
                color: const Color(0xFF374151),
                size: 28,
              ),
              onPressed: _toggleAttachmentMenu,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Emoji picker logic would go here
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isRecording ? Icons.stop : Icons.mic_none_outlined,
                        color: _isRecording ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _isRecording = !_isRecording);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            CircleAvatar(
              backgroundColor: const Color(0xFF374151),
              radius: 24,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () async {
                  final text = _messageController.text;
                  if (text.isNotEmpty) {
                    final tempMsg = _messageFromText(
                      text: text,
                      isMe: true,
                      timestamp: DateTime.now().toString().substring(11, 16),
                      status: MessageStatus.sent,
                    );

                    setState(() {
                      _messages.add(tempMsg);
                      _messageController.clear();
                    });

                    try {
                      final sentMessage = await client.chat.sendMessage(
                        widget.userId,
                        text,
                      );
                      // Update status to read/delivered once confirmed by server
                      if (mounted) {
                        setState(() {
                          final idx = _messages.indexOf(tempMsg);
                          if (idx != -1) {
                            _messages[idx] = tempMsg.copyWith(
                              serverId: sentMessage.id,
                              status: MessageStatus.read,
                            );
                          }
                        });
                      }
                    } catch (e) {
                      debugPrint("Error sending message: $e");
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to send message: $e")),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentMenu() {
    return Positioned(
      bottom: 80,
      left: 16,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _buildAttachmentItem(
                Icons.camera_alt,
                const Color(0xFF6B7280),
                "Camera",
              ),
              _buildAttachmentItem(
                Icons.image,
                const Color(0xFF6B7280),
                "Gallery",
              ),
              _buildAttachmentItem(
                Icons.insert_drive_file,
                const Color(0xFF6B7280),
                "File",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentItem(IconData icon, Color color, String label) {
    return InkWell(
      onTap: () => _handleAttachmentSelection(label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

enum MessageStatus { sent, delivered, read }

class MessageModel {
  final String text;
  final bool isMe;
  final String timestamp;
  final int? serverId;
  final String? imageUrl;
  final String? videoUrl;
  final MessageStatus status;

  MessageModel({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.serverId,
    this.imageUrl,
    this.videoUrl,
    this.status = MessageStatus.sent,
  });

  MessageModel copyWith({MessageStatus? status, int? serverId}) {
    return MessageModel(
      text: text,
      isMe: isMe,
      timestamp: timestamp,
      serverId: serverId ?? this.serverId,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      status: status ?? this.status,
    );
  }
}
