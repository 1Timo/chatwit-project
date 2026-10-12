import 'package:flutter/foundation.dart';

class ShareLinks {
  ShareLinks._();

  static const _configuredAppUrl = String.fromEnvironment('APP_URL');

  static Uri postUri(int postId) {
    final String appUrl;
    if (_configuredAppUrl.isNotEmpty) {
      appUrl = _configuredAppUrl;
    } else if (kIsWeb) {
      appUrl = Uri.base.toString();
    } else {
      throw StateError(
        'Post link URL is not configured. Set APP_URL to the public app URL.',
      );
    }

    return postUriFromBase(appUrl, postId);
  }

  static Uri postUriFromBase(String appUrl, int postId) {
    final baseUri = Uri.tryParse(appUrl);
    if (baseUri == null ||
        !baseUri.hasAuthority ||
        (baseUri.scheme != 'http' && baseUri.scheme != 'https') ||
        baseUri.hasQuery ||
        baseUri.hasFragment) {
      throw StateError('APP_URL must be an absolute HTTP(S) app URL.');
    }

    final basePath = baseUri.path.endsWith('/')
        ? baseUri.path
        : '${baseUri.path}/';
    return baseUri.replace(path: basePath).resolve('post/$postId');
  }
}
