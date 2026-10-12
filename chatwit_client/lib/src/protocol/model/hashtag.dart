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

abstract class Hashtag
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Hashtag._({
    this.id,
    required this.tag,
    required this.postId,
    required this.createdAt,
  });

  factory Hashtag({
    int? id,
    required String tag,
    required int postId,
    required DateTime createdAt,
  }) = _HashtagImpl;

  factory Hashtag.fromJson(Map<String, dynamic> jsonSerialization) {
    return Hashtag(
      id: jsonSerialization['id'] as int?,
      tag: jsonSerialization['tag'] as String,
      postId: jsonSerialization['postId'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String tag;

  int postId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Hashtag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Hashtag copyWith({
    int? id,
    String? tag,
    int? postId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Hashtag',
      if (id != null) 'id': id,
      'tag': tag,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Hashtag',
      if (id != null) 'id': id,
      'tag': tag,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HashtagImpl extends Hashtag {
  _HashtagImpl({
    int? id,
    required String tag,
    required int postId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         tag: tag,
         postId: postId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Hashtag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Hashtag copyWith({
    Object? id = _Undefined,
    String? tag,
    int? postId,
    DateTime? createdAt,
  }) {
    return Hashtag(
      id: id is int? ? id : this.id,
      tag: tag ?? this.tag,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
