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

abstract class CallSignalEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CallSignalEvent._({
    this.id,
    required this.roomId,
    required this.fromUserId,
    required this.toUserId,
    required this.type,
    this.payload,
    required this.createdAt,
  });

  factory CallSignalEvent({
    int? id,
    required String roomId,
    required String fromUserId,
    required String toUserId,
    required String type,
    String? payload,
    required DateTime createdAt,
  }) = _CallSignalEventImpl;

  factory CallSignalEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CallSignalEvent(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as String,
      fromUserId: jsonSerialization['fromUserId'] as String,
      toUserId: jsonSerialization['toUserId'] as String,
      type: jsonSerialization['type'] as String,
      payload: jsonSerialization['payload'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomId;

  String fromUserId;

  String toUserId;

  String type;

  String? payload;

  DateTime createdAt;

  /// Returns a shallow copy of this [CallSignalEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CallSignalEvent copyWith({
    int? id,
    String? roomId,
    String? fromUserId,
    String? toUserId,
    String? type,
    String? payload,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CallSignalEvent',
      if (id != null) 'id': id,
      'roomId': roomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'type': type,
      if (payload != null) 'payload': payload,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CallSignalEvent',
      if (id != null) 'id': id,
      'roomId': roomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'type': type,
      if (payload != null) 'payload': payload,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CallSignalEventImpl extends CallSignalEvent {
  _CallSignalEventImpl({
    int? id,
    required String roomId,
    required String fromUserId,
    required String toUserId,
    required String type,
    String? payload,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         fromUserId: fromUserId,
         toUserId: toUserId,
         type: type,
         payload: payload,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CallSignalEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CallSignalEvent copyWith({
    Object? id = _Undefined,
    String? roomId,
    String? fromUserId,
    String? toUserId,
    String? type,
    Object? payload = _Undefined,
    DateTime? createdAt,
  }) {
    return CallSignalEvent(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      type: type ?? this.type,
      payload: payload is String? ? payload : this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
