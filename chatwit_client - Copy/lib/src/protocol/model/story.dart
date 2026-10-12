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

abstract class Story
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Story._({
    this.id,
    required this.userId,
    this.userName,
    this.profileImageUrl,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.expiresAt,
  });

  factory Story({
    int? id,
    required String userId,
    String? userName,
    String? profileImageUrl,
    required String mediaUrl,
    required String mediaType,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _StoryImpl;

  factory Story.fromJson(Map<String, dynamic> jsonSerialization) {
    return Story(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      mediaUrl: jsonSerialization['mediaUrl'] as String,
      mediaType: jsonSerialization['mediaType'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String? userName;

  String? profileImageUrl;

  String mediaUrl;

  String mediaType;

  DateTime createdAt;

  DateTime expiresAt;

  /// Returns a shallow copy of this [Story]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Story copyWith({
    int? id,
    String? userId,
    String? userName,
    String? profileImageUrl,
    String? mediaUrl,
    String? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Story',
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Story',
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoryImpl extends Story {
  _StoryImpl({
    int? id,
    required String userId,
    String? userName,
    String? profileImageUrl,
    required String mediaUrl,
    required String mediaType,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         userName: userName,
         profileImageUrl: profileImageUrl,
         mediaUrl: mediaUrl,
         mediaType: mediaType,
         createdAt: createdAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [Story]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Story copyWith({
    Object? id = _Undefined,
    String? userId,
    Object? userName = _Undefined,
    Object? profileImageUrl = _Undefined,
    String? mediaUrl,
    String? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return Story(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      userName: userName is String? ? userName : this.userName,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
