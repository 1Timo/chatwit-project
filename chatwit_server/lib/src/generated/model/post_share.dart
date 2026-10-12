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
import 'package:serverpod/serverpod.dart' as _is;

abstract class PostShare
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PostShare._({
    this.id,
    required this.postId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PostShare({
    int? id,
    required int postId,
    required String userId,
    DateTime? createdAt,
  }) = _PostShareImpl;

  factory PostShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostShare(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PostShareTable();

  static const db = PostShareRepository._();

  @override
  int? id;

  int postId;

  String userId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PostShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PostShare copyWith({
    int? id,
    int? postId,
    String? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostShare',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostShare',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  static PostShareInclude include() {
    return PostShareInclude._();
  }

  static PostShareIncludeList includeList({
    _is.WhereExpressionBuilder<PostShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    PostShareInclude? include,
  }) {
    return PostShareIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostShareImpl extends PostShare {
  _PostShareImpl({
    int? id,
    required int postId,
    required String userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PostShare copyWith({
    Object? id = _Undefined,
    int? postId,
    String? userId,
    DateTime? createdAt,
  }) {
    return PostShare(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PostShareUpdateTable extends _is.UpdateTable<PostShareTable> {
  PostShareUpdateTable(super.table);

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostShareTable extends _is.Table<int?> {
  PostShareTable({super.tableRelation}) : super(tableName: 'post_share') {
    updateTable = PostShareUpdateTable(this);
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PostShareUpdateTable updateTable;

  late final _is.ColumnInt postId;

  late final _is.ColumnString userId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    postId,
    userId,
    createdAt,
  ];
}

class PostShareInclude extends _is.IncludeObject {
  PostShareInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PostShare.t;
}

class PostShareIncludeList extends _is.IncludeList {
  PostShareIncludeList._({
    _is.WhereExpressionBuilder<PostShareTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PostShare.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PostShare.t;
}

class PostShareRepository {
  const PostShareRepository._();

  /// Returns a list of [PostShare]s matching the given query parameters.
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
  Future<List<PostShare>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PostShare>(
      where: where?.call(PostShare.t),
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PostShare] matching the given query parameters.
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
  Future<PostShare?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostShareTable>? where,
    int? offset,
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PostShare>(
      where: where?.call(PostShare.t),
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PostShare] by its [id] or null if no such row exists.
  Future<PostShare?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PostShare>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PostShare]s in the list and returns the inserted rows.
  ///
  /// The returned [PostShare]s will have their `id` fields set.
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
  Future<List<PostShare>> insert(
    _is.DatabaseSession session,
    List<PostShare> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PostShare>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PostShare] and returns the inserted row.
  ///
  /// The returned [PostShare] will have its `id` field set.
  Future<PostShare> insertRow(
    _is.DatabaseSession session,
    PostShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PostShare>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PostShare]s in the list and returns the resulting rows.
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
  /// The returned [PostShare]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostShare>> upsert(
    _is.DatabaseSession session,
    List<PostShare> rows, {
    required _is.ColumnSelections<PostShareTable> conflictColumns,
    _is.ColumnSelections<PostShareTable>? updateColumns,
    _is.WhereExpressionBuilder<PostShareTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PostShare>(
      rows,
      conflictColumns: conflictColumns(PostShare.t),
      updateColumns: updateColumns?.call(PostShare.t),
      updateWhere: updateWhere?.call(PostShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PostShare] and returns the resulting row.
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
  /// The returned [PostShare] will have its `id` field set.
  Future<PostShare?> upsertRow(
    _is.DatabaseSession session,
    PostShare row, {
    required _is.ColumnSelections<PostShareTable> conflictColumns,
    _is.ColumnSelections<PostShareTable>? updateColumns,
    _is.WhereExpressionBuilder<PostShareTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PostShare>(
      row,
      conflictColumns: conflictColumns(PostShare.t),
      updateColumns: updateColumns?.call(PostShare.t),
      updateWhere: updateWhere?.call(PostShare.t),
      transaction: transaction,
    );
  }

  /// Updates all [PostShare]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostShare>> update(
    _is.DatabaseSession session,
    List<PostShare> rows, {
    _is.ColumnSelections<PostShareTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PostShare>(
      rows,
      columns: columns?.call(PostShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PostShare]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PostShare> updateRow(
    _is.DatabaseSession session,
    PostShare row, {
    _is.ColumnSelections<PostShareTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PostShare>(
      row,
      columns: columns?.call(PostShare.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostShare] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PostShare?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PostShareUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PostShare>(
      id,
      columnValues: columnValues(PostShare.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PostShare]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostShare>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PostShareUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PostShareTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PostShare>(
      columnValues: columnValues(PostShare.t.updateTable),
      where: where(PostShare.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PostShare]s in the list and returns the deleted rows.
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
  Future<List<PostShare>> delete(
    _is.DatabaseSession session,
    List<PostShare> rows, {
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PostShare>(
      rows,
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PostShare].
  Future<PostShare> deleteRow(
    _is.DatabaseSession session,
    PostShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PostShare>(
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
  Future<List<PostShare>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostShareTable> where,
    _is.OrderByBuilder<PostShareTable>? orderBy,
    _is.OrderByListBuilder<PostShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PostShare>(
      where: where(PostShare.t),
      orderBy: orderBy?.call(PostShare.t),
      orderByList: orderByList?.call(PostShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostShareTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PostShare>(
      where: where?.call(PostShare.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PostShare] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostShareTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PostShare>(
      where: where(PostShare.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
