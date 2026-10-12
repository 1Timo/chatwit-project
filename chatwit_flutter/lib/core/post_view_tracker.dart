import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:chatwit_flutter/core/client.dart';

class PostViewTracker {
  static final PostViewTracker instance = PostViewTracker._internal();
  PostViewTracker._internal();

  final Set<int> _pendingViewIds = {};
  Timer? _flushTimer;
  static const Duration _batchInterval = Duration(seconds: 10);

  void trackView(int postId) {
    _pendingViewIds.add(postId);
    _scheduleFlush();
  }

  void _scheduleFlush() {
    if (_flushTimer != null && _flushTimer!.isActive) return;

    _flushTimer = Timer(_batchInterval, () {
      _flush();
    });
  }

  Future<void> _flush() async {
    if (_pendingViewIds.isEmpty) return;

    final idsToFlush = List<int>.from(_pendingViewIds);
    _pendingViewIds.clear();

    try {
      await client.post.batchIncrementViewCounts(idsToFlush);
      debugPrint('Successfully flushed ${idsToFlush.length} post views');
    } catch (e) {
      debugPrint('Error flushing post views: $e');
    }
  }
}
