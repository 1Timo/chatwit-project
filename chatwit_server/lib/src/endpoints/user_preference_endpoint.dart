import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/post_visibility.dart';

class UserPreferenceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Get available post categories for the app
  Future<List<String>> getAvailableCategories(Session session) async {
    return [
      'Technology',
      'Sports',
      'Entertainment',
      'News',
      'Business',
      'Health',
      'Science',
      'Politics',
      'Travel',
      'Food',
      'Fashion',
      'Gaming',
      'Music',
      'General',
    ];
  }

  /// Save user's preferred categories
  Future<UserPreference?> saveUserPreferences(
    Session session,
    List<String> categories,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return null;

    final userId = authInfo.userIdentifier;

    // Find existing preference
    final existing = await UserPreference.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final pref = UserPreference(
      userId: userId,
      categories: jsonEncode(categories),
      createdAt: existing?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (existing != null) {
      pref.id = existing.id;
      await UserPreference.db.updateRow(session, pref);
    } else {
      await UserPreference.db.insertRow(session, pref);
    }

    session.log('User preferences updated: $categories', level: LogLevel.info);
    return pref;
  }

  /// Get user's preferred categories
  Future<List<String>> getUserPreferences(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return ['General'];

    final userId = authInfo.userIdentifier;

    final pref = await UserPreference.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (pref == null) return ['General'];

    try {
      return List<String>.from(jsonDecode(pref.categories) as List);
    } catch (e) {
      return ['General'];
    }
  }

  /// Get trending posts by category
  Future<List<Post>> getTrendingByCategory(
    Session session, {
    required String category,
    int limit = 20,
  }) async {
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    return await Post.db.find(
      session,
      where: (t) =>
          t.category.equals(category) &
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
      orderBy: (t) => t.viewCount.desc(),
      limit: limit,
      include: Post.include(author: UserRegistration.include()),
    );
  }

  /// Returns a view-ranked feed with a recent-post tie breaker.
  Future<List<Post>> getTrendingFeed(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    return Post.db.find(
      session,
      where: (t) =>
          (t.audience.equals('everyone') | t.userId.equals(userId)) |
          (sharedPostIds.isEmpty ? t.id.equals(-1) : t.id.inSet(sharedPostIds)),
      orderBy: (t) => t.viewCount.desc(),
      limit: limit,
      offset: offset,
      include: Post.include(author: UserRegistration.include()),
    );
  }

  /// Get posts for user's preferred categories
  Future<List<Post>> getPersonalizedFeed(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final preferences = await getUserPreferences(session);
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);

    final posts = await Post.db.find(
      session,
      where: (t) =>
          t.category.inSet(preferences.toSet()) &
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
      include: Post.include(author: UserRegistration.include()),
    );

    return posts;
  }
}
