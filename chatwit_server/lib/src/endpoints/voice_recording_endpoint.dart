import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class VoiceRecordingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Create a voice recording upload description
  /// Client will upload the file separately, then call completeVoiceRecording
  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  /// Verify a voice recording upload
  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyUpload(
      storageId: 'public',
      path: path,
    );
  }

  /// Complete voice recording upload by creating the database record
  /// Call this after uploading the file and verifying
  Future<VoiceRecording?> completeVoiceRecording(
    Session session, {
    required String callRoomId,
    required String toUserId,
    required String recordingPath, // Path in S3
    required int durationMs,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return null;

    final fromUserId = authInfo.userIdentifier;

    try {
      // Get the public URL for the recording
      final publicUrl = await session.storage.publicDownloadUrl(
        storageId: 'public',
        path: recordingPath,
      );

      // Create the voice recording record
      final voiceRecording = VoiceRecording(
        callRoomId: callRoomId,
        fromUserId: fromUserId,
        toUserId: toUserId,
        recordingUrl: publicUrl.toString(),
        duration: durationMs,
        createdAt: DateTime.now(),
      );

      await VoiceRecording.db.insertRow(session, voiceRecording);

      session.log(
        'Voice recording completed: $fromUserId -> $toUserId ($durationMs ms)',
        level: LogLevel.info,
      );

      return voiceRecording;
    } catch (error) {
      session.log(
        'Error completing voice recording: $error',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Get all voice recordings for a user (as receiver or sender)
  Future<List<VoiceRecording>> getUserVoiceRecordings(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return [];

    final userId = authInfo.userIdentifier;

    return await VoiceRecording.db.find(
      session,
      where: (t) => (t.fromUserId.equals(userId) | t.toUserId.equals(userId)),
      orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  /// Get voice recordings for a specific call room
  Future<List<VoiceRecording>> getCallVoiceRecordings(
    Session session,
    String callRoomId,
  ) async {
    return await VoiceRecording.db.find(
      session,
      where: (t) => t.callRoomId.equals(callRoomId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Delete a voice recording (only the owner can delete)
  Future<bool> deleteVoiceRecording(
    Session session,
    int recordingId,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return false;

    final userId = authInfo.userIdentifier;

    // Find the recording
    final recording = await VoiceRecording.db.findById(session, recordingId);
    if (recording == null || recording.fromUserId != userId) {
      return false; // Not found or not authorized
    }

    // Note: S3 file deletion is optional - we could leave files for audit trail
    // For now, we just delete the database record
    await VoiceRecording.db.deleteRow(session, recording);
    return true;
  }
}
