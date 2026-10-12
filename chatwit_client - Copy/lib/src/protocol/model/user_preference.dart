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

abstract class UserPreference
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserPreference._({
    this.id,
    required this.userId,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPreference({
    int? id,
    required String userId,
    required String categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserPreferenceImpl;

  factory UserPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPreference(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      categories: jsonSerialization['categories'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String categories;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserPreference copyWith({
    int? id,
    String? userId,
    String? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPreference',
      if (id != null) 'id': id,
      'userId': userId,
      'categories': categories,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserPreference',
      if (id != null) 'id': id,
      'userId': userId,
      'categories': categories,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPreferenceImpl extends UserPreference {
  _UserPreferenceImpl({
    int? id,
    required String userId,
    required String categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         categories: categories,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserPreference copyWith({
    Object? id = _Undefined,
    String? userId,
    String? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreference(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
