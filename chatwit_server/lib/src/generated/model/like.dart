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

abstract class Like implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Like._({
    this.id,
    required this.postId,
    required this.userId,
    this.username,
    required this.createdAt,
  });

  factory Like({
    int? id,
    required int postId,
    required String userId,
    String? username,
    required DateTime createdAt,
  }) = _LikeImpl;

  factory Like.fromJson(Map<String, dynamic> jsonSerialization) {
    return Like(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as String,
      username: jsonSerialization['username'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = LikeTable();

  static const db = LikeRepository._();

  @override
  int? id;

  int postId;

  String userId;

  String? username;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Like]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Like copyWith({
    int? id,
    int? postId,
    String? userId,
    String? username,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Like',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (username != null) 'username': username,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Like',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      if (username != null) 'username': username,
      'createdAt': createdAt.toJson(),
    };
  }

  static LikeInclude include() {
    return LikeInclude._();
  }

  static LikeIncludeList includeList({
    _is.WhereExpressionBuilder<LikeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    LikeInclude? include,
  }) {
    return LikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LikeImpl extends Like {
  _LikeImpl({
    int? id,
    required int postId,
    required String userId,
    String? username,
    required DateTime createdAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         username: username,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Like]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Like copyWith({
    Object? id = _Undefined,
    int? postId,
    String? userId,
    Object? username = _Undefined,
    DateTime? createdAt,
  }) {
    return Like(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      username: username is String? ? username : this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LikeUpdateTable extends _is.UpdateTable<LikeTable> {
  LikeUpdateTable(super.table);

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> username(String? value) => _is.ColumnValue(
    table.username,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class LikeTable extends _is.Table<int?> {
  LikeTable({super.tableRelation}) : super(tableName: 'like') {
    updateTable = LikeUpdateTable(this);
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    username = _is.ColumnString(
      'username',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final LikeUpdateTable updateTable;

  late final _is.ColumnInt postId;

  late final _is.ColumnString userId;

  late final _is.ColumnString username;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    postId,
    userId,
    username,
    createdAt,
  ];
}

class LikeInclude extends _is.IncludeObject {
  LikeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Like.t;
}

class LikeIncludeList extends _is.IncludeList {
  LikeIncludeList._({
    _is.WhereExpressionBuilder<LikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Like.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Like.t;
}

class LikeRepository {
  const LikeRepository._();

  /// Returns a list of [Like]s matching the given query parameters.
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
  Future<List<Like>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LikeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Like>(
      where: where?.call(Like.t),
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Like] matching the given query parameters.
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
  Future<Like?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LikeTable>? where,
    int? offset,
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Like>(
      where: where?.call(Like.t),
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Like] by its [id] or null if no such row exists.
  Future<Like?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Like>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Like]s in the list and returns the inserted rows.
  ///
  /// The returned [Like]s will have their `id` fields set.
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
  Future<List<Like>> insert(
    _is.DatabaseSession session,
    List<Like> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Like>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Like] and returns the inserted row.
  ///
  /// The returned [Like] will have its `id` field set.
  Future<Like> insertRow(
    _is.DatabaseSession session,
    Like row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Like>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Like]s in the list and returns the resulting rows.
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
  /// The returned [Like]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Like>> upsert(
    _is.DatabaseSession session,
    List<Like> rows, {
    required _is.ColumnSelections<LikeTable> conflictColumns,
    _is.ColumnSelections<LikeTable>? updateColumns,
    _is.WhereExpressionBuilder<LikeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Like>(
      rows,
      conflictColumns: conflictColumns(Like.t),
      updateColumns: updateColumns?.call(Like.t),
      updateWhere: updateWhere?.call(Like.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Like] and returns the resulting row.
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
  /// The returned [Like] will have its `id` field set.
  Future<Like?> upsertRow(
    _is.DatabaseSession session,
    Like row, {
    required _is.ColumnSelections<LikeTable> conflictColumns,
    _is.ColumnSelections<LikeTable>? updateColumns,
    _is.WhereExpressionBuilder<LikeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Like>(
      row,
      conflictColumns: conflictColumns(Like.t),
      updateColumns: updateColumns?.call(Like.t),
      updateWhere: updateWhere?.call(Like.t),
      transaction: transaction,
    );
  }

  /// Updates all [Like]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Like>> update(
    _is.DatabaseSession session,
    List<Like> rows, {
    _is.ColumnSelections<LikeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Like>(
      rows,
      columns: columns?.call(Like.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Like]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Like> updateRow(
    _is.DatabaseSession session,
    Like row, {
    _is.ColumnSelections<LikeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Like>(
      row,
      columns: columns?.call(Like.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Like] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Like?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LikeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Like>(
      id,
      columnValues: columnValues(Like.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Like]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Like>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LikeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LikeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Like>(
      columnValues: columnValues(Like.t.updateTable),
      where: where(Like.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Like]s in the list and returns the deleted rows.
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
  Future<List<Like>> delete(
    _is.DatabaseSession session,
    List<Like> rows, {
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Like>(
      rows,
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Like].
  Future<Like> deleteRow(
    _is.DatabaseSession session,
    Like row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Like>(
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
  Future<List<Like>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LikeTable> where,
    _is.OrderByBuilder<LikeTable>? orderBy,
    _is.OrderByListBuilder<LikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Like>(
      where: where(Like.t),
      orderBy: orderBy?.call(Like.t),
      orderByList: orderByList?.call(Like.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LikeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Like>(
      where: where?.call(Like.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Like] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LikeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Like>(
      where: where(Like.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
