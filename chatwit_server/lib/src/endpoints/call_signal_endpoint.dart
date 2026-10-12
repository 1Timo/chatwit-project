import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class CallSignalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> sendSignal(
    Session session, {
    required String roomId,
    required String toUserId,
    required String type,
    String? payload,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      return;
    }

    final signal = CallSignalEvent(
      roomId: roomId,
      fromUserId: authInfo.userIdentifier,
      toUserId: toUserId,
      type: type,
      payload: payload,
      createdAt: DateTime.now(),
    );

    await CallSignalEvent.db.insertRow(session, signal);
    await session.messages.postMessage('call_room_$roomId', signal);
  }

  Stream<CallSignalEvent> listenToSignals(
    Session session, {
    required String roomId,
  }) async* {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      return;
    }

    final stream = session.messages.createStream<CallSignalEvent>(
      'call_room_$roomId',
    );

    await for (final event in stream) {
      if (event.roomId == roomId) {
        yield event;
      }
    }
  }
}
