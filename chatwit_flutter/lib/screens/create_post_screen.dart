import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/provider.dart';
import 'package:chatwit_flutter/core/draft_service.dart';
import 'package:chatwit_flutter/core/feed_provider.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/follow_users.dart';

class PostScreen extends ConsumerStatefulWidget {
  final DraftPost? draft;
  const PostScreen({super.key, this.draft});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;

  XFile? _selectedVideo;
  VideoPlayerController? _videoController;

  String _privacy = 'Everyone';
  final Set<String> _selectedFollowerIds = {};
  String _category = 'General';
  String? _selectedLocation;
  String? _profileImageUrl;
  String _displayName = "My Profile";
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    if (widget.draft != null) {
      _privacy = switch (widget.draft!.audience) {
        'only_me' => 'Only Me',
        'followers' => 'Followers',
        _ => 'Everyone',
      };
      _selectedFollowerIds.addAll(widget.draft!.sharedWithUserIds);
      _textController.text = widget.draft!.text;
      _category = widget.draft!.category;
      _selectedLocation = widget.draft!.location;
      if (widget.draft!.imagePath != null) {
        _selectedImage = XFile(widget.draft!.imagePath!);
        _selectedImage!.readAsBytes().then((bytes) {
          if (mounted) setState(() => _selectedImageBytes = bytes);
        });
      }
      if (widget.draft!.videoPath != null) {
        _selectedVideo = XFile(widget.draft!.videoPath!);
        _videoController =
            VideoPlayerController.file(File(_selectedVideo!.path))
              ..initialize().then((_) {
                if (mounted) setState(() {});
              });
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadUserProfile());
  }

  Future<void> _loadUserProfile() async {
    try {
      final myId = await ref.read(currentUserIdProvider.future);
      if (myId.isNotEmpty) {
        final info = await client.userRegistration.getUserInfo(myId);
        if (mounted) {
          setState(() {
            _profileImageUrl = info?.profileImageUrl;
            if (info != null) {
              _displayName = "${info.firstName} ${info.surname}";
            }
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading user profile: $e");
    }
  }

  Future<void> _pickFromGallery() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image, color: Colors.green),
              title: const Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.video_library,
                color: Color(0xFF6B7280),
              ),
              title: const Text('Video'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImage = image;
        _selectedImageBytes = bytes;
        _selectedVideo = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final controller = VideoPlayerController.file(File(video.path));
      await controller.initialize();
      setState(() {
        _videoController = controller;
        _selectedVideo = video;
        _selectedImage = null;
        _selectedImageBytes = null;
      });
    }
  }

  void _showPrivacyOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Share to everyone'),
              onTap: () {
                setState(() => _privacy = 'Everyone');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('Share to followers'),
              subtitle: _selectedFollowerIds.isEmpty
                  ? null
                  : Text('${_selectedFollowerIds.length} selected'),
              onTap: () {
                Navigator.pop(context);
                _selectFollowers();
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Share to only me'),
              onTap: () {
                setState(() => _privacy = 'Only Me');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectFollowers() async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    try {
      final followRows = await client.follow.getFollowers();
      final followers = await resolveFollowUsers(
        followRows,
        areFollowers: true,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      if (followers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You do not have any followers yet.')),
        );
        return;
      }

      final selectedIds = Set<String>.from(_selectedFollowerIds);
      final confirmedIds = await showModalBottomSheet<Set<String>>(
        context: context,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
          builder: (context, setSheetState) => SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Choose followers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('${selectedIds.length} selected'),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: followers.length,
                      itemBuilder: (context, index) {
                        final follower = followers[index];
                        final userId = follower.authUserId.toString();
                        final displayName =
                            '${follower.firstName} ${follower.surname}'.trim();
                        final isSelected = selectedIds.contains(userId);
                        return CheckboxListTile(
                          value: isSelected,
                          secondary: ChatwitImage.avatar(
                            follower.profileImageUrl,
                            radius: 20,
                          ),
                          title: Text(
                            displayName.isEmpty
                                ? '@${follower.username}'
                                : displayName,
                          ),
                          subtitle: Text('@${follower.username}'),
                          onChanged: (selected) {
                            setSheetState(() {
                              if (selected ?? false) {
                                selectedIds.add(userId);
                              } else {
                                selectedIds.remove(userId);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: selectedIds.isEmpty
                            ? null
                            : () => Navigator.pop(
                                context,
                                Set<String>.from(selectedIds),
                              ),
                        child: Text('Share with ${selectedIds.length}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      if (confirmedIds != null && mounted) {
        setState(() {
          _selectedFollowerIds
            ..clear()
            ..addAll(confirmedIds);
          _privacy = 'Followers';
        });
      }
    } catch (error) {
      debugPrint('Could not load followers for post sharing: $error');
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not load your followers. Please try again.'),
          ),
        );
      }
    }
  }

  Future<void> _autoFetchLocation() async {
    setState(() => _isLocating = true);
    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final locationStr = "${p.locality}, ${p.administrativeArea}";
        setState(() {
          _selectedLocation = locationStr;
        });
      }
    } catch (e) {
      debugPrint("Location error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Could not retrieve location. Please check GPS settings.",
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _showCategoryOptions() {
    final categories = ['General', 'Tech', 'Music', 'Sports', 'News', 'Gaming'];
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(categories[index]),
            leading: Icon(categories[index] == _category ? Icons.check : null),
            onTap: () {
              setState(() => _category = categories[index]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _finalSubmit() async {
    final text = _textController.text.trim();
    if (text.isEmpty && _selectedImage == null && _selectedVideo == null) {
      return;
    }

    final myId = await ref.read(currentUserIdProvider.future);
    if (!mounted) return;
    if (_privacy == 'Followers' && _selectedFollowerIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select at least one follower to share with.'),
        ),
      );
      return;
    }

    // Trigger optimistic update
    ref
        .read(feedProvider.notifier)
        .createPostOptimistically(
          text: text,
          category: _category,
          location: _selectedLocation,
          image: _selectedImage,
          video: _selectedVideo,
          userName: _displayName,
          fullName: _displayName,
          profileImageUrl: _profileImageUrl,
          userId: myId,
          audience: switch (_privacy) {
            'Only Me' => 'only_me',
            'Followers' => 'followers',
            _ => 'everyone',
          },
          sharedWithUserIds: _privacy == 'Followers'
              ? _selectedFollowerIds.toList()
              : const [],
        );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Create Post',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _finalSubmit,
            child: Text(
              'Post',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: _profileImageUrl != null
                            ? ChatwitImage.provider(_profileImageUrl!)
                            : null,
                        child: _profileImageUrl == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_selectedLocation != null)
                              Text(
                                "is at $_selectedLocation",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _showPrivacyOptions,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _privacy == 'Everyone'
                                              ? Icons.public
                                              : _privacy == 'Followers'
                                              ? Icons.people_outline
                                              : Icons.lock,
                                          size: 12,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _privacy,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: _showCategoryOptions,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "#$_category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _textController,
                    maxLines: null,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: "What's on your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                  if (_selectedImageBytes != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Stack(
                        children: [
                          Image.memory(_selectedImageBytes!),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  _selectedImage = null;
                                  _selectedImageBytes = null;
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_videoController != null &&
                      _videoController!.value.isInitialized)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  _selectedVideo = null;
                                  _videoController?.dispose();
                                  _videoController = null;
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                const Text(
                  "Add to your post",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.collections_outlined,
                    color: Colors.green,
                  ),
                  onPressed: _pickFromGallery,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.location_on, color: Colors.red),
                      onPressed: _isLocating ? null : _autoFetchLocation,
                    ),
                    if (_isLocating)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
