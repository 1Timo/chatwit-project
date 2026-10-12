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

abstract class PollVote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PollVote._({
    this.id,
    required this.pollId,
    required this.userId,
    required this.optionIndex,
    required this.createdAt,
  });

  factory PollVote({
    int? id,
    required int pollId,
    required String userId,
    required int optionIndex,
    required DateTime createdAt,
  }) = _PollVoteImpl;

  factory PollVote.fromJson(Map<String, dynamic> jsonSerialization) {
    return PollVote(
      id: jsonSerialization['id'] as int?,
      pollId: jsonSerialization['pollId'] as int,
      userId: jsonSerialization['userId'] as String,
      optionIndex: jsonSerialization['optionIndex'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int pollId;

  String userId;

  int optionIndex;

  DateTime createdAt;

  /// Returns a shallow copy of this [PollVote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PollVote copyWith({
    int? id,
    int? pollId,
    String? userId,
    int? optionIndex,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PollVote',
      if (id != null) 'id': id,
      'pollId': pollId,
      'userId': userId,
      'optionIndex': optionIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PollVote',
      if (id != null) 'id': id,
      'pollId': pollId,
      'userId': userId,
      'optionIndex': optionIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollVoteImpl extends PollVote {
  _PollVoteImpl({
    int? id,
    required int pollId,
    required String userId,
    required int optionIndex,
    required DateTime createdAt,
  }) : super._(
         id: id,
         pollId: pollId,
         userId: userId,
         optionIndex: optionIndex,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PollVote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PollVote copyWith({
    Object? id = _Undefined,
    int? pollId,
    String? userId,
    int? optionIndex,
    DateTime? createdAt,
  }) {
    return PollVote(
      id: id is int? ? id : this.id,
      pollId: pollId ?? this.pollId,
      userId: userId ?? this.userId,
      optionIndex: optionIndex ?? this.optionIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
