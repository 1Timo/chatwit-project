/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatwit_server/src/generated/protocol.dart' as _ibxtvcw4;
import 'package:serverpod/serverpod.dart' as _is;
import '../model/user_registration.dart' as _igzn5sah;

abstract class Post implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _ibxtvcw4.Protocol().deserialize<_igzn5sah.UserRegistration>(
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PostTable();

  static const db = PostRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static PostInclude include({_igzn5sah.UserRegistrationInclude? author}) {
    return PostInclude._(author: author);
  }

  static PostIncludeList includeList({
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    PostInclude? include,
  }) {
    return PostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class PostUpdateTable extends _is.UpdateTable<PostTable> {
  PostUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> authorId(int? value) => _is.ColumnValue(
    table.authorId,
    value,
  );

  _is.ColumnValue<String, String> userName(String? value) => _is.ColumnValue(
    table.userName,
    value,
  );

  _is.ColumnValue<String, String> fullName(String? value) => _is.ColumnValue(
    table.fullName,
    value,
  );

  _is.ColumnValue<String, String> profileImageUrl(String? value) =>
      _is.ColumnValue(
        table.profileImageUrl,
        value,
      );

  _is.ColumnValue<String, String> text(String? value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<String, String> imageUrl(String? value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<String, String> videoUrl(String? value) => _is.ColumnValue(
    table.videoUrl,
    value,
  );

  _is.ColumnValue<String, String> category(String? value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> audience(String value) => _is.ColumnValue(
    table.audience,
    value,
  );

  _is.ColumnValue<int, int> viewCount(int value) => _is.ColumnValue(
    table.viewCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostTable extends _is.Table<int?> {
  PostTable({super.tableRelation}) : super(tableName: 'post') {
    updateTable = PostUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    authorId = _is.ColumnInt(
      'authorId',
      this,
    );
    userName = _is.ColumnString(
      'userName',
      this,
    );
    fullName = _is.ColumnString(
      'fullName',
      this,
    );
    profileImageUrl = _is.ColumnString(
      'profileImageUrl',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    videoUrl = _is.ColumnString(
      'videoUrl',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    audience = _is.ColumnString(
      'audience',
      this,
      hasDefault: true,
    );
    viewCount = _is.ColumnInt(
      'viewCount',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PostUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnInt authorId;

  _igzn5sah.UserRegistrationTable? _author;

  late final _is.ColumnString userName;

  late final _is.ColumnString fullName;

  late final _is.ColumnString profileImageUrl;

  late final _is.ColumnString text;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnString videoUrl;

  late final _is.ColumnString category;

  late final _is.ColumnString location;

  late final _is.ColumnString audience;

  late final _is.ColumnInt viewCount;

  late final _is.ColumnDateTime createdAt;

  _igzn5sah.UserRegistrationTable get author {
    if (_author != null) return _author!;
    _author = _is.createRelationTable(
      relationFieldName: 'author',
      field: Post.t.authorId,
      foreignField: _igzn5sah.UserRegistration.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _igzn5sah.UserRegistrationTable(tableRelation: foreignTableRelation),
    );
    return _author!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    authorId,
    userName,
    fullName,
    profileImageUrl,
    text,
    imageUrl,
    videoUrl,
    category,
    location,
    audience,
    viewCount,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'author') {
      return author;
    }
    return null;
  }
}

class PostInclude extends _is.IncludeObject {
  PostInclude._({_igzn5sah.UserRegistrationInclude? author}) {
    _author = author;
  }

  _igzn5sah.UserRegistrationInclude? _author;

  @override
  Map<String, _is.Include?> get includes => {'author': _author};

  @override
  _is.Table<int?> get table => Post.t;
}

class PostIncludeList extends _is.IncludeList {
  PostIncludeList._({
    _is.WhereExpressionBuilder<PostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Post.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Post.t;
}

class PostRepository {
  const PostRepository._();

  final attachRow = const PostAttachRowRepository._();

  final detachRow = const PostDetachRowRepository._();

  /// Returns a list of [Post]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Post>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    PostInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Post>(
      where: where?.call(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Post] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Post?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    PostInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Post>(
      where: where?.call(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Post] by its [id] or null if no such row exists.
  Future<Post?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    PostInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Post>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Post]s in the list and returns the inserted rows.
  ///
  /// The returned [Post]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> insert(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Post>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Post] and returns the inserted row.
  ///
  /// The returned [Post] will have its `id` field set.
  Future<Post> insertRow(
    _is.DatabaseSession session,
    Post row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Post>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Post]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Post]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> upsert(
    _is.DatabaseSession session,
    List<Post> rows, {
    required _is.ColumnSelections<PostTable> conflictColumns,
    _is.ColumnSelections<PostTable>? updateColumns,
    _is.WhereExpressionBuilder<PostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Post>(
      rows,
      conflictColumns: conflictColumns(Post.t),
      updateColumns: updateColumns?.call(Post.t),
      updateWhere: updateWhere?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Post] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Post] will have its `id` field set.
  Future<Post?> upsertRow(
    _is.DatabaseSession session,
    Post row, {
    required _is.ColumnSelections<PostTable> conflictColumns,
    _is.ColumnSelections<PostTable>? updateColumns,
    _is.WhereExpressionBuilder<PostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Post>(
      row,
      conflictColumns: conflictColumns(Post.t),
      updateColumns: updateColumns?.call(Post.t),
      updateWhere: updateWhere?.call(Post.t),
      transaction: transaction,
    );
  }

  /// Updates all [Post]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> update(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.ColumnSelections<PostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Post>(
      rows,
      columns: columns?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Post]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Post> updateRow(
    _is.DatabaseSession session,
    Post row, {
    _is.ColumnSelections<PostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Post>(
      row,
      columns: columns?.call(Post.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Post] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Post?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Post>(
      id,
      columnValues: columnValues(Post.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Post]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Post>(
      columnValues: columnValues(Post.t.updateTable),
      where: where(Post.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Post]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> delete(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Post>(
      rows,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Post].
  Future<Post> deleteRow(
    _is.DatabaseSession session,
    Post row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Post>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostTable> where,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Post>(
      where: where(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Post>(
      where: where?.call(Post.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Post] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Post>(
      where: where(Post.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PostAttachRowRepository {
  const PostAttachRowRepository._();

  /// Creates a relation between the given [Post] and [UserRegistration]
  /// by setting the [Post]'s foreign key `authorId` to refer to the [UserRegistration].
  Future<void> author(
    _is.DatabaseSession session,
    Post post,
    _igzn5sah.UserRegistration author, {
    _is.Transaction? transaction,
  }) async {
    if (post.id == null) {
      throw ArgumentError.notNull('post.id');
    }
    if (author.id == null) {
      throw ArgumentError.notNull('author.id');
    }

    var $post = post.copyWith(authorId: author.id);
    await session.db.updateRow<Post>(
      $post,
      columns: [Post.t.authorId],
      transaction: transaction,
    );
  }
}

class PostDetachRowRepository {
  const PostDetachRowRepository._();

  /// Detaches the relation between this [Post] and the [UserRegistration] set in `author`
  /// by setting the [Post]'s foreign key `authorId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> author(
    _is.DatabaseSession session,
    Post post, {
    _is.Transaction? transaction,
  }) async {
    if (post.id == null) {
      throw ArgumentError.notNull('post.id');
    }

    var $post = post.copyWith(authorId: null);
    await session.db.updateRow<Post>(
      $post,
      columns: [Post.t.authorId],
      transaction: transaction,
    );
  }
}
