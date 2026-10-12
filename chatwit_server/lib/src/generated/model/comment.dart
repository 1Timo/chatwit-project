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

abstract class Comment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _ibxtvcw4.Protocol().deserialize<_igzn5sah.UserRegistration>(
              jsonSerialization['author'],
            ),
      userName: jsonSerialization['userName'] as String,
      fullName: jsonSerialization['fullName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      text: jsonSerialization['text'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CommentTable();

  static const db = CommentRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static CommentInclude include({_igzn5sah.UserRegistrationInclude? author}) {
    return CommentInclude._(author: author);
  }

  static CommentIncludeList includeList({
    _is.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    CommentInclude? include,
  }) {
    return CommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class CommentUpdateTable extends _is.UpdateTable<CommentTable> {
  CommentUpdateTable(super.table);

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> authorId(int? value) => _is.ColumnValue(
    table.authorId,
    value,
  );

  _is.ColumnValue<String, String> userName(String value) => _is.ColumnValue(
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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CommentTable extends _is.Table<int?> {
  CommentTable({super.tableRelation}) : super(tableName: 'comment') {
    updateTable = CommentUpdateTable(this);
    postId = _is.ColumnInt(
      'postId',
      this,
    );
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CommentUpdateTable updateTable;

  late final _is.ColumnInt postId;

  late final _is.ColumnString userId;

  late final _is.ColumnInt authorId;

  _igzn5sah.UserRegistrationTable? _author;

  late final _is.ColumnString userName;

  late final _is.ColumnString fullName;

  late final _is.ColumnString profileImageUrl;

  late final _is.ColumnString text;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnString videoUrl;

  late final _is.ColumnDateTime createdAt;

  _igzn5sah.UserRegistrationTable get author {
    if (_author != null) return _author!;
    _author = _is.createRelationTable(
      relationFieldName: 'author',
      field: Comment.t.authorId,
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
    postId,
    userId,
    authorId,
    userName,
    fullName,
    profileImageUrl,
    text,
    imageUrl,
    videoUrl,
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

class CommentInclude extends _is.IncludeObject {
  CommentInclude._({_igzn5sah.UserRegistrationInclude? author}) {
    _author = author;
  }

  _igzn5sah.UserRegistrationInclude? _author;

  @override
  Map<String, _is.Include?> get includes => {'author': _author};

  @override
  _is.Table<int?> get table => Comment.t;
}

class CommentIncludeList extends _is.IncludeList {
  CommentIncludeList._({
    _is.WhereExpressionBuilder<CommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Comment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Comment.t;
}

class CommentRepository {
  const CommentRepository._();

  final attachRow = const CommentAttachRowRepository._();

  final detachRow = const CommentDetachRowRepository._();

  /// Returns a list of [Comment]s matching the given query parameters.
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
  Future<List<Comment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    _is.Transaction? transaction,
    CommentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Comment] matching the given query parameters.
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
  Future<Comment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommentTable>? where,
    int? offset,
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    _is.Transaction? transaction,
    CommentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Comment] by its [id] or null if no such row exists.
  Future<Comment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CommentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Comment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Comment]s in the list and returns the inserted rows.
  ///
  /// The returned [Comment]s will have their `id` fields set.
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
  Future<List<Comment>> insert(
    _is.DatabaseSession session,
    List<Comment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Comment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Comment] and returns the inserted row.
  ///
  /// The returned [Comment] will have its `id` field set.
  Future<Comment> insertRow(
    _is.DatabaseSession session,
    Comment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Comment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Comment]s in the list and returns the resulting rows.
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
  /// The returned [Comment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Comment>> upsert(
    _is.DatabaseSession session,
    List<Comment> rows, {
    required _is.ColumnSelections<CommentTable> conflictColumns,
    _is.ColumnSelections<CommentTable>? updateColumns,
    _is.WhereExpressionBuilder<CommentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Comment>(
      rows,
      conflictColumns: conflictColumns(Comment.t),
      updateColumns: updateColumns?.call(Comment.t),
      updateWhere: updateWhere?.call(Comment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Comment] and returns the resulting row.
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
  /// The returned [Comment] will have its `id` field set.
  Future<Comment?> upsertRow(
    _is.DatabaseSession session,
    Comment row, {
    required _is.ColumnSelections<CommentTable> conflictColumns,
    _is.ColumnSelections<CommentTable>? updateColumns,
    _is.WhereExpressionBuilder<CommentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Comment>(
      row,
      conflictColumns: conflictColumns(Comment.t),
      updateColumns: updateColumns?.call(Comment.t),
      updateWhere: updateWhere?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Updates all [Comment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Comment>> update(
    _is.DatabaseSession session,
    List<Comment> rows, {
    _is.ColumnSelections<CommentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Comment>(
      rows,
      columns: columns?.call(Comment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Comment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Comment> updateRow(
    _is.DatabaseSession session,
    Comment row, {
    _is.ColumnSelections<CommentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Comment>(
      row,
      columns: columns?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Comment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Comment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CommentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Comment>(
      id,
      columnValues: columnValues(Comment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Comment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Comment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CommentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CommentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Comment>(
      columnValues: columnValues(Comment.t.updateTable),
      where: where(Comment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Comment]s in the list and returns the deleted rows.
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
  Future<List<Comment>> delete(
    _is.DatabaseSession session,
    List<Comment> rows, {
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Comment>(
      rows,
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Comment].
  Future<Comment> deleteRow(
    _is.DatabaseSession session,
    Comment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Comment>(
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
  Future<List<Comment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CommentTable> where,
    _is.OrderByBuilder<CommentTable>? orderBy,
    _is.OrderByListBuilder<CommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Comment>(
      where: where(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Comment>(
      where: where?.call(Comment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Comment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CommentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Comment>(
      where: where(Comment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CommentAttachRowRepository {
  const CommentAttachRowRepository._();

  /// Creates a relation between the given [Comment] and [UserRegistration]
  /// by setting the [Comment]'s foreign key `authorId` to refer to the [UserRegistration].
  Future<void> author(
    _is.DatabaseSession session,
    Comment comment,
    _igzn5sah.UserRegistration author, {
    _is.Transaction? transaction,
  }) async {
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }
    if (author.id == null) {
      throw ArgumentError.notNull('author.id');
    }

    var $comment = comment.copyWith(authorId: author.id);
    await session.db.updateRow<Comment>(
      $comment,
      columns: [Comment.t.authorId],
      transaction: transaction,
    );
  }
}

class CommentDetachRowRepository {
  const CommentDetachRowRepository._();

  /// Detaches the relation between this [Comment] and the [UserRegistration] set in `author`
  /// by setting the [Comment]'s foreign key `authorId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> author(
    _is.DatabaseSession session,
    Comment comment, {
    _is.Transaction? transaction,
  }) async {
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }

    var $comment = comment.copyWith(authorId: null);
    await session.db.updateRow<Comment>(
      $comment,
      columns: [Comment.t.authorId],
      transaction: transaction,
    );
  }
}
