import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/draft_service.dart';
import 'package:image_picker/image_picker.dart';

enum PostStatus { success, uploading, failed }

class PostWithStatus {
  final Post post;
  final PostStatus status;
  final String? localImagePath;
  final String? localVideoPath;

  PostWithStatus({
    required this.post,
    this.status = PostStatus.success,
    this.localImagePath,
    this.localVideoPath,
  });
}

class FeedNotifier extends AsyncNotifier<List<PostWithStatus>> {
  // Bridge to keep local media paths across refreshes for the current user
  final Map<String, String> _localMediaBridge = {};

  @override
  FutureOr<List<PostWithStatus>> build() async {
    return _fetchInitialPosts();
  }

  Future<List<PostWithStatus>> _fetchInitialPosts() async {
    try {
      final posts = await client.post.getRecommendedFeed(limit: 20, offset: 0);
      return _mapPostsWithBridge(posts);
    } catch (e) {
      debugPrint('Error fetching initial posts: $e');
      return [];
    }
  }

  List<PostWithStatus> _mapPostsWithBridge(List<Post> posts) {
    return posts.map((p) {
      // If we have a local path for this content/URL combo, use it to avoid network delay
      String? bridgedPath;
      if (p.imageUrl != null) {
        bridgedPath = _localMediaBridge[p.imageUrl!];
      }

      return PostWithStatus(
        post: p,
        localImagePath: bridgedPath,
      );
    }).toList();
  }

  Future<void> fetchPosts({int limit = 20, int offset = 0}) async {
    if (offset == 0) {
      state = const AsyncLoading();
    }

    state = await AsyncValue.guard(() async {
      final posts = await client.post.getRecommendedFeed(
        limit: limit,
        offset: offset,
      );
      final newItems = _mapPostsWithBridge(posts);

      if (offset == 0) return newItems;

      final currentItems = state.value ?? [];
      return [...currentItems, ...newItems];
    });
  }

  void addOptimisticPost(Post post, {String? imagePath, String? videoPath}) {
    final optimisticPost = PostWithStatus(
      post: post,
      status: PostStatus.uploading,
      localImagePath: imagePath,
      localVideoPath: videoPath,
    );

    final currentItems = state.value ?? [];
    state = AsyncData([optimisticPost, ...currentItems]);
  }

  void updatePostStatus(int? tempId, PostStatus status, {Post? finalPost}) {
    final currentItems = state.value ?? [];
    state = AsyncData(
      currentItems.map((p) {
        if (p.post.id == tempId) {
          return PostWithStatus(
            post: finalPost ?? p.post,
            status: status,
            localImagePath: p.localImagePath,
            localVideoPath: p.localVideoPath,
          );
        }
        return p;
      }).toList(),
    );
  }

  void removePost(int? id) {
    if (state.hasValue) {
      state = AsyncData(state.value!.where((p) => p.post.id != id).toList());
    }
  }

  Future<void> createPostOptimistically({
    required String text,
    required String category,
    String? location,
    XFile? image,
    XFile? video,
    String? feeling,
    required String userName,
    required String fullName,
    String? profileImageUrl,
    required String userId,
    String audience = 'everyone',
    List<String> sharedWithUserIds = const [],
  }) async {
    final tempId = -DateTime.now().millisecondsSinceEpoch;

    final optimisticPost = Post(
      id: tempId,
      userId: userId,
      userName: userName,
      fullName: fullName,
      profileImageUrl: profileImageUrl,
      text: feeling != null && feeling.isNotEmpty
          ? "$text — feeling $feeling"
          : text,
      category: category,
      location: location,
      audience: audience,
      createdAt: DateTime.now(),
      viewCount: 0,
    );

    addOptimisticPost(
      optimisticPost,
      imagePath: image?.path,
      videoPath: video?.path,
    );

    try {
      String? imageUrl;
      String? videoUrl;

      if (image != null) {
        final path =
            'posts/images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        // Store in bridge so that when fetchPosts happens after upload, we still use local file
        _localMediaBridge[path] = image.path;

        final bytes = await image.readAsBytes();
        final uploadDescription = await client.post.getUploadDescription(path);
        if (uploadDescription != null) {
          final uploader = FileUploader(uploadDescription);
          await uploader.uploadByteData(ByteData.sublistView(bytes));
          if (await client.post.verifyUpload(path)) imageUrl = path;
        }
      }

      if (video != null) {
        final path =
            'posts/videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
        final bytes = await video.readAsBytes();
        final uploadDescription = await client.post.getUploadDescription(path);
        if (uploadDescription != null) {
          final uploader = FileUploader(uploadDescription);
          await uploader.uploadByteData(ByteData.sublistView(bytes));
          if (await client.post.verifyUpload(path)) videoUrl = path;
        }
      }

      await client.post.createPost(
        optimisticPost.text,
        imageUrl,
        videoUrl,
        category,
        location,
        audience,
        sharedWithUserIds,
      );

      // Refresh
      await fetchPosts();
    } catch (e) {
      debugPrint('Optimistic post failed: $e');
      updatePostStatus(tempId, PostStatus.failed);

      final draft = DraftPost(
        text: optimisticPost.text ?? '',
        category: category,
        location: location,
        imagePath: image?.path,
        videoPath: video?.path,
        audience: audience,
        sharedWithUserIds: sharedWithUserIds,
        createdAt: DateTime.now(),
      );
      await DraftService.saveDraft(draft);
    }
  }
}

final feedProvider = AsyncNotifierProvider<FeedNotifier, List<PostWithStatus>>(
  () {
    return FeedNotifier();
  },
);
