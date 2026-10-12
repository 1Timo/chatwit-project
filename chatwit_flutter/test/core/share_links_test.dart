import 'package:chatwit_flutter/core/share_links.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShareLinks.postUriFromBase', () {
    test('builds a post link from the configured app URL', () {
      expect(
        ShareLinks.postUriFromBase('https://chatwit.example/', 42).toString(),
        'https://chatwit.example/post/42',
      );
    });

    test('preserves an app URL path prefix', () {
      expect(
        ShareLinks.postUriFromBase(
          'https://chatwit.example/app',
          42,
        ).toString(),
        'https://chatwit.example/app/post/42',
      );
    });

    test('rejects non-HTTP app URLs', () {
      expect(
        () => ShareLinks.postUriFromBase('ftp://chatwit.example', 42),
        throwsStateError,
      );
    });
  });
}
