import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/storage_config.dart';

class StoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Create a new story (expires in 24 hours)
  Future<bool> createStory(
    Session session, {
    required String mediaUrl,
    required String mediaType,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;
    if (mediaType != 'image' && mediaType != 'video') {
      throw ArgumentError.value(
        mediaType,
        'mediaType',
        'Story media must be an image or video.',
      );
    }

    // Fetch user info
    final userInfo = await authInfo.userProfile(session);
    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );

    final userName =
        registration?.username ?? userInfo?.userName ?? userInfo?.fullName;

    // Get public URL for the media safely
    final fullMediaUrl = await _getPublicUrlSafe(session, mediaUrl);
    if (fullMediaUrl == null) return false;

    var profileImageUrl =
        registration?.profileImageUrl ?? userInfo?.imageUrl?.toString();
    if (profileImageUrl != null &&
        profileImageUrl.isNotEmpty &&
        !profileImageUrl.startsWith('http')) {
      profileImageUrl =
          await _getPublicUrlSafe(session, profileImageUrl) ?? profileImageUrl;
    }

    final story = Story(
      userId: authInfo.userIdentifier,
      userName: userName,
      profileImageUrl: profileImageUrl,
      mediaUrl: fullMediaUrl,
      mediaType: mediaType,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );

    await Story.db.insertRow(session, story);
    return true;
  }

  Future<bool> deleteStory(Session session, int storyId) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw StateError('Authentication is required to delete a story.');
    }

    final story = await Story.db.findById(session, storyId);
    if (story == null || story.userId != userId) return false;

    await Story.db.deleteRow(session, story);
    return true;
  }

  // Get all active (non-expired) stories
  Future<List<Story>> getActiveStories(Session session) async {
    final now = DateTime.now();
    final stories = await Story.db.find(
      session,
      where: (t) => t.expiresAt > now,
      orderBy: (t) => t.createdAt.desc(),
    );
    if (stories.isEmpty) return [];

    final userIds = <UuidValue>{};
    for (final story in stories) {
      try {
        userIds.add(UuidValue.fromString(story.userId));
      } on FormatException {
        session.log(
          'Ignoring story with invalid user ID: ${story.userId}',
          level: LogLevel.warning,
        );
      }
    }

    final registrations = userIds.isEmpty
        ? <UserRegistration>[]
        : await UserRegistration.db.find(
            session,
            where: (t) => t.authUserId.inSet(userIds),
          );
    final registrationsById = {
      for (final registration in registrations)
        registration.authUserId.toString(): registration,
    };

    final enrichedStories = await Future.wait(
      stories.map((story) async {
        final registration = registrationsById[story.userId];
        if (registration == null) return null;

        final fullName = '${registration.firstName} ${registration.surname}'
            .trim();
        final userName = fullName.isNotEmpty
            ? fullName
            : registration.username.trim();
        if (userName.isEmpty) return null;

        var profileImageUrl =
            registration.profileImageUrl ?? story.profileImageUrl;
        if (profileImageUrl != null &&
            profileImageUrl.isNotEmpty &&
            !profileImageUrl.startsWith('http')) {
          profileImageUrl =
              await _getPublicUrlSafe(session, profileImageUrl) ??
              profileImageUrl;
        }

        return story.copyWith(
          userName: userName,
          profileImageUrl: profileImageUrl ?? story.profileImageUrl,
        );
      }),
    );
    return enrichedStories.whereType<Story>().toList();
  }

  // Helper for file uploads (reusing same logic as posts)
  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyUpload(
      storageId: 'public',
      path: path,
    );
  }

  /// Helper to safely get public storage URL without crashing on network/DNS errors
  Future<String?> _getPublicUrlSafe(Session session, String path) async {
    // Use centralized, env-driven storage configuration
    final config = StorageConfig.fromEnvironment();
    return config.getPublicUrl(path);
  }
}
