import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/server_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServerUrl.resolveMediaUrlAgainst', () {
    test('resolves relative media paths against the configured server', () {
      expect(
        ServerUrl.resolveMediaUrlAgainst(
          'uploads/avatar.png',
          baseUrl: 'http://192.168.1.20:8080',
        ),
        'http://192.168.1.20:8080/uploads/avatar.png',
      );
    });

    test('resolves paths with a leading slash at the server root', () {
      expect(
        ServerUrl.resolveMediaUrlAgainst(
          '/uploads/avatar.png',
          baseUrl: 'http://localhost:8080/',
        ),
        'http://localhost:8080/uploads/avatar.png',
      );
    });

    test('preserves absolute media URLs', () {
      expect(
        ServerUrl.resolveMediaUrlAgainst(
          'https://cdn.example.com/avatar.png',
          baseUrl: 'http://localhost:8080/',
        ),
        'https://cdn.example.com/avatar.png',
      );
    });
  });

  testWidgets('avatar without an image displays the placeholder icon', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: ChatwitImage.avatar(null)));

    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  test(
    'avatar image provider uses the configured server for relative paths',
    () {
      final image = ChatwitImage.provider('uploads/avatar.png');
      expect(
        image,
        isA<CachedNetworkImageProvider>().having(
          (provider) => provider.url,
          'url',
          ServerUrl.resolveMediaUrl('uploads/avatar.png'),
        ),
      );
    },
  );
}
