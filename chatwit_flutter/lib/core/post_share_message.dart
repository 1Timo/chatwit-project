import 'dart:convert';

import 'package:chatwit_flutter/core/client.dart';

class PostShareMessage {
  PostShareMessage._();

  static const marker = '__CHATWIT_POST_SHARE__:';

  static String encode(Post post) {
    return '$marker${jsonEncode({
      'postId': post.id,
      'authorName': post.fullName ?? post.userName ?? 'Chatwit user',
      'text': post.text ?? '',
      'imageUrl': post.imageUrl,
      'videoUrl': post.videoUrl,
    })}';
  }

  static Map<String, dynamic>? decode(String text) {
    if (!text.startsWith(marker)) return null;

    try {
      final decoded = jsonDecode(text.substring(marker.length));
      if (decoded is! Map<String, dynamic>) return null;
      return decoded;
    } on FormatException {
      return null;
    }
  }
}
