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

abstract class ProfilePhoto
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfilePhoto._({
    this.id,
    required this.userId,
    required this.imageType,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ProfilePhoto({
    int? id,
    required String userId,
    required String imageType,
    required String imageUrl,
    required DateTime createdAt,
  }) = _ProfilePhotoImpl;

  factory ProfilePhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfilePhoto(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      imageType: jsonSerialization['imageType'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
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

  String imageType;

  String imageUrl;

  DateTime createdAt;

  /// Returns a shallow copy of this [ProfilePhoto]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfilePhoto copyWith({
    int? id,
    String? userId,
    String? imageType,
    String? imageUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfilePhoto',
      if (id != null) 'id': id,
      'userId': userId,
      'imageType': imageType,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfilePhoto',
      if (id != null) 'id': id,
      'userId': userId,
      'imageType': imageType,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfilePhotoImpl extends ProfilePhoto {
  _ProfilePhotoImpl({
    int? id,
    required String userId,
    required String imageType,
    required String imageUrl,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         imageType: imageType,
         imageUrl: imageUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProfilePhoto]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfilePhoto copyWith({
    Object? id = _Undefined,
    String? userId,
    String? imageType,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return ProfilePhoto(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      imageType: imageType ?? this.imageType,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
