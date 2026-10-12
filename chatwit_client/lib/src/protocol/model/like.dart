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

abstract class Like
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Like._({
    this.id,
    required this.postId,
    required this.userId,
    this.username,
    required this.createdAt,
  });

  factory Like({
    int? id,
    required int postId,
    required String userId,
    String? username,
    required DateTime createdAt,
  }) = _LikeImpl;

  factory Like.fromJson(Map<String, dynamic> jsonSerialization) {
    return Like(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as String,
      username: jsonSerialization['username'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int postId;

  String userId;

  String? username;

  DateTime createdAt;

  /// Returns a shallow copy of this [Like]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Like copyWith({
    int? id,
    int? postId,
    String? userId,
    String? username,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Like',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (username != null) 'username': username,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Like',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (username != null) 'username': username,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LikeImpl extends Like {
  _LikeImpl({
    int? id,
    required int postId,
    required String userId,
    String? username,
    required DateTime createdAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         username: username,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Like]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Like copyWith({
    Object? id = _Undefined,
    int? postId,
    String? userId,
    Object? username = _Undefined,
    DateTime? createdAt,
  }) {
    return Like(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      username: username is String? ? username : this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
