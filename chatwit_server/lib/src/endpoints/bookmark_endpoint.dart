import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/post_visibility.dart';

class BookmarkEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<bool> toggleBookmark(Session session, int postId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    final userId = authInfo.userIdentifier;
    final post = await findVisiblePost(session, postId, userId);
    if (post == null) return false;

    final existing = await Bookmark.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.postId.equals(postId),
    );

    if (existing != null) {
      await Bookmark.db.deleteRow(session, existing);
      return false; // Removed
    } else {
      final bookmark = Bookmark(
        userId: userId,
        postId: postId,
        createdAt: DateTime.now(),
      );
      await Bookmark.db.insertRow(session, bookmark);

      // Log interaction
      await PostInteraction.db.insertRow(
        session,
        PostInteraction(
          userId: userId,
          postId: postId,
          interactionType: 'bookmark',
          createdAt: DateTime.now(),
        ),
      );

      return true; // Added
    }
  }

  Future<List<Post>> getBookmarkedPosts(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw Exception('You must login first');

    final userId = authInfo.userIdentifier;
    final sharedPostIds = await getSharedPostIds(session, userId);

    final bookmarks = await Bookmark.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt.desc(),
    );

    final postIds = bookmarks.map((b) => b.postId).toList();
    if (postIds.isEmpty) return [];

    return await Post.db.find(
      session,
      where: (t) =>
          t.id.inSet(postIds.toSet()) &
          ((t.audience.equals('everyone') | t.userId.equals(userId)) |
              (sharedPostIds.isEmpty
                  ? t.id.equals(-1)
                  : t.id.inSet(sharedPostIds))),
    );
  }

  Future<bool> isBookmarked(Session session, int postId) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final userId = authInfo.userIdentifier;
    if (await findVisiblePost(session, postId, userId) == null) return false;
    final existing = await Bookmark.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.postId.equals(postId),
    );
    return existing != null;
  }
}
