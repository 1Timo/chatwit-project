import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/features/post_card.dart';

class HashtagFeedScreen extends StatelessWidget {
  const HashtagFeedScreen({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('#$tag')),
      body: FutureBuilder<List<Post>>(
        future: client.post.getPostsByHashtag(tag: tag, limit: 30, offset: 0),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load posts for this hashtag.'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!;
          if (posts.isEmpty) {
            return const Center(child: Text('No posts use this hashtag yet.'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(post: posts[index]),
          );
        },
      ),
    );
  }
}
