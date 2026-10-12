import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/story_groups.dart';
import 'package:flutter_test/flutter_test.dart';

Story _story(String userId, DateTime createdAt) {
  return Story(
    userId: userId,
    mediaUrl: 'https://media.example/${createdAt.millisecondsSinceEpoch}.jpg',
    mediaType: 'image',
    createdAt: createdAt,
    expiresAt: createdAt.add(const Duration(hours: 24)),
  );
}

void main() {
  test("groups each user's stories and orders them oldest first", () {
    final first = _story('user-1', DateTime.utc(2026, 10, 12, 9));
    final anotherUser = _story('user-2', DateTime.utc(2026, 10, 12, 10));
    final second = _story('user-1', DateTime.utc(2026, 10, 12, 11));

    final groups = groupStoriesByUser([second, anotherUser, first]);

    expect(groups, hasLength(2));
    expect(groups.first, [first, second]);
    expect(groups.last, [anotherUser]);
  });
}
