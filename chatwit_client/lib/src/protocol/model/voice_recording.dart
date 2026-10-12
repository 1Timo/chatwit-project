/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class VoiceRecording
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VoiceRecording._({
    this.id,
    required this.callRoomId,
    required this.fromUserId,
    required this.toUserId,
    required this.recordingUrl,
    required this.duration,
    required this.createdAt,
  });

  factory VoiceRecording({
    int? id,
    required String callRoomId,
    required String fromUserId,
    required String toUserId,
    required String recordingUrl,
    required int duration,
    required DateTime createdAt,
  }) = _VoiceRecordingImpl;

  factory VoiceRecording.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceRecording(
      id: jsonSerialization['id'] as int?,
      callRoomId: jsonSerialization['callRoomId'] as String,
      fromUserId: jsonSerialization['fromUserId'] as String,
      toUserId: jsonSerialization['toUserId'] as String,
      recordingUrl: jsonSerialization['recordingUrl'] as String,
      duration: jsonSerialization['duration'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String callRoomId;

  String fromUserId;

  String toUserId;

  String recordingUrl;

  int duration;

  DateTime createdAt;

  /// Returns a shallow copy of this [VoiceRecording]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VoiceRecording copyWith({
    int? id,
    String? callRoomId,
    String? fromUserId,
    String? toUserId,
    String? recordingUrl,
    int? duration,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceRecording',
      if (id != null) 'id': id,
      'callRoomId': callRoomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'recordingUrl': recordingUrl,
      'duration': duration,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceRecording',
      if (id != null) 'id': id,
      'callRoomId': callRoomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'recordingUrl': recordingUrl,
      'duration': duration,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VoiceRecordingImpl extends VoiceRecording {
  _VoiceRecordingImpl({
    int? id,
    required String callRoomId,
    required String fromUserId,
    required String toUserId,
    required String recordingUrl,
    required int duration,
    required DateTime createdAt,
  }) : super._(
         id: id,
         callRoomId: callRoomId,
         fromUserId: fromUserId,
         toUserId: toUserId,
         recordingUrl: recordingUrl,
         duration: duration,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VoiceRecording]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VoiceRecording copyWith({
    Object? id = _Undefined,
    String? callRoomId,
    String? fromUserId,
    String? toUserId,
    String? recordingUrl,
    int? duration,
    DateTime? createdAt,
  }) {
    return VoiceRecording(
      id: id is int? ? id : this.id,
      callRoomId: callRoomId ?? this.callRoomId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      recordingUrl: recordingUrl ?? this.recordingUrl,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
