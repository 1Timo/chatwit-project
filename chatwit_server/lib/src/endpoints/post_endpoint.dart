import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/storage_config.dart';
import '../services/post_visibility.dart';

class PostEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ── Create a new post ──────────────────────────────────────────────────
  Future<bool> createPost(
    Session session,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? category,
    String? location,
    String? audience,
    List<String>? sharedWithUserIds,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final postAudience = audience ?? 'everyone';
    if (!{'everyone', 'followers', 'only_me'}.contains(postAudience)) {
      throw ArgumentError.value(audience, 'audience', 'Unsupported audience');
    }
    final selectedFollowers = (sharedWithUserIds ?? <String>[])
        .where((id) => id != authInfo.userIdentifier)
        .toSet();
    if (postAudience == 'followers' && selectedFollowers.isEmpty) {
      throw ArgumentError('Select at least one follower to share with.');
    }
    if (postAudience != 'followers' && selectedFollowers.isNotEmpty) {
      throw ArgumentError(
        'Follower recipients require the followers audience.',
      );
    }
    if (selectedFollowers.isNotEmpty) {
      final actualFollowers = await Follow.db.find(
        session,
        where: (t) =>
            t.followingId.equals(authInfo.userIdentifier) &
            t.followerId.inSet(selectedFollowers),
      );
      if (actualFollowers.map((follow) => follow.followerId).toSet().length !=
          selectedFollowers.length) {
        throw ArgumentError(
          'One or more selected users are not your followers.',
        );
      }
    }

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );

    final String userName = registration?.username ?? 'Unknown';
    final String fullName = registration != null
        ? "${registration.firstName} ${registration.surname}"
        : userName;

    // FALLBACK LOGIC: 1. Registration 2. Auth Profile
    String? profileImageUrl = registration?.profileImageUrl;
    if (profileImageUrl == null || profileImageUrl.isEmpty) {
      final authProfile = await const UserProfiles()
          .maybeFindUserProfileByUserId(session, authInfo.authUserId);
      profileImageUrl = authProfile?.imageUrl?.toString();
    }

    // Convert relative path to full public URL
    if (profileImageUrl != null && !profileImageUrl.startsWith('http')) {
      profileImageUrl = await _getPublicUrlSafe(session, profileImageUrl);
    }

    String? finalImageUrl;
    String? finalVideoUrl;

    if (imageUrl != null) {
      finalImageUrl = await _getPublicUrlSafe(session, imageUrl);
    }

    if (videoUrl != null) {
      finalVideoUrl = await _getPublicUrlSafe(session, videoUrl);
    }

    final post = Post(
      userId: authInfo.authUserId.toString(),
      author: registration,
      userName: userName,
      fullName: fullName,
      profileImageUrl: profileImageUrl,
      text: text ?? '',
      imageUrl: finalImageUrl,
      videoUrl: finalVideoUrl,
      category: category ?? 'General',
      location: location,
      audience: postAudience,
      createdAt: DateTime.now(),
    );

    final createdPost = await Post.db.insertRow(session, post);
    if (postAudience == 'followers') {
      for (final userId in selectedFollowers) {
        await PostShare.db.insertRow(
          session,
          PostShare(postId: createdPost.id!, userId: userId),
        );
      }
    } else if (postAudience == 'everyone') {
      await _indexTextEntities(session, createdPost, createdPost.text ?? '');
    }
    return true;
  }

  Future<void> _indexTextEntities(
    Session session,
    Post post,
    String text,
  ) async {
    final entities = _extractHashtagsAndMentions(text);
    for (final tag in entities['hashtags']!.toSet()) {
      await Hashtag.db.insertRow(
        session,
        Hashtag(tag: tag, postId: post.id!, createdAt: DateTime.now()),
      );
    }
    for (final username in entities['mentions']!.toSet()) {
      final mentionedUser = await UserRegistration.db.findFirstRow(
        session,
        where: (t) => t.username.equals(username),
      );
      final mentionedUserId = mentionedUser?.authUserId.toString();
      if (mentionedUserId == null || mentionedUserId == post.userId) continue;
      await Mention.db.insertRow(
        session,
        Mention(
          userId: mentionedUserId,
          postId: post.id!,
          createdAt: DateTime.now(),
        ),
      );
      await UserNotification.db.insertRow(
        session,
        UserNotification(
          userId: mentionedUserId,
          title: 'You were mentioned',
          body: '${post.userName ?? 'A user'} mentioned you in a post.',
          type: 'mention',
          relatedUserId: post.userId,
          relatedPostId: post.id,
          isRead: false,
          createdAt: DateTime.now(),
        ),
      );
    }
  }

  // ── Retrieval Methods ───────────────────────────────
  Future<List<Post>> getAllPosts(Session session) async {
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    return await Post.db.find(
      session,
      where: (t) =>
          (t.audience.equals('everyone') | t.userId.equals(userId)) |
          (sharedPostIds.isEmpty ? t.id.equals(-1) : t.id.inSet(sharedPostIds)),
      orderBy: (t) => t.createdAt.desc(),
      include: Post.include(author: UserRegistration.include()),
    );
  }

  Future<List<Post>> getPaginatedPosts(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    final posts = await Post.db.find(
      session,
      where: (t) =>
          (t.audience.equals('everyone') | t.userId.equals(userId)) |
          (sharedPostIds.isEmpty ? t.id.equals(-1) : t.id.inSet(sharedPostIds)),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
      include: Post.include(author: UserRegistration.include()),
    );
    return _enrichPosts(session, posts);
  }

  Future<List<Post>> getUserPosts(Session session, String userId) async {
    final viewerId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, viewerId);
    final posts = await Post.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          ((t.audience.equals('everyone') | t.userId.equals(viewerId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
      orderBy: (t) => t.createdAt.desc(),
      include: Post.include(author: UserRegistration.include()),
    );
    return _enrichPosts(session, posts);
  }

  // ── Post Management ──────────────────────────────────────────────
  Future<bool> editPost(Session session, int postId, String newText) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    final existing = await Post.db.findById(session, postId);
    if (existing == null) return false;

    if (existing.userId != authInfo.authUserId.toString()) {
      throw Exception('Not authorized to edit this post');
    }

    existing.text = newText;
    await Post.db.updateRow(session, existing);
    await Hashtag.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Mention.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    if (existing.audience == 'everyone') {
      await _indexTextEntities(session, existing, newText);
    }
    return true;
  }

  /// Deletes a post and all its related records.
  /// Idempotent: Returns true even if post doesn't exist.
  Future<bool> deletePost(Session session, int postId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    final existing = await Post.db.findById(session, postId);
    if (existing == null) {
      session.log(
        'Delete target $postId already gone. Returning success.',
        level: LogLevel.info,
      );
      return true;
    }

    final myId = authInfo.authUserId.toString();
    if (existing.userId != myId) {
      throw Exception('Not authorized to delete this post');
    }

    await Like.db.deleteWhere(session, where: (t) => t.postId.equals(postId));
    await Comment.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Bookmark.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await PostInteraction.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Hashtag.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Mention.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await PostShare.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Hashtag.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Mention.db.deleteWhere(
      session,
      where: (t) => t.postId.equals(postId),
    );
    await Post.db.deleteRow(session, existing);
    return true;
  }

  // ── Engagement & Metrics ───────────────────────────────────────────
  Future<bool> toggleLike(Session session, int postId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    final userId = authInfo.userIdentifier;
    final post = await _findVisiblePost(session, postId);
    if (post == null) return false;
    final existing = await Like.db.findFirstRow(
      session,
      where: (t) => t.postId.equals(postId) & t.userId.equals(userId),
    );

    if (existing != null) {
      await Like.db.deleteRow(session, existing);
      await _logPostInteraction(session, postId, 'unlike');
      return false;
    } else {
      final like = Like(
        postId: postId,
        userId: userId,
        createdAt: DateTime.now(),
      );
      await Like.db.insertRow(session, like);

      if (post.userId != userId) {
        await UserNotification.db.insertRow(
          session,
          UserNotification(
            userId: post.userId,
            title: 'New like',
            body: '${authInfo.userIdentifier} liked your post.',
            type: 'like',
            relatedUserId: userId,
            relatedPostId: postId,
            isRead: false,
            createdAt: DateTime.now(),
          ),
        );
      }

      await _logPostInteraction(
        session,
        postId,
        'like',
        category: post.category,
        targetUserId: post.userId,
      );
      return true;
    }
  }

  Future<List<Like>> getLikes(Session session, int postId) async {
    if (await _findVisiblePost(session, postId) == null) return [];
    return await Like.db.find(session, where: (t) => t.postId.equals(postId));
  }

  Future<void> incrementViewCount(Session session, int postId) async {
    await batchIncrementViewCounts(session, [postId]);
  }

  Future<void> batchIncrementViewCounts(
    Session session,
    List<int> postIds,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;

    final userId = authInfo.userIdentifier;
    final today = DateTime.now().toIso8601String().substring(0, 10);

    for (final postId in postIds) {
      final dedupeKey = 'v_dedupe:$today:$userId:$postId';
      final alreadyViewed = await session.caches.global.get<String>(dedupeKey);
      if (alreadyViewed != null) continue;

      await session.caches.global.put(
        dedupeKey,
        '1',
        lifetime: const Duration(hours: 24),
      );

      final post = await _findVisiblePost(session, postId);
      if (post != null) {
        post.viewCount++;
        await Post.db.updateRow(session, post);
        await _logPostInteraction(
          session,
          postId,
          'view',
          category: post.category,
          targetUserId: post.userId,
        );
      }
    }
  }

  Future<void> logInteraction(
    Session session,
    String? category,
    int score, {
    String? targetUserId,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;

    await UserInteraction.db.insertRow(
      session,
      UserInteraction(
        userId: authInfo.userIdentifier,
        category: category,
        targetUserId: targetUserId,
        score: score,
        createdAt: DateTime.now(),
      ),
    );
  }

  // ── Unified Interaction Logging ───────────────────────────────────────────
  Future<void> _logPostInteraction(
    Session session,
    int postId,
    String type, {
    String? category,
    String? targetUserId,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;

    await PostInteraction.db.insertRow(
      session,
      PostInteraction(
        userId: authInfo.userIdentifier,
        postId: postId,
        interactionType: type,
        createdAt: DateTime.now(),
      ),
    );

    int score = 0;
    switch (type) {
      case 'view':
        score = 1;
        break;
      case 'comment':
        score = 3;
        break;
      case 'bookmark':
        score = 3;
        break;
      case 'repost':
        score = 4;
        break;
      case 'like':
        score = 5;
        break;
      case 'click_interested':
        score = 10;
        break;
      case 'click_not_interested':
        score = -20;
        break;
      case 'unlike':
        score = -5;
        break;
    }

    if (score != 0) {
      await UserInteraction.db.insertRow(
        session,
        UserInteraction(
          userId: authInfo.userIdentifier,
          category: category,
          targetUserId: targetUserId,
          score: score,
          createdAt: DateTime.now(),
        ),
      );
    }
  }

  Future<List<Post>> getRecommendedFeed(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      return await getPaginatedPosts(session, limit: limit, offset: offset);
    }

    final userId = authInfo.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);

    final interactions = await UserInteraction.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final Map<String, int> categoryScores = {};
    final Map<String, int> authorScores = {};
    final savedPreferences = await UserPreference.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final selectedCategories = savedPreferences == null
        ? <String>{}
        : (jsonDecode(savedPreferences.categories) as List<dynamic>)
              .whereType<String>()
              .toSet();

    for (var i in interactions) {
      if (i.category != null) {
        categoryScores[i.category!] =
            (categoryScores[i.category!] ?? 0) + i.score;
      }
      if (i.targetUserId != null) {
        authorScores[i.targetUserId!] =
            (authorScores[i.targetUserId!] ?? 0) + i.score;
      }
    }

    final blacklisted = categoryScores.entries
        .where((e) => e.value < -10)
        .map((e) => e.key)
        .toSet();
    final preferredCats = categoryScores.entries
        .where((e) => e.value > 5)
        .map((e) => e.key)
        .toSet();
    final preferredAuthors = authorScores.entries
        .where((e) => e.value > 5)
        .map((e) => e.key)
        .toSet();

    final posts = await Post.db.find(
      session,
      where: (t) =>
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))) &
          (selectedCategories.isNotEmpty
              ? t.category.inSet(selectedCategories) &
                    (blacklisted.isNotEmpty
                        ? t.category.notInSet(blacklisted)
                        : t.id.notEquals(-1))
              : (blacklisted.isNotEmpty
                    ? t.category.notInSet(blacklisted)
                    : t.id.notEquals(-1))),
      orderBy: (t) => t.createdAt.desc(),
      limit: 200,
      include: Post.include(author: UserRegistration.include()),
    );

    posts.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;
      if (selectedCategories.contains(a.category)) scoreA += 20;
      if (selectedCategories.contains(b.category)) scoreB += 20;
      if (preferredCats.contains(a.category)) scoreA += 10;
      if (preferredCats.contains(b.category)) scoreB += 10;
      if (preferredAuthors.contains(a.userId)) scoreA += 15;
      if (preferredAuthors.contains(b.userId)) scoreB += 15;

      if (scoreA != scoreB) return scoreB.compareTo(scoreA);
      return b.createdAt.compareTo(a.createdAt);
    });

    final paginated = posts.skip(offset).take(limit).toList();
    return _enrichPosts(session, paginated);
  }

  // ── Comments ────────────────────────────────────────────
  Future<bool> createComment(
    Session session,
    int postId,
    String? text,
    String? imageUrl,
    String? videoUrl,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');
    final post = await _findVisiblePost(session, postId);
    if (post == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    final String userName = registration?.username ?? 'Unknown';
    final String fullName = registration != null
        ? "${registration.firstName} ${registration.surname}"
        : userName;

    // FALLBACK LOGIC: 1. Registration 2. Auth Profile
    String? profileImageUrl = registration?.profileImageUrl;
    if (profileImageUrl == null || profileImageUrl.isEmpty) {
      final authProfile = await const UserProfiles()
          .maybeFindUserProfileByUserId(session, authInfo.authUserId);
      profileImageUrl = authProfile?.imageUrl?.toString();
    }

    if (profileImageUrl != null && !profileImageUrl.startsWith('http')) {
      profileImageUrl = await _getPublicUrlSafe(session, profileImageUrl);
    }

    String? finalImageUrl;
    String? finalVideoUrl;
    if (imageUrl != null) {
      finalImageUrl = await _getPublicUrlSafe(session, imageUrl);
    }
    if (videoUrl != null) {
      finalVideoUrl = await _getPublicUrlSafe(session, videoUrl);
    }

    final comment = Comment(
      postId: postId,
      userId: authInfo.authUserId.toString(),
      author: registration,
      userName: userName,
      fullName: fullName,
      profileImageUrl: profileImageUrl,
      text: text,
      imageUrl: finalImageUrl,
      videoUrl: finalVideoUrl,
      createdAt: DateTime.now(),
    );

    await Comment.db.insertRow(session, comment);

    if (post.userId != authInfo.userIdentifier) {
      await UserNotification.db.insertRow(
        session,
        UserNotification(
          userId: post.userId,
          title: 'New comment',
          body: '${registration?.username ?? 'A user'} commented on your post.',
          type: 'comment',
          relatedUserId: authInfo.userIdentifier,
          relatedPostId: postId,
          isRead: false,
          createdAt: DateTime.now(),
        ),
      );
    }
    await _logPostInteraction(
      session,
      postId,
      'comment',
      category: post.category,
      targetUserId: post.userId,
    );
    return true;
  }

  Future<List<Comment>> getComments(Session session, int postId) async {
    if (await _findVisiblePost(session, postId) == null) return [];
    final comments = await Comment.db.find(
      session,
      where: (t) => t.postId.equals(postId),
      orderBy: (t) => t.createdAt,
      include: Comment.include(author: UserRegistration.include()),
    );
    return _enrichComments(session, comments);
  }

  Future<bool> editComment(
    Session session,
    int commentId,
    String newText,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');
    final existing = await Comment.db.findById(session, commentId);
    if (existing == null || existing.userId != authInfo.authUserId.toString()) {
      return false;
    }
    existing.text = newText;
    await Comment.db.updateRow(session, existing);
    return true;
  }

  Future<bool> deleteComment(Session session, int commentId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');
    final existing = await Comment.db.findById(session, commentId);
    if (existing == null || existing.userId != authInfo.authUserId.toString()) {
      return false;
    }
    await Comment.db.deleteRow(session, existing);
    return true;
  }

  // ── Utilities ────────────────────────────────────────────
  Future<List<Post>> searchPosts(Session session, String keyword) async {
    if (keyword.isEmpty) return [];
    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    final posts = await Post.db.find(
      session,
      where: (t) =>
          t.text.ilike('%$keyword%') &
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
      orderBy: (t) => t.createdAt.desc(),
      limit: 20,
      include: Post.include(author: UserRegistration.include()),
    );
    return _enrichPosts(session, posts);
  }

  Future<bool> verifyUpload(Session session, String path) async =>
      await session.storage.verifyUpload(storageId: 'public', path: path);
  Future<String?> getUploadDescription(Session session, String path) async =>
      await session.storage.createUploadDescription(
        storageId: 'public',
        path: path,
      );

  Future<List<Post>> _enrichPosts(Session session, List<Post> posts) async {
    for (var post in posts) {
      if (post.author != null) {
        post.fullName = "${post.author!.firstName} ${post.author!.surname}";

        String? profileUrl = post.author!.profileImageUrl;
        if (profileUrl == null || profileUrl.isEmpty) {
          final authProfile = await const UserProfiles()
              .maybeFindUserProfileByUserId(
                session,
                UuidValue.fromString(post.userId),
              );
          profileUrl = authProfile?.imageUrl?.toString();
        }

        if (profileUrl != null && !profileUrl.startsWith('http')) {
          profileUrl = await _getPublicUrlSafe(session, profileUrl);
        }
        post.profileImageUrl = profileUrl;
      }
    }
    return posts;
  }

  Future<Post?> _findVisiblePost(Session session, int postId) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) return null;
    return findVisiblePost(session, postId, userId);
  }

  Future<List<Comment>> _enrichComments(
    Session session,
    List<Comment> comments,
  ) async {
    for (var comment in comments) {
      if (comment.author != null) {
        comment.fullName =
            "${comment.author!.firstName} ${comment.author!.surname}";

        String? profileUrl = comment.author!.profileImageUrl;
        if (profileUrl == null || profileUrl.isEmpty) {
          final authProfile = await const UserProfiles()
              .maybeFindUserProfileByUserId(
                session,
                UuidValue.fromString(comment.userId),
              );
          profileUrl = authProfile?.imageUrl?.toString();
        }

        if (profileUrl != null && !profileUrl.startsWith('http')) {
          profileUrl = await _getPublicUrlSafe(session, profileUrl);
        }
        comment.profileImageUrl = profileUrl;
      }
    }
    return comments;
  }

  Future<void> logRecommendationFeedback(
    Session session,
    int postId,
    bool interested,
  ) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) return;
    final post = await _findVisiblePost(session, postId);
    await _logPostInteraction(
      session,
      postId,
      interested ? 'click_interested' : 'click_not_interested',
      category: post?.category,
      targetUserId: post?.userId,
    );
  }

  /// Extract hashtags and mentions from text
  Map<String, List<String>> _extractHashtagsAndMentions(String text) {
    final hashtags = <String>[];
    final mentions = <String>[];

    // Extract hashtags (#word)
    final hashtagRegex = RegExp(r'#\w+');
    for (final match in hashtagRegex.allMatches(text)) {
      hashtags.add(match.group(0)!.substring(1).toLowerCase()); // Remove #
    }

    // Extract mentions (@word)
    final mentionRegex = RegExp(r'@\w+');
    for (final match in mentionRegex.allMatches(text)) {
      mentions.add(match.group(0)!.substring(1).toLowerCase()); // Remove @
    }

    return {'hashtags': hashtags, 'mentions': mentions};
  }

  /// Get posts by hashtag
  Future<List<Post>> getPostsByHashtag(
    Session session, {
    required String tag,
    int limit = 20,
    int offset = 0,
  }) async {
    final hashtags = await Hashtag.db.find(
      session,
      where: (t) => t.tag.equals(tag.toLowerCase()),
      limit: 1000, // Get all post IDs for this hashtag
    );

    final postIds = hashtags.map((h) => h.postId).toList();
    if (postIds.isEmpty) return [];

    final userId = session.authenticated!.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);
    return await Post.db.find(
      session,
      where: (t) =>
          t.id.inSet(postIds.toSet()) &
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
      include: Post.include(author: UserRegistration.include()),
    );
  }

  /// Get trending hashtags
  Future<List<String>> getTrendingHashtags(
    Session session, {
    int limit = 10,
  }) async {
    final hashtags = await Hashtag.db.find(session);

    // Count occurrences
    final tagCounts = <String, int>{};
    for (final h in hashtags) {
      tagCounts[h.tag] = (tagCounts[h.tag] ?? 0) + 1;
    }

    // Sort by count and return top
    final sorted = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(limit).map((e) => e.key).toList();
  }

  /// Helper to safely get public storage URL without crashing on network/DNS errors
  Future<String?> _getPublicUrlSafe(Session session, String path) async {
    // Use centralized, env-driven storage configuration
    final config = StorageConfig.fromEnvironment();
    return config.getPublicUrl(path);
  }
}
