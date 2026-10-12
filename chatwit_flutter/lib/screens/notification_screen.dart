import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<UserNotification> _notifications = [];
  bool _isLoading = true;
  StreamSubscription<RemoteMessage>? _subscription;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _subscription = NotificationService.messages.listen((message) {
      _loadNotifications();
    });
  }

  Future<void> _loadNotifications() async {
    try {
      final notifications = await client.notificationDatabase.getNotifications(
        unreadOnly: false,
        limit: 50,
        offset: 0,
      );
      if (mounted) {
        setState(() {
          _notifications = notifications;
          _isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) setState(() => _isLoading = false);
      debugPrint('Could not load notifications: $error');
    }
  }

  Future<void> _markAllRead() async {
    await client.notificationDatabase.markAllAsRead();
    await _loadNotifications();
  }

  Future<void> _markRead(UserNotification notification) async {
    if (notification.isRead || notification.id == null) return;
    await client.notificationDatabase.markAsRead(notification.id!);
    await _loadNotifications();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotifications,
              color: const Color(0xFF9E9E9E),
              child: _notifications.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 180),
                        Center(child: Text('No notifications yet')),
                      ],
                    )
                  : ListView.separated(
                      itemCount: _notifications.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        indent: 72,
                      ),
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return ListTile(
                          tileColor: notification.isRead
                              ? null
                              : const Color(0xFFF3F4F6),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFF3F4F6),
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                            child: Icon(_iconForType(notification.type)),
                          ),
                          title: Text(
                            notification.title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            notification.body,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onTap: () => _markRead(notification),
                        );
                      },
                    ),
            ),
    );
  }

  IconData _iconForType(String type) => switch (type) {
    'follow' => Icons.person_add_alt_1,
    'like' => Icons.favorite_border,
    'comment' => Icons.mode_comment_outlined,
    'mention' => Icons.alternate_email,
    _ => Icons.notifications_outlined,
  };
}
