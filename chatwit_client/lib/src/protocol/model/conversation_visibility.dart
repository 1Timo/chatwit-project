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

abstract class ConversationVisibility
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConversationVisibility._({
    this.id,
    required this.userId,
    required this.otherUserId,
    required this.hiddenBefore,
  });

  factory ConversationVisibility({
    int? id,
    required String userId,
    required String otherUserId,
    required DateTime hiddenBefore,
  }) = _ConversationVisibilityImpl;

  factory ConversationVisibility.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ConversationVisibility(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      otherUserId: jsonSerialization['otherUserId'] as String,
      hiddenBefore: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['hiddenBefore'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String otherUserId;

  DateTime hiddenBefore;

  /// Returns a shallow copy of this [ConversationVisibility]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConversationVisibility copyWith({
    int? id,
    String? userId,
    String? otherUserId,
    DateTime? hiddenBefore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'otherUserId': otherUserId,
      'hiddenBefore': hiddenBefore.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'otherUserId': otherUserId,
      'hiddenBefore': hiddenBefore.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationVisibilityImpl extends ConversationVisibility {
  _ConversationVisibilityImpl({
    int? id,
    required String userId,
    required String otherUserId,
    required DateTime hiddenBefore,
  }) : super._(
         id: id,
         userId: userId,
         otherUserId: otherUserId,
         hiddenBefore: hiddenBefore,
       );

  /// Returns a shallow copy of this [ConversationVisibility]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConversationVisibility copyWith({
    Object? id = _Undefined,
    String? userId,
    String? otherUserId,
    DateTime? hiddenBefore,
  }) {
    return ConversationVisibility(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      otherUserId: otherUserId ?? this.otherUserId,
      hiddenBefore: hiddenBefore ?? this.hiddenBefore,
    );
  }
}
