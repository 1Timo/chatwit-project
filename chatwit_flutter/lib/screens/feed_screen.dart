import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:chatwit_flutter/screens/story_view_page.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/notification_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/feed_provider.dart';
import 'package:chatwit_flutter/core/story_groups.dart';
import 'package:chatwit_flutter/screens/create_post_screen.dart';
import 'package:chatwit_flutter/screens/profile_screen.dart';
import 'package:chatwit_flutter/features/post_card.dart';
import 'package:chatwit_flutter/widgets/app_drawer.dart';
import 'package:chatwit_flutter/widgets/poll_card.dart';
import 'package:chatwit_flutter/screens/inbox_screen.dart';
import 'package:chatwit_flutter/screens/search_screen.dart';
import 'package:chatwit_flutter/screens/notification_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _currentIndex = 0;

  void setTab(int index) {
    if (mounted) {
      setState(() => _currentIndex = index);
    }
  }

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissionsSequentially();
    });

    _screens = [
      const FeedContentTab(),
      const SearchScreen(),
      const NotificationScreen(),
      const InboxScreen(),
      const ProfileScreenWrapper(),
    ];
  }

  Future<void> _requestPermissionsSequentially() async {
    await NotificationService.initialize();
    await NotificationService.requestPermissions();
    await Future.delayed(const Duration(milliseconds: 500));
    await _requestLocationFlow();
  }

  Future<void> _requestLocationFlow() async {
    try {
      var status = await Permission.location.status;
      if (status.isDenied) {
        status = await Permission.location.request();
      }

      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
        debugPrint(
          'User location retrieved: ${position.latitude}, ${position.longitude}',
        );
      }
    } catch (e) {
      debugPrint('Location permission flow failed: $e');
    }
  }

  Future<void> _openCreatePostScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PostScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text('Chatwit'),
              centerTitle: true,
            )
          : null,
      drawer: _currentIndex == 0 ? const AppDrawer() : null,
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _openCreatePostScreen,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ProfileScreenWrapper extends ConsumerWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authInfo = authManager.authInfo;
    return ProfileScreen(
      userId: authInfo?.authUserId.toString() ?? '',
      userName: "My Profile",
      onBack: () {
        final feedState = context.findAncestorStateOfType<_FeedScreenState>();
        feedState?.setTab(0);
      },
    );
  }
}

class FeedContentTab extends ConsumerStatefulWidget {
  const FeedContentTab({super.key});

  @override
  ConsumerState<FeedContentTab> createState() => _FeedContentTabState();
}

class _FeedContentTabState extends ConsumerState<FeedContentTab> {
  List<List<Story>> _storyGroups = [];
  List<Poll> _polls = [];
  UserRegistration? _currentUser;

  bool _isMoreLoading = false;
  bool _hasMore = true;

  final int _batchSize = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
    _loadPolls();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.85) {
      final feedState = ref.read(feedProvider);
      if (!_isMoreLoading && _hasMore && feedState.hasValue) {
        _fetchMore();
      }
    }
  }

  Future<void> _loadInitialData() async {
    try {
      final authInfo = authManager.authInfo;
      final results = await Future.wait([
        client.story.getActiveStories().timeout(const Duration(seconds: 10)),
        if (authInfo != null)
          client.userRegistration
              .getUserInfo(authInfo.authUserId.toString())
              .timeout(const Duration(seconds: 10)),
      ]);

      if (!mounted) return;
      setState(() {
        _storyGroups = groupStoriesByUser(results[0] as List<Story>);
        _currentUser = authInfo != null
            ? results[1] as UserRegistration?
            : null;
      });
    } catch (e) {
      debugPrint('Initial load failed: $e');
    }
  }

  Future<void> _fetchMore() async {
    final currentPosts = ref.read(feedProvider).value ?? [];
    setState(() => _isMoreLoading = true);
    try {
      await ref
          .read(feedProvider.notifier)
          .fetchPosts(
            limit: _batchSize,
            offset: currentPosts.length,
          );

      if (!mounted) return;
      setState(() {
        _isMoreLoading = false;
        final newPosts = ref.read(feedProvider).value ?? [];
        if (newPosts.length == currentPosts.length) _hasMore = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isMoreLoading = false);
    }
  }

  Future<void> _loadPolls() async {
    try {
      final polls = await client.poll.getPolls(limit: 5);
      if (mounted) {
        setState(() => _polls = polls);
      }
    } catch (e) {
      debugPrint('Poll load failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);
    final hasPolls = _polls.isNotEmpty;
    final leadingWidgets = hasPolls ? 2 : 1;

    return feedState.when(
      data: (postsWithStatus) {
        return RefreshIndicator(
          onRefresh: () async {
            await _loadPolls();
            await ref.read(feedProvider.notifier).fetchPosts();
          },
          color: const Color(0xFF9E9E9E),
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: postsWithStatus.length + leadingWidgets + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildStoriesSection();
              if (hasPolls && index == 1) return _buildPollSection();

              final postIndex = index - leadingWidgets;
              if (postIndex < postsWithStatus.length) {
                final item = postsWithStatus[postIndex];
                return PostCard(
                  post: item.post,
                  status: item.status,
                  localImagePath: item.localImagePath,
                  localVideoPath: item.localVideoPath,
                );
              } else if (postIndex == postsWithStatus.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: _hasMore
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : const Text(
                            "You've seen everything!",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (e, st) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Failed to load feed: $e',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => ref.read(feedProvider.notifier).fetchPosts(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollSection() {
    if (_polls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Trending polls',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ..._polls.map((poll) => PollCard(poll: poll)),
      ],
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndCreateStory() async {
    final mediaType = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image_outlined),
              title: const Text('Photo'),
              onTap: () => Navigator.pop(context, 'image'),
            ),
            ListTile(
              leading: const Icon(Icons.video_library_outlined),
              title: const Text('Video'),
              onTap: () => Navigator.pop(context, 'video'),
            ),
          ],
        ),
      ),
    );
    if (mediaType == null || !mounted) return;

    final XFile? media = mediaType == 'image'
        ? await _picker.pickImage(source: ImageSource.gallery)
        : await _picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(minutes: 1),
          );
    if (media == null) return;

    try {
      final bytes = await media.readAsBytes();
      final extension = media.name.contains('.')
          ? media.name.split('.').last.toLowerCase()
          : (mediaType == 'image' ? 'jpg' : 'mp4');
      final path =
          'stories/${DateTime.now().millisecondsSinceEpoch}.$extension';

      final uploadDescription = await client.story.getUploadDescription(path);
      if (uploadDescription == null) {
        throw StateError('Could not prepare the story upload.');
      }
      final uploader = FileUploader(uploadDescription);
      final uploaded = await uploader.uploadByteData(
        ByteData.sublistView(bytes),
      );
      if (!uploaded) throw StateError('Could not upload the story media.');

      final verified = await client.story.verifyUpload(path);
      if (!verified) {
        throw StateError('The story upload could not be verified.');
      }

      final created = await client.story.createStory(
        mediaUrl: path,
        mediaType: mediaType,
      );
      if (!created) throw StateError('The story could not be created.');

      await _loadInitialData();
    } catch (e) {
      debugPrint('Error creating story: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not add your story. Try again.')),
        );
      }
    }
  }

  Widget _buildAddStoryCard() {
    return GestureDetector(
      onTap: _pickAndCreateStory,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: _currentUser?.profileImageUrl != null
              ? DecorationImage(
                  image: ChatwitImage.provider(_currentUser!.profileImageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            if (_currentUser?.profileImageUrl != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withValues(alpha: 0.2),
                ),
              ),
            if (_currentUser?.profileImageUrl == null)
              const Center(
                child: Icon(Icons.person, color: Colors.grey, size: 40),
              ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF374151),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Create Story",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard(List<Story> stories) {
    final story = stories.last;
    return GestureDetector(
      onTap: () {
        Navigator.push<int>(
          context,
          MaterialPageRoute(
            builder: (context) => StoryViewPage(
              stories: stories,
              ownerUserId: story.userId,
            ),
          ),
        ).then((deletedStoryId) {
          if (deletedStoryId != null) _loadInitialData();
        });
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: story.mediaType == 'video'
                    ? Container(
                        color: Colors.black87,
                        child: const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 42,
                        ),
                      )
                    : Image(
                        image: ChatwitImage.provider(story.mediaUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(
                              color: Color(0xFF374151),
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white,
                              ),
                            ),
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.transparent, Colors.black54],
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF374151),
                    width: 2,
                  ),
                ),
                child: ChatwitImage.avatar(story.profileImageUrl, radius: 16),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                story.userName ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesSection() {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 0.5),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _storyGroups.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildAddStoryCard();
          final stories = _storyGroups[index - 1];
          return _buildStoryCard(stories);
        },
      ),
    );
  }
}
