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

abstract class Poll
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Poll._({
    this.id,
    required this.question,
    required this.options,
    required this.createdByUserId,
    required this.createdAt,
    int? totalVotes,
    bool? isClosed,
    this.expiresAt,
  }) : totalVotes = totalVotes ?? 0,
       isClosed = isClosed ?? false;

  factory Poll({
    int? id,
    required String question,
    required String options,
    required String createdByUserId,
    required DateTime createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  }) = _PollImpl;

  factory Poll.fromJson(Map<String, dynamic> jsonSerialization) {
    return Poll(
      id: jsonSerialization['id'] as int?,
      question: jsonSerialization['question'] as String,
      options: jsonSerialization['options'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      totalVotes: jsonSerialization['totalVotes'] as int?,
      isClosed: jsonSerialization['isClosed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isClosed']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String question;

  String options;

  String createdByUserId;

  DateTime createdAt;

  int totalVotes;

  bool isClosed;

  DateTime? expiresAt;

  /// Returns a shallow copy of this [Poll]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Poll copyWith({
    int? id,
    String? question,
    String? options,
    String? createdByUserId,
    DateTime? createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Poll',
      if (id != null) 'id': id,
      'question': question,
      'options': options,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'totalVotes': totalVotes,
      'isClosed': isClosed,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Poll',
      if (id != null) 'id': id,
      'question': question,
      'options': options,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'totalVotes': totalVotes,
      'isClosed': isClosed,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollImpl extends Poll {
  _PollImpl({
    int? id,
    required String question,
    required String options,
    required String createdByUserId,
    required DateTime createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         question: question,
         options: options,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         totalVotes: totalVotes,
         isClosed: isClosed,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [Poll]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Poll copyWith({
    Object? id = _Undefined,
    String? question,
    String? options,
    String? createdByUserId,
    DateTime? createdAt,
    int? totalVotes,
    bool? isClosed,
    Object? expiresAt = _Undefined,
  }) {
    return Poll(
      id: id is int? ? id : this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      totalVotes: totalVotes ?? this.totalVotes,
      isClosed: isClosed ?? this.isClosed,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
