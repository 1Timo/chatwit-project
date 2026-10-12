import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/features/post_card.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/follow_users.dart';
import 'package:chatwit_flutter/core/provider.dart';
import 'package:chatwit_flutter/core/app_constants.dart';
import 'package:chatwit_flutter/screens/chatscreen.dart';
import 'package:chatwit_flutter/widgets/fullscreen_image_viewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

final serverpodClientProvider = Provider<Client>((ref) => client);

class ProfileScreen extends ConsumerStatefulWidget {
  final String userId;
  final String userName;
  final VoidCallback? onBack;

  const ProfileScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.onBack,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isFollowing = false;
  bool _isLoading = true;
  List<Post> _userPosts = [];
  List<ProfilePhoto> _profilePhotoHistory = [];
  int _followersCount = 0;
  int _followingCount = 0;
  UserRegistration? _userRegistration;
  String? _profileImageUrl;
  String? _localOptimisticBackground;
  String? _localOptimisticAvatar;
  int _backgroundPhotoIndex = 0;
  int _profilePhotoIndex = 0;
  bool _isUploadingProfilePhoto = false;
  late final PageController _backgroundPageController;
  late final PageController _profilePageController;

  @override
  void initState() {
    super.initState();
    _backgroundPageController = PageController();
    _profilePageController = PageController();
    // 1. Pre-populate state from provider if this is MY profile
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final myId = ref.read(currentUserIdProvider).value;
      if (myId == widget.userId) {
        final myInfo = ref.read(currentUserInfoProvider).value;
        if (myInfo != null && mounted) {
          setState(() {
            _userRegistration = myInfo;
            _profileImageUrl = myInfo.profileImageUrl;
            // No need to show loader if we have basic info
            _isLoading = false;
          });
        }
      }
      _loadProfileData();
    });
  }

  Future<void> _loadProfileData() async {
    // Only show the main loader if we have NO data at all
    if (_userRegistration == null) {
      setState(() => _isLoading = true);
    }

    try {
      final String targetUserId = widget.userId;

      final results = await Future.wait([
        client.post
            .getUserPosts(targetUserId)
            .timeout(const Duration(seconds: 15)),
        client.follow
            .getUserFollowing(targetUserId)
            .timeout(const Duration(seconds: 10)),
        client.follow
            .getUserFollowers(targetUserId)
            .timeout(const Duration(seconds: 10)),
        client.userRegistration
            .getUserInfo(targetUserId)
            .timeout(const Duration(seconds: 15)),
        client.userRegistration
            .getProfilePhotoHistory(targetUserId)
            .timeout(const Duration(seconds: 15)),
      ]);

      if (!mounted) return;

      setState(() {
        _userPosts = results[0] as List<Post>;
        _followingCount = (results[1] as List).length;
        _followersCount = (results[2] as List).length;
        _userRegistration = results[3] as UserRegistration?;
        _profileImageUrl = _userRegistration?.profileImageUrl;
        _profilePhotoHistory = results[4] as List<ProfilePhoto>;
        _backgroundPhotoIndex = 0;
        _profilePhotoIndex = 0;
        _isLoading = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_backgroundPageController.hasClients) {
          _backgroundPageController.jumpToPage(0);
        }
        if (_profilePageController.hasClients) {
          _profilePageController.jumpToPage(0);
        }
      });
      _checkIfFollowing();
    } catch (e) {
      debugPrint('Error loading profile data: $e');
      if (mounted && _userRegistration == null) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _backgroundPageController.dispose();
    _profilePageController.dispose();
    super.dispose();
  }

  List<String> _photoUrls(String imageType, String? currentUrl) {
    final urls = _profilePhotoHistory
        .where((photo) => photo.imageType == imageType)
        .map((photo) => photo.imageUrl)
        .toList();
    if (currentUrl != null &&
        currentUrl.isNotEmpty &&
        !urls.contains(currentUrl)) {
      urls.insert(0, currentUrl);
    }
    return urls;
  }

  Future<ImageSource?> _choosePhotoSource() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickBackground() => _pickAndUploadPhoto(isBackground: true);

  Future<void> _pickProfileImage() => _pickAndUploadPhoto(isBackground: false);

  Future<void> _pickAndUploadPhoto({required bool isBackground}) async {
    if (_isUploadingProfilePhoto) return;
    setState(() => _isUploadingProfilePhoto = true);

    try {
      final source = await _choosePhotoSource();
      if (source == null || !mounted) return;

      final image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image == null || !mounted) return;

      setState(() {
        if (isBackground) {
          _localOptimisticBackground = image.path;
        } else {
          _localOptimisticAvatar = image.path;
        }
      });

      final bytes = await image.readAsBytes();
      final extension = image.name.contains('.')
          ? image.name.split('.').last.toLowerCase()
          : 'jpg';
      final folder = isBackground ? 'backgrounds' : 'avatars';
      final path =
          'profiles/$folder/${widget.userId}_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final uploadDescription = await client.userRegistration
          .getUploadDescription(path);
      if (uploadDescription == null) {
        throw StateError('Could not start the photo upload.');
      }

      final uploader = FileUploader(uploadDescription);
      if (!await uploader.uploadByteData(ByteData.sublistView(bytes)) ||
          !await client.userRegistration.verifyUpload(path)) {
        throw StateError('The photo upload could not be verified.');
      }

      final updated = isBackground
          ? await client.userRegistration.updateBackgroundUrl(path)
          : await client.userRegistration.updateProfileImageUrl(path);
      if (!updated) throw StateError('The profile photo could not be saved.');

      if (!mounted) return;
      setState(() {
        _localOptimisticBackground = null;
        _localOptimisticAvatar = null;
      });
      await _loadProfileData();
    } catch (error) {
      debugPrint('Error uploading profile photo: $error');
      if (!mounted) return;
      setState(() {
        _localOptimisticBackground = null;
        _localOptimisticAvatar = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isBackground
                ? 'Failed to upload background photo: $error'
                : 'Failed to upload profile photo: $error',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploadingProfilePhoto = false);
    }
  }

  Future<void> _deletePreviousPhoto(String imageType, String imageUrl) async {
    final photo = _profilePhotoHistory.cast<ProfilePhoto?>().firstWhere(
      (item) => item?.imageType == imageType && item?.imageUrl == imageUrl,
      orElse: () => null,
    );
    if (photo?.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete photo?'),
        content: const Text(
          'This removes the photo from your profile photo history.',
        ),
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
    if (confirmed != true) return;

    try {
      final deleted = await client.userRegistration.deleteProfilePhoto(
        photo!.id!,
      );
      if (!deleted) throw StateError('The photo could not be deleted.');
      await _loadProfileData();
    } catch (error) {
      debugPrint('Error deleting profile photo: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete photo: $error')),
        );
      }
    }
  }

  void _shareProfile() {
    final String profileLink = "https://chatwit.app/profile/${widget.userId}";
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Profile'),
              onTap: () {
                Navigator.pop(context);
                SharePlus.instance.share(
                  ShareParams(
                    text: "Check out my profile on Chatwit! $profileLink",
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy Profile Link'),
              onTap: () {
                Navigator.pop(context);
                Clipboard.setData(ClipboardData(text: profileLink));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Link copied!")));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkIfFollowing() async {
    try {
      final following = await client.follow.getFollowing();
      final isFollowing = following.any((f) => f.followingId == widget.userId);
      if (mounted) setState(() => _isFollowing = isFollowing);
    } catch (e) {
      debugPrint('Error checking follow status: $e');
    }
  }

  Future<void> _showConnections({required bool followers}) async {
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
      final followRows = followers
          ? await client.follow.getUserFollowers(widget.userId)
          : await client.follow.getUserFollowing(widget.userId);
      final users = await resolveFollowUsers(
        followRows,
        areFollowers: followers,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      await showModalBottomSheet<void>(
        context: context,
        builder: (sheetContext) => SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(sheetContext).height * 0.7,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    followers ? 'Followers' : 'Following',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: users.isEmpty
                      ? Center(
                          child: Text(
                            followers
                                ? 'No followers yet.'
                                : 'Not following anyone yet.',
                          ),
                        )
                      : ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (_, index) =>
                              const Divider(height: 1, indent: 72),
                          itemBuilder: (context, index) {
                            final user = users[index];
                            final userId = user.authUserId.toString();
                            return ListTile(
                              leading: ChatwitImage.avatar(
                                user.profileImageUrl,
                                radius: 22,
                              ),
                              title: Text(
                                '${user.firstName} ${user.surname}'.trim(),
                              ),
                              subtitle: Text('@${user.username}'),
                              onTap: () {
                                Navigator.pop(sheetContext);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProfileScreen(
                                      userId: userId,
                                      userName: user.username,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (error) {
      debugPrint('Could not load profile connections: $error');
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not load this list. Please try again.'),
          ),
        );
      }
    }
  }

  Future<void> _toggleFollow() async {
    try {
      final nowFollowing = await client.follow.toggleFollow(
        widget.userId,
        widget.userName,
      );
      if (!mounted) return;
      setState(() {
        _isFollowing = nowFollowing;
        _followersCount += nowFollowing ? 1 : -1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(nowFollowing ? "Following" : "Unfollowed")),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  void _openMessageChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          userId: widget.userId,
          userName: _userRegistration == null
              ? widget.userName
              : '${_userRegistration!.firstName} ${_userRegistration!.surname}',
          profileImageUrl: _profileImageUrl ?? '',
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String text, {
    bool isLink = false,
    String? suffix,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text + (suffix ?? ""),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isLink
                  ? Theme.of(context).colorScheme.primary
                  : (suffix != null ? Colors.grey : Colors.grey[700]),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _photoActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    double size = 36,
  }) {
    return Material(
      color: Colors.black.withValues(alpha: 0.55),
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        iconSize: size * 0.62,
        constraints: BoxConstraints.tightFor(width: size, height: size),
        padding: EdgeInsets.zero,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }

  String _formatJoinedDate(DateTime? date) {
    if (date == null) return "Unknown";
    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final currentUserIdAsync = ref.watch(currentUserIdProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _userRegistration != null
                  ? "${_userRegistration!.firstName} ${_userRegistration!.surname}"
                  : widget.userName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${_userPosts.length} Posts",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'share') _shareProfile();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'share', child: Text("Share profile")),
            ],
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentUserIdAsync.when(
              data: (myId) {
                final isMyProfile = myId == widget.userId;
                final backgroundPhotos = _photoUrls(
                  'background',
                  _userRegistration?.backgroundUrl,
                );
                final profilePhotos = _photoUrls(
                  'profile',
                  _profileImageUrl,
                );

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // X-Style Header: Background + Profile Image
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const SizedBox(
                                height: 212,
                                width: double.infinity,
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 150,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      if (_localOptimisticBackground != null)
                                        Image(
                                          image: ChatwitImage.provider(
                                            _localOptimisticBackground!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      else if (backgroundPhotos.isNotEmpty)
                                        PageView.builder(
                                          controller: _backgroundPageController,
                                          itemCount: backgroundPhotos.length,
                                          onPageChanged: (index) => setState(
                                            () => _backgroundPhotoIndex = index,
                                          ),
                                          itemBuilder: (context, index) =>
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullScreenImageViewer(
                                                          imageUrl:
                                                              backgroundPhotos[index],
                                                          tag:
                                                              'profile-bg-${widget.userId}',
                                                        ),
                                                  ),
                                                ),
                                                child: Image(
                                                  image: ChatwitImage.provider(
                                                    backgroundPhotos[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (c, e, s) =>
                                                      Container(
                                                        color: Colors.grey[300],
                                                      ),
                                                ),
                                              ),
                                        )
                                      else
                                        Container(color: Colors.grey[200]),
                                      if (isMyProfile)
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: _photoActionButton(
                                            icon: Icons.camera_alt,
                                            onPressed: _pickBackground,
                                            tooltip: 'Add background photo',
                                          ),
                                        ),
                                      if (backgroundPhotos.length > 1) ...[
                                        Positioned(
                                          left: 8,
                                          top: 56,
                                          child: _photoActionButton(
                                            icon: Icons.chevron_left,
                                            onPressed: () =>
                                                _backgroundPageController
                                                    .previousPage(
                                                      duration: const Duration(
                                                        milliseconds: 220,
                                                      ),
                                                      curve: Curves.easeOut,
                                                    ),
                                            tooltip:
                                                'Previous background photo',
                                          ),
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 56,
                                          child: _photoActionButton(
                                            icon: Icons.chevron_right,
                                            onPressed: () =>
                                                _backgroundPageController
                                                    .nextPage(
                                                      duration: const Duration(
                                                        milliseconds: 220,
                                                      ),
                                                      curve: Curves.easeOut,
                                                    ),
                                            tooltip: 'Next background photo',
                                          ),
                                        ),
                                      ],
                                      if (isMyProfile &&
                                          _backgroundPhotoIndex > 0 &&
                                          backgroundPhotos.isNotEmpty)
                                        Positioned(
                                          left: 12,
                                          bottom: 12,
                                          child: _photoActionButton(
                                            icon: Icons.delete_outline,
                                            onPressed: () => _deletePreviousPhoto(
                                              'background',
                                              backgroundPhotos[_backgroundPhotoIndex],
                                            ),
                                            tooltip:
                                                'Delete this background photo',
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              // Profile Avatar
                              Positioned(
                                top: 98,
                                left: 16,
                                child: SizedBox(
                                  width: 112,
                                  height: 112,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 112,
                                        height: 112,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: _localOptimisticAvatar != null
                                              ? Image(
                                                  image: ChatwitImage.provider(
                                                    _localOptimisticAvatar!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : profilePhotos.isNotEmpty
                                              ? PageView.builder(
                                                  controller:
                                                      _profilePageController,
                                                  itemCount:
                                                      profilePhotos.length,
                                                  onPageChanged: (index) =>
                                                      setState(
                                                        () =>
                                                            _profilePhotoIndex =
                                                                index,
                                                      ),
                                                  itemBuilder: (context, index) => GestureDetector(
                                                    onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullScreenImageViewer(
                                                              imageUrl:
                                                                  profilePhotos[index],
                                                              tag:
                                                                  'profile-avatar-${widget.userId}',
                                                            ),
                                                      ),
                                                    ),
                                                    child: ChatwitImage.avatar(
                                                      profilePhotos[index],
                                                      radius: 52,
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                    ),
                                                  ),
                                                )
                                              : ChatwitImage.avatar(
                                                  null,
                                                  radius: 52,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                ),
                                        ),
                                      ),
                                      if (profilePhotos.length > 1) ...[
                                        Positioned(
                                          left: 6,
                                          top: 42,
                                          child: _photoActionButton(
                                            icon: Icons.chevron_left,
                                            onPressed: () =>
                                                _profilePageController
                                                    .previousPage(
                                                      duration: const Duration(
                                                        milliseconds: 220,
                                                      ),
                                                      curve: Curves.easeOut,
                                                    ),
                                            tooltip: 'Previous profile photo',
                                            size: 28,
                                          ),
                                        ),
                                        Positioned(
                                          right: 6,
                                          top: 42,
                                          child: _photoActionButton(
                                            icon: Icons.chevron_right,
                                            onPressed: () =>
                                                _profilePageController.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 220,
                                                  ),
                                                  curve: Curves.easeOut,
                                                ),
                                            tooltip: 'Next profile photo',
                                            size: 28,
                                          ),
                                        ),
                                      ],
                                      if (isMyProfile)
                                        Positioned(
                                          right: 14,
                                          bottom: 14,
                                          child: _photoActionButton(
                                            icon: Icons.camera_alt,
                                            onPressed: _pickProfileImage,
                                            tooltip: 'Add profile photo',
                                            size: 28,
                                          ),
                                        ),
                                      if (isMyProfile &&
                                          _profilePhotoIndex > 0 &&
                                          profilePhotos.isNotEmpty)
                                        Positioned(
                                          left: 7,
                                          bottom: 7,
                                          child: _photoActionButton(
                                            icon: Icons.delete_outline,
                                            onPressed: () => _deletePreviousPhoto(
                                              'profile',
                                              profilePhotos[_profilePhotoIndex],
                                            ),
                                            tooltip:
                                                'Delete this profile photo',
                                            size: 30,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              // Action Button
                              Positioned(
                                top: 160,
                                right: 16,
                                child: isMyProfile
                                    ? OutlinedButton(
                                        onPressed: () {
                                          if (_userRegistration != null) {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  _EditProfileSheet(
                                                    registration:
                                                        _userRegistration!,
                                                  ),
                                            ).then((_) => _loadProfileData());
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: const Text(
                                          "Edit profile",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          OutlinedButton(
                                            onPressed: _openMessageChat,
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: _isFollowing
                                                  ? Colors.white
                                                  : Colors.black,
                                              foregroundColor: _isFollowing
                                                  ? Colors.black
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              side: _isFollowing
                                                  ? const BorderSide(
                                                      color: Colors.grey,
                                                    )
                                                  : BorderSide.none,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                  ),
                                            ),
                                            child: const Text('Message'),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: _toggleFollow,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: _isFollowing
                                                  ? Colors.white
                                                  : Colors.black,
                                              foregroundColor: _isFollowing
                                                  ? Colors.black
                                                  : Colors.white,
                                              side: _isFollowing
                                                  ? const BorderSide(
                                                      color: Colors.grey,
                                                    )
                                                  : null,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                  ),
                                            ),
                                            child: Text(
                                              _isFollowing
                                                  ? "Following"
                                                  : "Follow",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userRegistration != null
                                      ? "${_userRegistration!.firstName} ${_userRegistration!.surname}"
                                      : widget.userName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _userRegistration != null
                                      ? "@${_userRegistration!.username}"
                                      : "@user_${widget.userId}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 10),
                                if (_userRegistration?.bio != null)
                                  Text(
                                    _userRegistration!.bio!,
                                    style: const TextStyle(fontSize: 16),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Wrap(
                                    spacing: 15,
                                    runSpacing: 8,
                                    children: [
                                      if (_userRegistration?.occupation !=
                                              null &&
                                          _userRegistration!
                                              .occupation!
                                              .isNotEmpty)
                                        _buildInfoItem(
                                          Icons.work_outline,
                                          _userRegistration!.occupation!,
                                        ),

                                      // Privacy-aware Location
                                      if (_userRegistration?.location != null &&
                                          _userRegistration!
                                              .location!
                                              .isNotEmpty &&
                                          (_userRegistration!
                                                  .isLocationPublic ||
                                              isMyProfile))
                                        _buildInfoItem(
                                          Icons.location_on_outlined,
                                          _userRegistration!.location!,
                                          suffix:
                                              isMyProfile &&
                                                  !_userRegistration!
                                                      .isLocationPublic
                                              ? " (Private)"
                                              : null,
                                        ),

                                      // Privacy-aware Date of Birth
                                      if (_userRegistration != null &&
                                          (_userRegistration!.isDobPublic ||
                                              isMyProfile))
                                        _buildInfoItem(
                                          Icons.cake_outlined,
                                          "${_userRegistration!.dateOfBirth.day}/${_userRegistration!.dateOfBirth.month}/${_userRegistration!.dateOfBirth.year}",
                                          suffix:
                                              isMyProfile &&
                                                  !_userRegistration!
                                                      .isDobPublic
                                              ? " (Private)"
                                              : null,
                                        ),

                                      if (_userRegistration?.website != null &&
                                          _userRegistration!
                                              .website!
                                              .isNotEmpty)
                                        _buildInfoItem(
                                          Icons.link,
                                          _userRegistration!.website!,
                                          isLink: true,
                                        ),

                                      _buildInfoItem(
                                        Icons.calendar_month_outlined,
                                        "Joined ${_formatJoinedDate(_userRegistration?.createdAt)}",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 14,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          _showConnections(followers: false),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '$_followingCount',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: ' Following',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          _showConnections(followers: true),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '$_followersCount',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: ' Followers',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                        ],
                      ),
                    ),
                    _userPosts.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(child: Text("No posts yet.")),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  PostCard(post: _userPosts[index]),
                              childCount: _userPosts.length,
                            ),
                          ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  const Center(child: Text("Error loading profile")),
            ),
    );
  }
}

class _EditProfileSheet extends StatefulWidget {
  final UserRegistration registration;
  const _EditProfileSheet({required this.registration});

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _occupationController;
  late TextEditingController _websiteController;
  late TextEditingController _locationController;
  late DateTime _dob;
  bool _isLocationPublic = true;
  bool _isDobPublic = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: "${widget.registration.firstName} ${widget.registration.surname}",
    );
    _bioController = TextEditingController(text: widget.registration.bio ?? "");
    _occupationController = TextEditingController(
      text: widget.registration.occupation ?? "",
    );
    _websiteController = TextEditingController(
      text: widget.registration.website ?? "",
    );
    _locationController = TextEditingController(
      text: widget.registration.location ?? "",
    );
    _dob = widget.registration.dateOfBirth;
    _isLocationPublic = widget.registration.isLocationPublic;
    _isDobPublic = widget.registration.isDobPublic;
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      final names = _nameController.text.trim().split(' ');
      final firstName = names.first;
      final surname = names.length > 1 ? names.sublist(1).join(' ') : '';

      await client.userRegistration.updateProfile(
        firstName: firstName,
        surname: surname,
        bio: _bioController.text,
        occupation: _occupationController.text,
        website: _websiteController.text,
        location: _locationController.text,
        isLocationPublic: _isLocationPublic,
        isDobPublic: _isDobPublic,
        dateOfBirth: _dob,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: _save,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Full name",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: "Bio",
                      hintText: "Add a bio",
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Where do you live?",
                    ),
                  ),
                  SwitchListTile(
                    title: const Text(
                      "Show location on profile",
                      style: TextStyle(fontSize: 14),
                    ),
                    value: _isLocationPublic,
                    activeTrackColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (val) => setState(() => _isLocationPublic = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _websiteController,
                    decoration: const InputDecoration(
                      labelText: "Website",
                      hintText: "Add your website",
                    ),
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) => Autocomplete<String>(
                      initialValue: TextEditingValue(
                        text: widget.registration.occupation ?? "",
                      ),
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return AppConstants.occupationOptions;
                        }
                        return AppConstants.occupationOptions.where((
                          String option,
                        ) {
                          return option.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                        });
                      },
                      onSelected: (String selection) {
                        _occupationController.text = selection;
                      },
                      fieldViewBuilder:
                          (
                            context,
                            textEditingController,
                            focusNode,
                            onFieldSubmitted,
                          ) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onChanged: (val) =>
                                  _occupationController.text = val,
                              decoration: const InputDecoration(
                                labelText: "Occupation",
                                hintText: "What do you do?",
                              ),
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: constraints.maxWidth,
                              height: 200,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(
                                    index,
                                  );
                                  return ListTile(
                                    title: Text(option),
                                    onTap: () => onSelected(option),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      "Date of Birth",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      "${_dob.day}/${_dob.month}/${_dob.year}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dob,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _dob = picked);
                    },
                  ),
                  SwitchListTile(
                    title: const Text(
                      "Show date of birth on profile",
                      style: TextStyle(fontSize: 14),
                    ),
                    value: _isDobPublic,
                    activeTrackColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (val) => setState(() => _isDobPublic = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
