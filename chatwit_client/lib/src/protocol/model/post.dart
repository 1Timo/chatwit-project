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

abstract class Post
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Post._({
    this.id,
    required this.userId,
    this.authorId,
    this.author,
    this.userName,
    this.fullName,
    this.profileImageUrl,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.category,
    this.location,
    String? audience,
    int? viewCount,
    required this.createdAt,
  }) : audience = audience ?? 'everyone',
       viewCount = viewCount ?? 0;

  factory Post({
    int? id,
    required String userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    String? userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? category,
    String? location,
    String? audience,
    int? viewCount,
    required DateTime createdAt,
  }) = _PostImpl;

  factory Post.fromJson(Map<String, dynamic> jsonSerialization) {
    return Post(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      authorId: jsonSerialization['authorId'] as int?,
      author: jsonSerialization['author'] == null
          ? null
          : _irxho4jq.Protocol().deserialize<_igzn5sah.UserRegistration>(
              jsonSerialization['author'],
            ),
      userName: jsonSerialization['userName'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      text: jsonSerialization['text'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      category: jsonSerialization['category'] as String?,
      location: jsonSerialization['location'] as String?,
      audience: jsonSerialization['audience'] as String?,
      viewCount: jsonSerialization['viewCount'] as int?,
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

  int? authorId;

  _igzn5sah.UserRegistration? author;

  String? userName;

  String? fullName;

  String? profileImageUrl;

  String? text;

  String? imageUrl;

  String? videoUrl;

  String? category;

  String? location;

  String audience;

  int viewCount;

  DateTime createdAt;

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Post copyWith({
    int? id,
    String? userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    String? userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? category,
    String? location,
    String? audience,
    int? viewCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Post',
      if (id != null) 'id': id,
      'userId': userId,
      if (authorId != null) 'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      if (userName != null) 'userName': userName,
      if (fullName != null) 'fullName': fullName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (category != null) 'category': category,
      if (location != null) 'location': location,
      'audience': audience,
      'viewCount': viewCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Post',
      if (id != null) 'id': id,
      'userId': userId,
      if (authorId != null) 'authorId': authorId,
      if (author != null) 'author': author?.toJsonForProtocol(),
      if (userName != null) 'userName': userName,
      if (fullName != null) 'fullName': fullName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (category != null) 'category': category,
      if (location != null) 'location': location,
      'audience': audience,
      'viewCount': viewCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostImpl extends Post {
  _PostImpl({
    int? id,
    required String userId,
    int? authorId,
    _igzn5sah.UserRegistration? author,
    String? userName,
    String? fullName,
    String? profileImageUrl,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? category,
    String? location,
    String? audience,
    int? viewCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         authorId: authorId,
         author: author,
         userName: userName,
         fullName: fullName,
         profileImageUrl: profileImageUrl,
         text: text,
         imageUrl: imageUrl,
         videoUrl: videoUrl,
         category: category,
         location: location,
         audience: audience,
         viewCount: viewCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Post copyWith({
    Object? id = _Undefined,
    String? userId,
    Object? authorId = _Undefined,
    Object? author = _Undefined,
    Object? userName = _Undefined,
    Object? fullName = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? text = _Undefined,
    Object? imageUrl = _Undefined,
    Object? videoUrl = _Undefined,
    Object? category = _Undefined,
    Object? location = _Undefined,
    String? audience,
    int? viewCount,
    DateTime? createdAt,
  }) {
    return Post(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      authorId: authorId is int? ? authorId : this.authorId,
      author: author is _igzn5sah.UserRegistration?
          ? author
          : this.author?.copyWith(),
      userName: userName is String? ? userName : this.userName,
      fullName: fullName is String? ? fullName : this.fullName,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      text: text is String? ? text : this.text,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      videoUrl: videoUrl is String? ? videoUrl : this.videoUrl,
      category: category is String? ? category : this.category,
      location: location is String? ? location : this.location,
      audience: audience ?? this.audience,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
