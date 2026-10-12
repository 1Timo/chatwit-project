import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/server_url.dart';

class ChatwitImage {
  static Image image(
    String url, {
    BoxFit? fit,
    double? width,
    double? height,
    ImageErrorWidgetBuilder? errorBuilder,
    ImageLoadingBuilder? loadingBuilder,
  }) {
    final stopwatch = Stopwatch()..start();
    var didLogLoad = false;
    return Image(
      image: provider(url),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null && !didLogLoad) {
          didLogLoad = true;
          stopwatch.stop();
          if (kDebugMode) {
            debugPrint('Media image available in ${stopwatch.elapsedMilliseconds}ms');
          }
        }
        return child;
      },
    );
  }

  static ImageProvider provider(String? url) {
    if (url == null || url.isEmpty) {
      return const AssetImage('assets/images/default_avatar.png');
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return const AssetImage('assets/images/default_avatar.png');
    }

    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return CachedNetworkImageProvider(url);
    } else if (uri.scheme == 'file' || url.startsWith('file://')) {
      final String path = uri.scheme == 'file'
          ? uri.toFilePath()
          : url.replaceFirst('file://', '');
      return FileImage(File(path));
    } else if (url.startsWith('/')) {
      return FileImage(File(url));
    } else {
      // If it's a relative path, we assume it's from our server's public storage
      return CachedNetworkImageProvider(ServerUrl.resolveMediaUrl(url));
    }
  }

  static Widget avatar(
    String? url, {
    double radius = 24,
    Color? backgroundColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[200],
      backgroundImage: (url != null && url.isNotEmpty) ? provider(url) : null,
      child: (url == null || url.isEmpty)
          ? Icon(Icons.person, size: radius * 1.2, color: Colors.grey)
          : null,
    );
  }
}
