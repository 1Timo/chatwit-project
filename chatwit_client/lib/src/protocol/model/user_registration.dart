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
import 'package:chatwit_client/src/protocol/protocol.dart' as _irxho4jq;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class UserRegistration
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserRegistration._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.firstName,
    required this.surname,
    this.middleName,
    required this.username,
    required this.dateOfBirth,
    required this.gender,
    this.bio,
    this.occupation,
    this.backgroundUrl,
    this.profileImageUrl,
    this.location,
    this.website,
    bool? isLocationPublic,
    bool? isDobPublic,
    this.createdAt,
  }) : isLocationPublic = isLocationPublic ?? true,
       isDobPublic = isDobPublic ?? false;

  factory UserRegistration({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  }) = _UserRegistrationImpl;

  factory UserRegistration.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRegistration(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _irxho4jq.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      firstName: jsonSerialization['firstName'] as String,
      surname: jsonSerialization['surname'] as String,
      middleName: jsonSerialization['middleName'] as String?,
      username: jsonSerialization['username'] as String,
      dateOfBirth: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['dateOfBirth'],
      ),
      gender: jsonSerialization['gender'] as String,
      bio: jsonSerialization['bio'] as String?,
      occupation: jsonSerialization['occupation'] as String?,
      backgroundUrl: jsonSerialization['backgroundUrl'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      location: jsonSerialization['location'] as String?,
      website: jsonSerialization['website'] as String?,
      isLocationPublic: jsonSerialization['isLocationPublic'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['isLocationPublic'],
            ),
      isDobPublic: jsonSerialization['isDobPublic'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDobPublic']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  String firstName;

  String surname;

  String? middleName;

  String username;

  DateTime dateOfBirth;

  String gender;

  String? bio;

  String? occupation;

  String? backgroundUrl;

  String? profileImageUrl;

  String? location;

  String? website;

  bool isLocationPublic;

  bool isDobPublic;

  DateTime? createdAt;

  /// Returns a shallow copy of this [UserRegistration]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserRegistration copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? firstName,
    String? surname,
    String? middleName,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRegistration',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'surname': surname,
      if (middleName != null) 'middleName': middleName,
      'username': username,
      'dateOfBirth': dateOfBirth.toJson(),
      'gender': gender,
      if (bio != null) 'bio': bio,
      if (occupation != null) 'occupation': occupation,
      if (backgroundUrl != null) 'backgroundUrl': backgroundUrl,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      'isLocationPublic': isLocationPublic,
      'isDobPublic': isDobPublic,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRegistration',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'surname': surname,
      if (middleName != null) 'middleName': middleName,
      'username': username,
      'dateOfBirth': dateOfBirth.toJson(),
      'gender': gender,
      if (bio != null) 'bio': bio,
      if (occupation != null) 'occupation': occupation,
      if (backgroundUrl != null) 'backgroundUrl': backgroundUrl,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      'isLocationPublic': isLocationPublic,
      'isDobPublic': isDobPublic,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRegistrationImpl extends UserRegistration {
  _UserRegistrationImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         firstName: firstName,
         surname: surname,
         middleName: middleName,
         username: username,
         dateOfBirth: dateOfBirth,
         gender: gender,
         bio: bio,
         occupation: occupation,
         backgroundUrl: backgroundUrl,
         profileImageUrl: profileImageUrl,
         location: location,
         website: website,
         isLocationPublic: isLocationPublic,
         isDobPublic: isDobPublic,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserRegistration]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserRegistration copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? firstName,
    String? surname,
    Object? middleName = _Undefined,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    Object? bio = _Undefined,
    Object? occupation = _Undefined,
    Object? backgroundUrl = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? location = _Undefined,
    Object? website = _Undefined,
    bool? isLocationPublic,
    bool? isDobPublic,
    Object? createdAt = _Undefined,
  }) {
    return UserRegistration(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      middleName: middleName is String? ? middleName : this.middleName,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bio: bio is String? ? bio : this.bio,
      occupation: occupation is String? ? occupation : this.occupation,
      backgroundUrl: backgroundUrl is String?
          ? backgroundUrl
          : this.backgroundUrl,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      location: location is String? ? location : this.location,
      website: website is String? ? website : this.website,
      isLocationPublic: isLocationPublic ?? this.isLocationPublic,
      isDobPublic: isDobPublic ?? this.isDobPublic,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
