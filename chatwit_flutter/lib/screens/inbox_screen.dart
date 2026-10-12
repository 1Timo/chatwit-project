import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/screens/chatscreen.dart';
import 'package:chatwit_flutter/screens/settings/settings_screen.dart';
import 'package:chatwit_flutter/core/client.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  static const _headerColor = Color(0xFFFFFFFF);
  static const _bodyColor = Color(0xFFF9FAFB);
  static const _accentColor = Color(0xFF374151);

  List<Conversation> _conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final conversations = await client.chat.getRecentConversations();
      if (mounted) {
        setState(() {
          _conversations = conversations;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading inbox: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    return "${date.day}/${date.month}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bodyColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: _headerColor,
        foregroundColor: _accentColor,
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Color(0xFF253746),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _loadUsers,
              color: const Color(0xFF9E9E9E),
              child: _conversations.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.65,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 44,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "No conversations yet",
                                  style: TextStyle(
                                    color: Color(0xFF536575),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = _conversations[index];
                        return ListTile(
                          leading: Stack(
                            children: [
                              ChatwitImage.avatar(
                                conversation.profileImageUrl,
                                radius: 28,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            conversation.otherUserName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            conversation.lastMessage ?? "Start a conversation",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _formatDate(conversation.updatedAt),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  userId: conversation.otherUserId,
                                  userName: conversation.otherUserName,
                                  profileImageUrl:
                                      conversation.profileImageUrl ?? "",
                                ),
                              ),
                            );
                            if (mounted) await _loadUsers();
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
