import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/server_url.dart';
import 'package:chatwit_flutter/core/share_links.dart';
import 'package:chatwit_flutter/core/post_view_tracker.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/features/follower_post_share_sheet.dart';
import 'package:chatwit_flutter/core/post_share_message.dart';
import 'package:chatwit_flutter/screens/chatscreen.dart';
import 'package:chatwit_flutter/screens/profile_screen.dart';
import 'package:chatwit_flutter/screens/hashtag_feed_screen.dart';
import 'package:chatwit_flutter/widgets/fullscreen_image_viewer.dart';
import 'package:chatwit_flutter/widgets/fullscreen_video_player.dart';
import 'package:chatwit_flutter/core/feed_provider.dart';

class PostCard extends ConsumerStatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    this.status = PostStatus.success,
    this.localImagePath,
    this.localVideoPath,
  });

  final Post post;
  final PostStatus status;
  final String? localImagePath;
  final String? localVideoPath;

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool _isLiked = false;
  int _likeCount = 0;
  bool _isBookmarked = false;
  bool _isDeleted = false;
  late String _postText;
  VideoPlayerController? _videoPlayerController;
  bool _videoInitializationStarted = false;
  bool _videoFailedToLoad = false;
  Timer? _viewTimer;
  bool _isViewTracked = false;
  final List<TapGestureRecognizer> _authorRecognizers = [];

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inSeconds < 60) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${time.day}/${time.month}/${time.year.toString().substring(2)}';
  }

  @override
  void initState() {
    super.initState();
    _postText = widget.post.text ?? '';
    _loadLikes();
    _loadBookmarkStatus();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _viewTimer?.cancel();
    // Dispose entity tap recognizers with this card.
    for (final recognizer in _entityRecognizers) {
      recognizer.dispose();
    }
    for (final recognizer in _authorRecognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.1) {
      _initVideoIfNeeded();
    } else if (_videoPlayerController?.value.isInitialized ?? false) {
      _videoPlayerController!.pause();
    }

    if (_isViewTracked || widget.status != PostStatus.success) return;
    if (info.visibleFraction >= 0.5) {
      if (_viewTimer == null || !_viewTimer!.isActive) {
        _viewTimer = Timer(const Duration(seconds: 2), () {
          if (mounted) _trackView();
        });
      }
    } else {
      _viewTimer?.cancel();
    }
  }

  void _trackView() {
    if (_isViewTracked) return;
    _isViewTracked = true;
    PostViewTracker.instance.trackView(widget.post.id!);
  }

  Future<void> _loadBookmarkStatus() async {
    if (widget.post.id! < 0) return; // Optimistic post
    try {
      final bookmarked = await client.bookmark.isBookmarked(widget.post.id!);
      if (mounted) setState(() => _isBookmarked = bookmarked);
    } catch (e) {
      debugPrint('Error loading bookmark status: $e');
    }
  }

  void _initVideoIfNeeded() {
    if (_videoInitializationStarted) return;
    final videoUrl = widget.localVideoPath ?? widget.post.videoUrl;
    if (videoUrl != null && videoUrl.isNotEmpty) {
      _videoInitializationStarted = true;
      if (widget.localVideoPath != null) {
        _videoPlayerController =
            VideoPlayerController.file(File(widget.localVideoPath!))
              ..initialize()
                  .then((_) {
                    if (mounted) setState(() {});
                  })
                  .catchError((Object error) {
                    debugPrint('Error loading post video: $error');
                    _videoFailedToLoad = true;
                    if (mounted) setState(() {});
                  });
      } else {
        final formattedUrl = _getMediaUrl(videoUrl);
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(formattedUrl))
              ..initialize()
                  .then((_) {
                    if (mounted) setState(() {});
                  })
                  .catchError((Object error) {
                    debugPrint('Error loading post video: $error');
                    _videoFailedToLoad = true;
                    if (mounted) setState(() {});
                  });
      }
    }
  }

  String _getMediaUrl(String path) {
    return ServerUrl.resolveMediaUrl(path);
  }

  Future<void> _loadLikes() async {
    if (widget.post.id! < 0) return; // Optimistic post
    try {
      final likes = await client.post.getLikes(widget.post.id!);
      if (mounted) setState(() => _likeCount = likes.length);
    } catch (e) {
      debugPrint('Error loading likes: $e');
    }
  }

  Future<void> _toggleLike() async {
    try {
      final success = await client.post.toggleLike(widget.post.id!);
      if (!mounted) return;
      setState(() {
        if (success) {
          _isLiked = true;
          _likeCount++;
          client.post.logInteraction(widget.post.category ?? 'General', 2);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Liked'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          _isLiked = false;
          _likeCount--;
        }
      });
    } catch (e) {
      debugPrint('Error toggling like: $e');
    }
  }

  Future<void> _toggleBookmark() async {
    try {
      final nowBookmarked = await client.bookmark.toggleBookmark(
        widget.post.id!,
      );
      if (mounted) {
        setState(() => _isBookmarked = nowBookmarked);
        if (nowBookmarked) {
          client.post.logInteraction(
            widget.post.category,
            3,
            targetUserId: widget.post.userId,
          );
        }
      }
    } catch (e) {
      debugPrint('Error toggling bookmark: $e');
    }
  }

  void _showEditDialog() {
    final TextEditingController editController = TextEditingController(
      text: _postText,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: editController,
          maxLines: null,
          decoration: const InputDecoration(hintText: 'Edit your post...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newText = editController.text.trim();
              if (newText.isEmpty) return;
              Navigator.pop(context);
              await _editPost(newText);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editPost(String newText) async {
    try {
      final success = await client.post.editPost(widget.post.id!, newText);
      if (mounted && success) setState(() => _postText = newText);
    } catch (e) {
      debugPrint('Error editing post: $e');
    }
  }

  Future<void> _deletePost() async {
    try {
      final success = await client.post.deletePost(widget.post.id!);
      if (success && mounted) {
        // Update the global feed state so it doesn't reappear on refresh
        ref.read(feedProvider.notifier).removePost(widget.post.id);

        setState(() => _isDeleted = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully')),
        );
      }
    } catch (e) {
      debugPrint('Error deleting post: $e');
    }
  }

  Future<void> _performRepost() async {
    try {
      await client.post.createPost(
        'Repost: $_postText',
        null,
        null,
        widget.post.category ?? 'General',
        null,
        'everyone',
        const [],
      );
      client.post.logInteraction(
        widget.post.category,
        4,
        targetUserId: widget.post.userId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reposted'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error performing repost: $e');
    }
  }

  void _showRepostOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text('Repost Instantly'),
              onTap: () {
                Navigator.pop(context);
                _performRepost();
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('Create New Post'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/create-post');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('Share to Followers'),
              onTap: () {
                Navigator.pop(context);
                unawaited(_shareToFollowers());
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
              onTap: () async {
                Navigator.pop(context);
                await _copyPostLink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareToFollowers() async {
    try {
      final recipients = await showModalBottomSheet<List<UserRegistration>>(
        context: context,
        isScrollControlled: true,
        builder: (_) => const FollowerPostShareSheet(),
      );

      if (recipients == null || recipients.isEmpty || !mounted) return;

      final message = PostShareMessage.encode(widget.post);
      final sentRecipients = <UserRegistration>[];
      var failedCount = 0;
      for (final recipient in recipients) {
        try {
          await client.chat.sendMessage(
            recipient.authUserId.toString(),
            message,
          );
          sentRecipients.add(recipient);
        } catch (error) {
          failedCount++;
          debugPrint(
            'Could not share post with ${recipient.authUserId}: $error',
          );
        }
      }

      if (!mounted) return;
      if (sentRecipients.isEmpty) {
        _showShareError('Could not send the post. Please try again.');
        return;
      }

      try {
        await client.post.logInteraction(
          widget.post.category,
          3,
          targetUserId: widget.post.userId,
        );
      } catch (error) {
        debugPrint('Could not log post share interaction: $error');
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            failedCount == 0
                ? 'Post sent to ${sentRecipients.length} '
                      '${sentRecipients.length == 1 ? 'follower' : 'followers'}'
                : 'Post sent to ${sentRecipients.length}; '
                      '$failedCount failed.',
          ),
        ),
      );
      final firstRecipient = sentRecipients.first;
      final firstRecipientName =
          '${firstRecipient.firstName} ${firstRecipient.surname}'.trim();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            userId: firstRecipient.authUserId.toString(),
            userName: firstRecipientName.isEmpty
                ? '@${firstRecipient.username}'
                : firstRecipientName,
            profileImageUrl: firstRecipient.profileImageUrl ?? '',
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error loading followers or sharing post: $e');
      if (mounted) {
        _showShareError('Could not share the post. Please try again.');
      }
    }
  }

  Future<void> _copyPostLink() async {
    try {
      final postId = widget.post.id;
      if (postId == null) {
        throw StateError('This post does not have a shareable link yet.');
      }
      await Clipboard.setData(
        ClipboardData(text: ShareLinks.postUri(postId).toString()),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint('Error generating or copying post link: $e');
      _showShareError(
        e is StateError ? e.message : 'Could not copy the post link.',
      );
    }
  }

  void _showShareError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildPostContent() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 15,
          height: 1.3,
          color: Colors.black87,
        ),
        children: _buildEntitySpans(_postText),
      ),
    );
  }

  final List<TapGestureRecognizer> _entityRecognizers = [];

  List<InlineSpan> _buildEntitySpans(String text) {
    for (final recognizer in _entityRecognizers) {
      recognizer.dispose();
    }
    _entityRecognizers.clear();
    final spans = <InlineSpan>[];
    final matcher = RegExp(r'[#@][A-Za-z0-9_]+');
    var lastEnd = 0;
    for (final match in matcher.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      final entity = match.group(0)!;
      final recognizer = TapGestureRecognizer()
        ..onTap = () {
          if (entity.startsWith('#')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HashtagFeedScreen(tag: entity.substring(1)),
              ),
            );
          } else {
            _openMentionedProfile(entity.substring(1));
          }
        };
      _entityRecognizers.add(recognizer);
      spans.add(
        TextSpan(
          text: entity,
          style: const TextStyle(
            color: Color(0xFF374151),
            fontWeight: FontWeight.w500,
          ),
          recognizer: recognizer,
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }
    return spans;
  }

  Future<void> _openMentionedProfile(String username) async {
    try {
      final users = await client.userRegistration.searchUsers(username);
      if (!mounted) return;
      UserRegistration? user;
      for (final result in users) {
        if (result.username.toLowerCase() == username.toLowerCase()) {
          user = result;
          break;
        }
      }
      if (user == null) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: user!.authUserId.toString(),
            userName: '${user.firstName} ${user.surname}',
          ),
        ),
      );
    } catch (error) {
      debugPrint('Could not open mentioned profile: $error');
    }
  }

  TapGestureRecognizer _authorProfileRecognizer() {
    final recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileScreen(
              userId: widget.post.userId,
              userName:
                  widget.post.fullName ?? widget.post.userName ?? 'Unknown',
            ),
          ),
        );
      };
    _authorRecognizers.add(recognizer);
    return recognizer;
  }

  String _formatViewCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    if (_isDeleted) return const SizedBox.shrink();

    for (final recognizer in _authorRecognizers) {
      recognizer.dispose();
    }
    _authorRecognizers.clear();

    final isUploading = widget.status == PostStatus.uploading;
    final isFailed = widget.status == PostStatus.failed;

    return VisibilityDetector(
      key: Key('post-${widget.post.id}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[100]!, width: 0.5),
              ),
            ),
            child: Opacity(
              opacity: isUploading ? 0.6 : 1.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userId: widget.post.userId,
                          userName: widget.post.userName ?? 'Unknown',
                        ),
                      ),
                    ),
                    child: ChatwitImage.avatar(widget.post.profileImageUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          widget.post.fullName ??
                                          widget.post.userName ??
                                          'Unknown',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                      recognizer: _authorProfileRecognizer(),
                                    ),
                                    if (widget.post.location != null &&
                                        widget.post.location!.isNotEmpty) ...[
                                      const TextSpan(
                                        text: ' is at ',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.location,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                    TextSpan(
                                      text:
                                          ' @${widget.post.userName ?? 'user'}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      recognizer: _authorProfileRecognizer(),
                                    ),
                                    const TextSpan(
                                      text: ' • ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: _formatTime(widget.post.createdAt),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (!isUploading)
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditDialog();
                                  } else if (value == 'delete') {
                                    _deletePost();
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Unified Content Area
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_postText.isNotEmpty) _buildPostContent(),
                            if ((widget.post.imageUrl != null &&
                                    widget.post.imageUrl!.isNotEmpty) ||
                                widget.localImagePath != null) ...[
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImageViewer(
                                      imageUrl:
                                          widget.localImagePath ??
                                          widget.post.imageUrl!,
                                      tag: 'post-image-${widget.post.id}',
                                    ),
                                  ),
                                ),
                                child: Hero(
                                  tag:
                                      'post-image-${widget.post.id}-${identityHashCode(widget)}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: widget.localImagePath != null
                                        ? Image.file(
                                            File(widget.localImagePath!),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : ChatwitImage.image(
                                            widget.post.imageUrl!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    value:
                                                        loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                        : null,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (c, e, s) =>
                                                Container(
                                                  height: 100,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if ((widget.post.videoUrl?.isNotEmpty ?? false) ||
                            widget.localVideoPath != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: GestureDetector(
                              onTap: () {
                                if (!isUploading &&
                                    _videoPlayerController
                                            ?.value
                                            .isInitialized ==
                                        true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenVideoPlayer(
                                            controller: _videoPlayerController!,
                                            videoUrl: widget.post.videoUrl,
                                          ),
                                    ),
                                  );
                                }
                              },
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController?.value.aspectRatio ??
                                    16 / 9,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child:
                                          _videoPlayerController != null &&
                                              _videoPlayerController!
                                                  .value
                                                  .isInitialized
                                          ? VideoPlayer(_videoPlayerController!)
                                          : Container(
                                              color: Colors.black12,
                                              child: Icon(
                                                _videoFailedToLoad
                                                    ? Icons.error_outline
                                                    : Icons.video_library,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                    if (!isUploading)
                                      Icon(
                                        Icons.play_circle,
                                        size: 50,
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildIconAction(
                              icon: Icons.comment_outlined,
                              onTap: isUploading
                                  ? () {}
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) =>
                                            CommentBottomSheet(
                                              postId: widget.post.id!,
                                            ),
                                      );
                                    },
                            ),
                            _buildIconAction(
                              icon: Icons.repeat,
                              onTap: isUploading ? () {} : _showRepostOptions,
                            ),
                            _buildIconAction(
                              icon: _isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isLiked ? Colors.red : Colors.grey,
                              label: _likeCount > 0 ? '$_likeCount' : null,
                              onTap: isUploading ? () {} : () => _toggleLike(),
                            ),
                            _buildIconAction(
                              icon: Icons.bar_chart,
                              label:
                                  '${_formatViewCount(widget.post.viewCount)} views',
                              onTap: () {},
                            ),
                            _buildIconAction(
                              icon: Icons.share_outlined,
                              onTap: isUploading ? () {} : _showShareOptions,
                            ),
                            _buildIconAction(
                              icon: _isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: _isBookmarked
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                              onTap: isUploading
                                  ? () {}
                                  : () => _toggleBookmark(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUploading)
            const Positioned(
              top: 12,
              right: 12,
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          if (isFailed)
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                icon: const Icon(Icons.error_outline, color: Colors.red),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Upload failed. Check Drafts to retry.'),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconAction({
    required IconData icon,
    Color color = Colors.grey,
    String? label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            if (label != null) ...[
              const SizedBox(width: 4),
              Text(label, style: TextStyle(color: color, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}

class CommentTile extends StatefulWidget {
  const CommentTile({
    super.key,
    required this.comment,
    required this.onDeleted,
    this.localPreview,
  });
  final Comment comment;
  final VoidCallback onDeleted;
  final Uint8List? localPreview;
  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  late String _commentText;
  VideoPlayerController? _videoController;
  bool _videoFailedToLoad = false;
  bool _videoInitializationStarted = false;

  @override
  void initState() {
    super.initState();
    _commentText = widget.comment.text ?? '';
  }

  @override
  void didUpdateWidget(covariant CommentTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.comment.text != widget.comment.text) {
      _commentText = widget.comment.text ?? '';
    }
    if (oldWidget.comment.videoUrl != widget.comment.videoUrl) {
      final previousController = _videoController;
      _videoController = null;
      if (previousController != null) unawaited(previousController.dispose());
      _videoFailedToLoad = false;
      _videoInitializationStarted = false;
    }
  }

  void _initVideo() {
    if (_videoInitializationStarted) return;

    final videoUrl = widget.comment.videoUrl;
    _videoFailedToLoad = false;
    if (videoUrl == null || videoUrl.isEmpty) return;

    _videoInitializationStarted = true;
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(_getMediaUrl(videoUrl)),
    );
    _videoController = controller;
    unawaited(_initializeVideo(controller));
  }

  Future<void> _initializeVideo(VideoPlayerController controller) async {
    try {
      await controller.initialize();
      if (!mounted || !identical(_videoController, controller)) return;
      setState(() {});
    } catch (error) {
      debugPrint('Error loading comment video: $error');
      if (!identical(_videoController, controller)) return;
      await controller.dispose();
      _videoController = null;
      _videoFailedToLoad = true;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  String _getMediaUrl(String path) {
    return ServerUrl.resolveMediaUrl(path);
  }

  void _showEditCommentDialog() {
    final TextEditingController editController = TextEditingController(
      text: _commentText,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Comment'),
        content: TextField(controller: editController, maxLines: null),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _editComment(editController.text.trim());
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editComment(String newText) async {
    try {
      final success = await client.post.editComment(
        widget.comment.id!,
        newText,
      );
      if (mounted && success) setState(() => _commentText = newText);
    } catch (e) {
      debugPrint('Error editing comment: $e');
    }
  }

  Future<void> _deleteComment() async {
    try {
      final success = await client.post.deleteComment(widget.comment.id!);
      if (mounted && success) widget.onDeleted();
    } catch (e) {
      debugPrint('Error deleting comment: $e');
    }
  }

  Widget _buildCommentContent() {
    return Text(_commentText);
  }

  @override
  Widget build(BuildContext context) {
    final isOptimistic = widget.comment.id! < 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: ChatwitImage.avatar(
            widget.comment.profileImageUrl,
            radius: 20,
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    userId: widget.comment.userId,
                    userName:
                        widget.comment.fullName ?? widget.comment.userName,
                  ),
                ),
              );
            },
            child: Text(
              widget.comment.fullName ?? widget.comment.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          subtitle: _buildCommentContent(),
          trailing: isOptimistic
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditCommentDialog();
                    } else if (value == 'delete') {
                      _deleteComment();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                ),
        ),
        if ((widget.comment.imageUrl != null &&
                widget.comment.imageUrl!.isNotEmpty) ||
            (widget.localPreview != null && widget.comment.videoUrl == null))
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16, bottom: 8),
            child: GestureDetector(
              onTap: () {
                if (widget.localPreview == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageViewer(
                        imageUrl: _getMediaUrl(widget.comment.imageUrl!),
                        tag: 'comment-image-${widget.comment.id}',
                      ),
                    ),
                  );
                }
              },
              child: Hero(
                tag:
                    'comment-image-${widget.comment.id}-${identityHashCode(widget)}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.localPreview != null
                      ? Image.memory(widget.localPreview!, fit: BoxFit.cover)
                      : ChatwitImage.image(
                          _getMediaUrl(widget.comment.imageUrl!),
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) =>
                              const Icon(Icons.broken_image),
                        ),
                ),
              ),
            ),
          ),
        if (widget.comment.videoUrl != null && _videoFailedToLoad)
          const Padding(
            padding: EdgeInsets.only(left: 72, right: 16, bottom: 8),
            child: Text(
              'This video could not be played on this device.',
              style: TextStyle(color: Colors.grey),
            ),
          )
        else if (widget.comment.videoUrl?.isNotEmpty ?? false)
          VisibilityDetector(
            key: Key('comment-video-${widget.comment.id}'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction >= 0.1) {
                _initVideo();
              } else if (_videoController?.value.isInitialized ?? false) {
                _videoController!.pause();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 72, right: 16, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  if (_videoController?.value.isInitialized != true) {
                    _initVideo();
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenVideoPlayer(
                        controller: _videoController!,
                        videoUrl: _getMediaUrl(widget.comment.videoUrl!),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: _videoController?.value.aspectRatio ?? 16 / 9,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_videoController?.value.isInitialized == true)
                          VideoPlayer(_videoController!)
                        else
                          Container(
                            color: Colors.black12,
                            child: const Icon(
                              Icons.video_library,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        if (_videoController?.value.isInitialized == true)
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (_videoController != null &&
            _videoController!.value.isInitialized)
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16, bottom: 8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenVideoPlayer(
                    controller: _videoController!,
                    videoUrl: _getMediaUrl(widget.comment.videoUrl!),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_videoController!),
                      Icon(Icons.play_arrow, color: Colors.white, size: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key, required this.postId});
  final int postId;
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  bool _isSending = false, _isUploading = false, _isLoadingComments = false;
  List<Comment> _comments = [];
  final Map<int, Uint8List> _optimisticPreviews =
      {}; // Store previews by tempId
  String? _attachedFilePath, _attachedFileType;
  Uint8List? _previewBytes;
  UserRegistration? _currentUser;

  static const _imageExtensions = {
    'jpg',
    'jpeg',
    'png',
    'webp',
    'bmp',
  };
  static const _videoExtensions = {
    'mp4',
    'm4v',
    'mov',
    'webm',
    'mkv',
    'avi',
    '3gp',
    'mpeg',
    'mpg',
    'wmv',
    'flv',
    'ts',
  };

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _loadComments(),
      _loadCurrentUser(),
    ]);
  }

  Future<void> _loadCurrentUser() async {
    final myId = authManager.authInfo?.authUserId.toString();
    if (myId != null) {
      final info = await client.userRegistration.getUserInfo(myId);
      if (mounted) setState(() => _currentUser = info);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() => _isLoadingComments = true);
    try {
      final comments = await client.post.getComments(widget.postId);
      if (mounted) {
        setState(() {
          _comments = comments;
          _optimisticPreviews.clear();
        });
      }
    } finally {
      if (mounted) setState(() => _isLoadingComments = false);
    }
  }

  Future<String?> _uploadToS3(String path, Uint8List bytes) async {
    try {
      final uploadDescription = await client.post.getUploadDescription(path);
      if (uploadDescription != null) {
        final uploader = FileUploader(uploadDescription);
        if (await uploader.uploadByteData(ByteData.sublistView(bytes))) {
          if (await client.post.verifyUpload(path)) return path;
        }
      }
    } catch (e) {
      debugPrint('Error uploading to S3: $e');
    }
    return null;
  }

  Future<void> _pickFromGallery() async {
    try {
      final file = await FilePicker.pickFile(type: FileType.media);
      if (file == null || !mounted) return;

      final extension = file.name.split('.').last.toLowerCase();
      final isVideo = _videoExtensions.contains(extension);
      if (!isVideo && !_imageExtensions.contains(extension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This media format is not supported.')),
        );
        return;
      }

      setState(() {
        _isUploading = true;
        _attachedFilePath = null;
        _attachedFileType = isVideo ? 'video' : 'image';
        _previewBytes = null;
      });
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      setState(() => _previewBytes = bytes);

      final path =
          'comments/media/${DateTime.now().millisecondsSinceEpoch}.$extension';
      final uploadedPath = await _uploadToS3(path, bytes);
      if (!mounted) return;
      if (uploadedPath == null) {
        setState(() {
          _attachedFileType = null;
          _previewBytes = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Media upload failed. Please try again.'),
          ),
        );
      } else {
        setState(() => _attachedFilePath = uploadedPath);
      }
    } catch (error) {
      debugPrint('Error selecting comment media: $error');
      if (mounted) {
        setState(() {
          _attachedFilePath = null;
          _attachedFileType = null;
          _previewBytes = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _sendComment() async {
    final typedText = _commentController.text.trim();
    if (typedText.isEmpty && _attachedFilePath == null) {
      return;
    }
    final text = typedText;

    setState(() => _isSending = true);

    // 1. Optimistic Update
    final tempId = -DateTime.now().millisecondsSinceEpoch;
    final optimisticComment = Comment(
      id: tempId,
      postId: widget.postId,
      userId: authManager.authInfo?.authUserId.toString() ?? '',
      userName: _currentUser?.username ?? 'Me',
      fullName: _currentUser != null
          ? "${_currentUser!.firstName} ${_currentUser!.surname}"
          : 'Me',
      profileImageUrl: _currentUser?.profileImageUrl,
      text: text,
      imageUrl: _attachedFileType == 'image' ? _attachedFilePath : null,
      videoUrl: _attachedFileType == 'video' ? _attachedFilePath : null,
      createdAt: DateTime.now(),
    );

    setState(() {
      _comments.add(optimisticComment);
      if (_previewBytes != null && _attachedFileType == 'image') {
        _optimisticPreviews[tempId] = _previewBytes!;
      }
      _commentController.clear();
      _attachedFilePath = null;
      _attachedFileType = null;
      _previewBytes = null;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('sending post'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    try {
      final success = await client.post.createComment(
        widget.postId,
        optimisticComment.text,
        optimisticComment.imageUrl,
        optimisticComment.videoUrl,
      );

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Comment sent'),
              duration: Duration(seconds: 1),
            ),
          );
        }
        await _loadComments(); // Replace optimistic list with real server data
      } else {
        // Handle failure: remove optimistic comment
        setState(() => _comments.removeWhere((c) => c.id == tempId));
      }
    } catch (e) {
      debugPrint('Error sending comment: $e');
      setState(() => _comments.removeWhere((c) => c.id == tempId));
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Comments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Divider(),
                Expanded(
                  child: _isLoadingComments && _comments.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : _comments.isEmpty
                      ? const Center(child: Text('No comments yet.'))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: _comments.length,
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            return CommentTile(
                              comment: comment,
                              onDeleted: _loadComments,
                              localPreview: _optimisticPreviews[comment.id],
                            );
                          },
                        ),
                ),
                const Divider(),
                if (_isUploading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Uploading...', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  )
                else if (_previewBytes != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _attachedFileType == 'video'
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.black87,
                                  child: const Icon(
                                    Icons.video_library,
                                    color: Colors.white,
                                  ),
                                )
                              : Image.memory(
                                  _previewBytes!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => setState(() {
                              _attachedFilePath = null;
                              _attachedFileType = null;
                              _previewBytes = null;
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.collections_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: _isUploading || _isSending
                          ? null
                          : _pickFromGallery,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Write a comment...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isUploading || _isSending
                          ? null
                          : _sendComment,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
