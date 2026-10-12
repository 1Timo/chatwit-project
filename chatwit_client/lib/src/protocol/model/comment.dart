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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../model/user_registration.dart' as _igzn5sah;

abstract class Comment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Comment._({
    this.id,
    required this.postId,
    required this.userId,
    this.authorId,
    this.author,
    required this.userName,
    this.fullName,
    this.profileImageUrl,
    this.text,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
  });

  factory Comment({
    int? id,
    required int postId,
    required String userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    required String userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    required DateTime createdAt,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as String,
      authorId: jsonSerialization['authorId'] as int?,
      author: jsonSerialization['author'] == null
          ? null
          : _irxho4jq.Protocol().deserialize<_igzn5sah.UserRegistration>(
              jsonSerialization['author'],
            ),
      userName: jsonSerialization['userName'] as String,
      fullName: jsonSerialization['fullName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      text: jsonSerialization['text'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int postId;

  String userId;

  int? authorId;

  _igzn5sah.UserRegistration? author;

  String userName;

  String? fullName;

  String? profileImageUrl;

  String? text;

  String? imageUrl;

  String? videoUrl;

  DateTime createdAt;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Comment copyWith({
    int? id,
    int? postId,
    String? userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    String? userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (authorId != null) 'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      'userName': userName,
      if (fullName != null) 'fullName': fullName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (authorId != null) 'authorId': authorId,
      if (author != null) 'author': author?.toJsonForProtocol(),
      'userName': userName,
      if (fullName != null) 'fullName': fullName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int postId,
    required String userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    required String userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    required DateTime createdAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         authorId: authorId,
         author: author,
         userName: userName,
         fullName: fullName,
         profileImageUrl: profileImageUrl,
         text: text,
         imageUrl: imageUrl,
         videoUrl: videoUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? postId,
    String? userId,
    Object? authorId = _Undefined,
    Object? author = _Undefined,
    String? userName,
    Object? fullName = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? text = _Undefined,
    Object? imageUrl = _Undefined,
    Object? videoUrl = _Undefined,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      authorId: authorId is int? ? authorId : this.authorId,
      author: author is _igzn5sah.UserRegistration?
          ? author
          : this.author?.copyWith(),
      userName: userName ?? this.userName,
      fullName: fullName is String? ? fullName : this.fullName,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      text: text is String? ? text : this.text,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      videoUrl: videoUrl is String? ? videoUrl : this.videoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
