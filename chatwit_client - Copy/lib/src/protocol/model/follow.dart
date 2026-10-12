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

abstract class Follow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Follow._({
    this.id,
    required this.followerId,
    required this.followerName,
    required this.followingId,
    required this.followingName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Follow({
    int? id,
    required String followerId,
    required String followerName,
    required String followingId,
    required String followingName,
    DateTime? createdAt,
  }) = _FollowImpl;

  factory Follow.fromJson(Map<String, dynamic> jsonSerialization) {
    return Follow(
      id: jsonSerialization['id'] as int?,
      followerId: jsonSerialization['followerId'] as String,
      followerName: jsonSerialization['followerName'] as String,
      followingId: jsonSerialization['followingId'] as String,
      followingName: jsonSerialization['followingName'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String followerId;

  String followerName;

  String followingId;

  String followingName;

  DateTime createdAt;

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Follow copyWith({
    int? id,
    String? followerId,
    String? followerName,
    String? followingId,
    String? followingName,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Follow',
      if (id != null) 'id': id,
      'followerId': followerId,
      'followerName': followerName,
      'followingId': followingId,
      'followingName': followingName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Follow',
      if (id != null) 'id': id,
      'followerId': followerId,
      'followerName': followerName,
      'followingId': followingId,
      'followingName': followingName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FollowImpl extends Follow {
  _FollowImpl({
    int? id,
    required String followerId,
    required String followerName,
    required String followingId,
    required String followingName,
    DateTime? createdAt,
  }) : super._(
         id: id,
         followerId: followerId,
         followerName: followerName,
         followingId: followingId,
         followingName: followingName,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Follow copyWith({
    Object? id = _Undefined,
    String? followerId,
    String? followerName,
    String? followingId,
    String? followingName,
    DateTime? createdAt,
  }) {
    return Follow(
      id: id is int? ? id : this.id,
      followerId: followerId ?? this.followerId,
      followerName: followerName ?? this.followerName,
      followingId: followingId ?? this.followingId,
      followingName: followingName ?? this.followingName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
