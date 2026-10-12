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

abstract class PostInteraction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PostInteraction._({
    this.id,
    required this.userId,
    required this.postId,
    required this.interactionType,
    required this.createdAt,
  });

  factory PostInteraction({
    int? id,
    required String userId,
    required int postId,
    required String interactionType,
    required DateTime createdAt,
  }) = _PostInteractionImpl;

  factory PostInteraction.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostInteraction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      postId: jsonSerialization['postId'] as int,
      interactionType: jsonSerialization['interactionType'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  int postId;

  String interactionType;

  DateTime createdAt;

  /// Returns a shallow copy of this [PostInteraction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PostInteraction copyWith({
    int? id,
    String? userId,
    int? postId,
    String? interactionType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'interactionType': interactionType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'interactionType': interactionType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostInteractionImpl extends PostInteraction {
  _PostInteractionImpl({
    int? id,
    required String userId,
    required int postId,
    required String interactionType,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         postId: postId,
         interactionType: interactionType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostInteraction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PostInteraction copyWith({
    Object? id = _Undefined,
    String? userId,
    int? postId,
    String? interactionType,
    DateTime? createdAt,
  }) {
    return PostInteraction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      interactionType: interactionType ?? this.interactionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
