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

abstract class Message
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Message._({
    this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    this.text,
    required this.createdAt,
  });

  factory Message({
    int? id,
    required String senderId,
    required String senderName,
    required String receiverId,
    String? text,
    required DateTime createdAt,
  }) = _MessageImpl;

  factory Message.fromJson(Map<String, dynamic> jsonSerialization) {
    return Message(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as String,
      senderName: jsonSerialization['senderName'] as String,
      receiverId: jsonSerialization['receiverId'] as String,
      text: jsonSerialization['text'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String senderId;

  String senderName;

  String receiverId;

  String? text;

  DateTime createdAt;

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Message copyWith({
    int? id,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? text,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Message',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      if (text != null) 'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Message',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      if (text != null) 'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageImpl extends Message {
  _MessageImpl({
    int? id,
    required String senderId,
    required String senderName,
    required String receiverId,
    String? text,
    required DateTime createdAt,
  }) : super._(
         id: id,
         senderId: senderId,
         senderName: senderName,
         receiverId: receiverId,
         text: text,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Message copyWith({
    Object? id = _Undefined,
    String? senderId,
    String? senderName,
    String? receiverId,
    Object? text = _Undefined,
    DateTime? createdAt,
  }) {
    return Message(
      id: id is int? ? id : this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      text: text is String? ? text : this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
