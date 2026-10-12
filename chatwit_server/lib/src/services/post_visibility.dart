import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

Future<Set<int>> getSharedPostIds(Session session, String userId) async {
  final shares = await PostShare.db.find(
    session,
    where: (t) => t.userId.equals(userId),
  );
  return shares.map((share) => share.postId).toSet();
}

Future<bool> canViewPost(
  Session session,
  Post post,
  String viewerId,
) async {
  if (post.audience == 'everyone' || post.userId == viewerId) return true;
  if (post.audience != 'followers' || post.id == null) return false;

  final share = await PostShare.db.findFirstRow(
    session,
    where: (t) =>
        t.postId.equals(post.id!) & t.userId.equals(viewerId),
  );
  return share != null;
}

Future<Post?> findVisiblePost(
  Session session,
  int postId,
  String viewerId,
) async {
  final post = await Post.db.findById(session, postId);
  if (post == null || !await canViewPost(session, post, viewerId)) return null;
  return post;
}
