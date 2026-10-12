import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class NotificationDatabaseEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Get user's notifications (with optional read filter)
  Future<List<UserNotification>> getNotifications(
    Session session, {
    bool unreadOnly = false,
    int limit = 20,
    int offset = 0,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return [];

    final userId = authInfo.userIdentifier;

    return await UserNotification.db.find(
      session,
      where: (t) => unreadOnly
          ? (t.userId.equals(userId) & t.isRead.equals(false))
          : t.userId.equals(userId),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
    );
  }

  /// Mark a notification as read
  Future<bool> markAsRead(Session session, int notificationId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final notif = await UserNotification.db.findById(session, notificationId);
    if (notif == null || notif.userId != authInfo.userIdentifier) return false;

    notif.isRead = true;
    await UserNotification.db.updateRow(session, notif);
    return true;
  }

  /// Mark all notifications as read
  Future<bool> markAllAsRead(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final userId = authInfo.userIdentifier;

    final unread = await UserNotification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
    );

    for (final notif in unread) {
      notif.isRead = true;
      await UserNotification.db.updateRow(session, notif);
    }

    return true;
  }

  /// Get unread notification count
  Future<int> getUnreadCount(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return 0;

    final userId = authInfo.userIdentifier;

    final unread = await UserNotification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
    );

    return unread.length;
  }

  /// Delete a notification
  Future<bool> deleteNotification(Session session, int notificationId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final notif = await UserNotification.db.findById(session, notificationId);
    if (notif == null || notif.userId != authInfo.userIdentifier) return false;

    await UserNotification.db.deleteRow(session, notif);
    return true;
  }
}
