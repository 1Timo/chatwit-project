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

abstract class Conversation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Conversation._({
    required this.otherUserId,
    required this.otherUserName,
    this.profileImageUrl,
    this.lastMessage,
    required this.updatedAt,
  });

  factory Conversation({
    required String otherUserId,
    required String otherUserName,
    String? profileImageUrl,
    String? lastMessage,
    required DateTime updatedAt,
  }) = _ConversationImpl;

  factory Conversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Conversation(
      otherUserId: jsonSerialization['otherUserId'] as String,
      otherUserName: jsonSerialization['otherUserName'] as String,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      lastMessage: jsonSerialization['lastMessage'] as String?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  String otherUserId;

  String otherUserName;

  String? profileImageUrl;

  String? lastMessage;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Conversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Conversation copyWith({
    String? otherUserId,
    String? otherUserName,
    String? profileImageUrl,
    String? lastMessage,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Conversation',
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (lastMessage != null) 'lastMessage': lastMessage,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Conversation',
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (lastMessage != null) 'lastMessage': lastMessage,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationImpl extends Conversation {
  _ConversationImpl({
    required String otherUserId,
    required String otherUserName,
    String? profileImageUrl,
    String? lastMessage,
    required DateTime updatedAt,
  }) : super._(
         otherUserId: otherUserId,
         otherUserName: otherUserName,
         profileImageUrl: profileImageUrl,
         lastMessage: lastMessage,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Conversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Conversation copyWith({
    String? otherUserId,
    String? otherUserName,
    Object? profileImageUrl = _Undefined,
    Object? lastMessage = _Undefined,
    DateTime? updatedAt,
  }) {
    return Conversation(
      otherUserId: otherUserId ?? this.otherUserId,
      otherUserName: otherUserName ?? this.otherUserName,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      lastMessage: lastMessage is String? ? lastMessage : this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
