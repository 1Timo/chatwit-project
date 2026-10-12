import 'package:chatwit_flutter/core/client.dart';

Future<List<UserRegistration>> resolveFollowUsers(
  List<Follow> follows, {
  required bool areFollowers,
}) async {
  final userIds = follows
      .map((follow) => areFollowers ? follow.followerId : follow.followingId)
      .toSet();
  final users = await Future.wait(
    userIds.map(client.userRegistration.getUserInfo),
  );
  return users.whereType<UserRegistration>().toList();
}
