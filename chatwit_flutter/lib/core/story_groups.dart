import 'package:chatwit_flutter/core/client.dart';

List<List<Story>> groupStoriesByUser(Iterable<Story> stories) {
  final storiesByUser = <String, List<Story>>{};
  for (final story in stories) {
    storiesByUser.putIfAbsent(story.userId, () => []).add(story);
  }

  return storiesByUser.values
      .map(
        (userStories) =>
            userStories..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
      )
      .toList();
}
