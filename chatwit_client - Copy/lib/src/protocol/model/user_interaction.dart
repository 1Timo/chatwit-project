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

abstract class UserInteraction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserInteraction._({
    this.id,
    required this.userId,
    this.category,
    this.targetUserId,
    required this.score,
    required this.createdAt,
  });

  factory UserInteraction({
    int? id,
    required String userId,
    String? category,
    String? targetUserId,
    required int score,
    required DateTime createdAt,
  }) = _UserInteractionImpl;

  factory UserInteraction.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInteraction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      category: jsonSerialization['category'] as String?,
      targetUserId: jsonSerialization['targetUserId'] as String?,
      score: jsonSerialization['score'] as int,
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

  String? category;

  String? targetUserId;

  int score;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserInteraction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserInteraction copyWith({
    int? id,
    String? userId,
    String? category,
    String? targetUserId,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      if (category != null) 'category': category,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      if (category != null) 'category': category,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInteractionImpl extends UserInteraction {
  _UserInteractionImpl({
    int? id,
    required String userId,
    String? category,
    String? targetUserId,
    required int score,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         category: category,
         targetUserId: targetUserId,
         score: score,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserInteraction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserInteraction copyWith({
    Object? id = _Undefined,
    String? userId,
    Object? category = _Undefined,
    Object? targetUserId = _Undefined,
    int? score,
    DateTime? createdAt,
  }) {
    return UserInteraction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      category: category is String? ? category : this.category,
      targetUserId: targetUserId is String? ? targetUserId : this.targetUserId,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
