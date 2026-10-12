import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/features/post_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Post> _bookmarkedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    setState(() => _isLoading = true);
    try {
      final posts = await client.bookmark.getBookmarkedPosts();
      if (!mounted) return;
      setState(() {
        _bookmarkedPosts = posts;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading bookmarks: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarkedPosts.isEmpty
          ? const Center(child: Text('Your bookmarked posts will appear here.'))
          : ListView.builder(
              itemCount: _bookmarkedPosts.length,
              itemBuilder: (context, index) {
                return PostCard(post: _bookmarkedPosts[index]);
              },
            ),
    );
  }
}
