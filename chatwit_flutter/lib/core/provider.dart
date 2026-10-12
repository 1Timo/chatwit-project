import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatwit_flutter/core/client.dart';

final currentUserIdProvider = FutureProvider<String>((ref) async {
  try {
    final authInfo = authManager.authInfo;
    return authInfo?.authUserId.toString() ?? '';
  } catch (e) {
    return '';
  }
});

final currentUserInfoProvider = FutureProvider<UserRegistration?>((ref) async {
  try {
    final myId = await ref.watch(currentUserIdProvider.future);
    if (myId.isEmpty) return null;
    return await client.userRegistration.getUserInfo(myId);
  } catch (e) {
    return null;
  }
});

class LikedPostsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String userName) {
    if (state.contains(userName)) {
      state = {...state}..remove(userName);
    } else {
      state = {...state, userName};
    }
  }
}

final likedPostsProvider = NotifierProvider<LikedPostsNotifier, Set<String>>(
  LikedPostsNotifier.new,
);
