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

abstract class UserNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserNotification._({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.relatedUserId,
    this.relatedPostId,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory UserNotification({
    int? id,
    required String userId,
    required String title,
    required String body,
    required String type,
    String? relatedUserId,
    int? relatedPostId,
    bool? isRead,
    required DateTime createdAt,
  }) = _UserNotificationImpl;

  factory UserNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserNotification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      type: jsonSerialization['type'] as String,
      relatedUserId: jsonSerialization['relatedUserId'] as String?,
      relatedPostId: jsonSerialization['relatedPostId'] as int?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
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

  String title;

  String body;

  String type;

  String? relatedUserId;

  int? relatedPostId;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserNotification copyWith({
    int? id,
    String? userId,
    String? title,
    String? body,
    String? type,
    String? relatedUserId,
    int? relatedPostId,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserNotification',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      if (relatedUserId != null) 'relatedUserId': relatedUserId,
      if (relatedPostId != null) 'relatedPostId': relatedPostId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserNotification',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      if (relatedUserId != null) 'relatedUserId': relatedUserId,
      if (relatedPostId != null) 'relatedPostId': relatedPostId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserNotificationImpl extends UserNotification {
  _UserNotificationImpl({
    int? id,
    required String userId,
    required String title,
    required String body,
    required String type,
    String? relatedUserId,
    int? relatedPostId,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         body: body,
         type: type,
         relatedUserId: relatedUserId,
         relatedPostId: relatedPostId,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserNotification copyWith({
    Object? id = _Undefined,
    String? userId,
    String? title,
    String? body,
    String? type,
    Object? relatedUserId = _Undefined,
    Object? relatedPostId = _Undefined,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return UserNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      relatedUserId: relatedUserId is String?
          ? relatedUserId
          : this.relatedUserId,
      relatedPostId: relatedPostId is int? ? relatedPostId : this.relatedPostId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
