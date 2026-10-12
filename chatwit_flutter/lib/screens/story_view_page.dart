import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:chatwit_flutter/core/client.dart';

class StoryViewPage extends StatefulWidget {
  final List<Story> stories;
  final String? ownerUserId;

  const StoryViewPage({
    super.key,
    required this.stories,
    this.ownerUserId,
  });

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final storyController = StoryController();
  bool _isDeleting = false;
  int _currentStoryIndex = 0;

  bool get _canDelete {
    final userId = authManager.authInfo?.authUserId.toString();
    return userId != null &&
        userId == widget.ownerUserId &&
        widget.stories.isNotEmpty;
  }

  Future<void> _deleteCurrentStory() async {
    if (_isDeleting || !_canDelete) return;

    final currentStory = widget.stories[_currentStoryIndex];
    final storyId = currentStory.id;
    if (storyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This story cannot be deleted yet.')),
      );
      return;
    }

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete story?'),
        content: const Text('This story will be removed for everyone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete != true || !mounted) return;

    setState(() => _isDeleting = true);
    try {
      final deleted = await client.story.deleteStory(storyId);
      if (!mounted) return;
      if (!deleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not delete this story.')),
        );
        return;
      }

      Navigator.pop(context, storyId);
    } catch (error) {
      debugPrint('Could not delete story $storyId: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not delete this story.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItems = widget.stories.map((story) {
      if (story.mediaType == 'video') {
        return StoryItem.pageVideo(
          story.mediaUrl,
          controller: storyController,
          duration: const Duration(seconds: 15),
        );
      } else {
        return StoryItem.pageImage(
          url: story.mediaUrl,
          controller: storyController,
        );
      }
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          StoryView(
            storyItems: storyItems,
            controller: storyController,
            onStoryShow: (storyItem, index) {
              _currentStoryIndex = index;
            },
            onComplete: () {
              Navigator.pop(context);
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
          ),
          if (_canDelete)
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              right: 12,
              child: IconButton(
                tooltip: 'Delete story',
                onPressed: _isDeleting ? null : _deleteCurrentStory,
                icon: _isDeleting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.delete_outline, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
