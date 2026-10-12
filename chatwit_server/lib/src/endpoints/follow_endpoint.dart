import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'notification_endpoint.dart';

class FollowEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Toggle Follow / Unfollow
  Future<bool> toggleFollow(
    Session session,
    String followingId,
    String followingName,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    // Use userIdentifier (UUID string) for consistency
    final followerId = authInfo.userIdentifier;

    // Check if already following
    final existing = await Follow.db.findFirstRow(
      session,
      where: (t) =>
          t.followerId.equals(followerId) & t.followingId.equals(followingId),
    );

    if (existing != null) {
      await Follow.db.deleteRow(session, existing);
      return false; // Now unfollowed
    } else {
      // Get follower's name for notification
      final followerReg = await UserRegistration.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(UuidValue.fromString(followerId)),
      );
      final followerName = followerReg != null
          ? "${followerReg.firstName} ${followerReg.surname}"
          : "Someone";

      final follow = Follow(
        followerId: followerId,
        followerName: followerName,
        followingId: followingId,
        followingName: followingName,
        createdAt: DateTime.now(),
      );
      await Follow.db.insertRow(session, follow);

      await UserNotification.db.insertRow(
        session,
        UserNotification(
          userId: followingId,
          title: 'New follower',
          body: '$followerName followed you.',
          type: 'follow',
          relatedUserId: followerId,
          isRead: false,
          createdAt: DateTime.now(),
        ),
      );

      // Trigger Notification
      await NotificationEndpoint().sendPushNotification(
        session,
        followingId,
        'New Follower',
        '$followerName followed you!',
      );

      return true; // Now following
    }
  }

  // Get list of people I am following
  Future<List<Follow>> getFollowing(Session session) async {
    final followerId = session.authenticated?.userIdentifier;
    if (followerId == null) return [];

    return await Follow.db.find(
      session,
      where: (t) => t.followerId.equals(followerId),
    );
  }

  // Get my followers
  Future<List<Follow>> getFollowers(Session session) async {
    final followingId = session.authenticated?.userIdentifier;
    if (followingId == null) return [];

    final follows = await Follow.db.find(
      session,
      where: (t) => t.followingId.equals(followingId),
    );
    if (follows.isEmpty) return [];

    final followerIds = follows.map((follow) => follow.followerId).toSet();
    final followerUserIds = <UuidValue>{};
    for (final followerId in followerIds) {
      try {
        followerUserIds.add(UuidValue.fromString(followerId));
      } on FormatException {
        session.log(
          'Ignoring follower with invalid user ID: $followerId',
          level: LogLevel.warning,
        );
      }
    }
    if (followerUserIds.isEmpty) return [];

    final registrations = await UserRegistration.db.find(
      session,
      where: (t) => t.authUserId.inSet(followerUserIds),
    );
    final registrationsById = {
      for (final registration in registrations)
        registration.authUserId.toString(): registration,
    };

    return follows
        .map((follow) {
          final registration = registrationsById[follow.followerId];
          if (registration == null) return null;

          final fullName = '${registration.firstName} ${registration.surname}'
              .trim();
          final isPlaceholderName = const {'unknown', 'unknown user', 'someone'}
              .contains(
                fullName.toLowerCase(),
              );
          final displayName = fullName.isNotEmpty && !isPlaceholderName
              ? fullName
              : registration.username.trim();
          if (displayName.isEmpty) return null;

          return follow.copyWith(followerName: displayName);
        })
        .whereType<Follow>()
        .toList();
  }

  Future<List<Follow>> getUserFollowing(Session session, String userId) async {
    return await Follow.db.find(
      session,
      where: (t) => t.followerId.equals(userId),
    );
  }

  Future<List<Follow>> getUserFollowers(Session session, String userId) async {
    return await Follow.db.find(
      session,
      where: (t) => t.followingId.equals(userId),
    );
  }
}
