import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/features/post_card.dart';
import 'package:chatwit_flutter/screens/create_post_screen.dart';

class FeedContentTab extends StatefulWidget {
  const FeedContentTab({super.key});

  @override
  State<FeedContentTab> createState() => _FeedContentTabState();
}

class _FeedContentTabState extends State<FeedContentTab> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    setState(() => _isLoading = true);
    try {
      final posts = await client.post.getAllPosts();
      if (!mounted) return;
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading feed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatwit"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadFeed),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await authManager.signOutDevice(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadFeed,
        color: const Color(0xFF9E9E9E),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _posts.isEmpty
            ? const Center(child: Text('No posts yet.'))
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: _posts[index]);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostScreen()),
          );
          _loadFeed();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
