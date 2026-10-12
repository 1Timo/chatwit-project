import 'package:chatwit_flutter/core/post_share_message.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encodes and decodes a post preview for chat', () {
    final message = PostShareMessage.encode(
      Post(
        id: 42,
        userId: 'user-1',
        fullName: 'Ada Lovelace',
        text: 'A shared post',
        imageUrl: 'https://media.example/image.jpg',
        createdAt: DateTime.utc(2026),
      ),
    );

    expect(PostShareMessage.decode(message), {
      'postId': 42,
      'authorName': 'Ada Lovelace',
      'text': 'A shared post',
      'imageUrl': 'https://media.example/image.jpg',
      'videoUrl': null,
    });
  });

  test('returns null for ordinary and malformed messages', () {
    expect(PostShareMessage.decode('Hello'), isNull);
    expect(
      PostShareMessage.decode('${PostShareMessage.marker}not-json'),
      isNull,
    );
  });
}
