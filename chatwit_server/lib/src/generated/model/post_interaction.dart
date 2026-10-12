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

abstract class PostInteraction
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PostInteraction._({
    this.id,
    required this.userId,
    required this.postId,
    required this.interactionType,
    required this.createdAt,
  });

  factory PostInteraction({
    int? id,
    required String userId,
    required int postId,
    required String interactionType,
    required DateTime createdAt,
  }) = _PostInteractionImpl;

  factory PostInteraction.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostInteraction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      postId: jsonSerialization['postId'] as int,
      interactionType: jsonSerialization['interactionType'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PostInteractionTable();

  static const db = PostInteractionRepository._();

  @override
  int? id;

  String userId;

  int postId;

  String interactionType;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PostInteraction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PostInteraction copyWith({
    int? id,
    String? userId,
    int? postId,
    String? interactionType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'interactionType': interactionType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'interactionType': interactionType,
      'createdAt': createdAt.toJson(),
    };
  }

  static PostInteractionInclude include() {
    return PostInteractionInclude._();
  }

  static PostInteractionIncludeList includeList({
    _is.WhereExpressionBuilder<PostInteractionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    PostInteractionInclude? include,
  }) {
    return PostInteractionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostInteractionImpl extends PostInteraction {
  _PostInteractionImpl({
    int? id,
    required String userId,
    required int postId,
    required String interactionType,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         postId: postId,
         interactionType: interactionType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostInteraction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PostInteraction copyWith({
    Object? id = _Undefined,
    String? userId,
    int? postId,
    String? interactionType,
    DateTime? createdAt,
  }) {
    return PostInteraction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      interactionType: interactionType ?? this.interactionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PostInteractionUpdateTable extends _is.UpdateTable<PostInteractionTable> {
  PostInteractionUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<String, String> interactionType(String value) =>
      _is.ColumnValue(
        table.interactionType,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostInteractionTable extends _is.Table<int?> {
  PostInteractionTable({super.tableRelation})
    : super(tableName: 'post_interaction') {
    updateTable = PostInteractionUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    interactionType = _is.ColumnString(
      'interactionType',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PostInteractionUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnInt postId;

  late final _is.ColumnString interactionType;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    postId,
    interactionType,
    createdAt,
  ];
}

class PostInteractionInclude extends _is.IncludeObject {
  PostInteractionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PostInteraction.t;
}

class PostInteractionIncludeList extends _is.IncludeList {
  PostInteractionIncludeList._({
    _is.WhereExpressionBuilder<PostInteractionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PostInteraction.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PostInteraction.t;
}

class PostInteractionRepository {
  const PostInteractionRepository._();

  /// Returns a list of [PostInteraction]s matching the given query parameters.
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
  Future<List<PostInteraction>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostInteractionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PostInteraction>(
      where: where?.call(PostInteraction.t),
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PostInteraction] matching the given query parameters.
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
  Future<PostInteraction?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostInteractionTable>? where,
    int? offset,
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PostInteraction>(
      where: where?.call(PostInteraction.t),
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PostInteraction] by its [id] or null if no such row exists.
  Future<PostInteraction?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PostInteraction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PostInteraction]s in the list and returns the inserted rows.
  ///
  /// The returned [PostInteraction]s will have their `id` fields set.
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
  Future<List<PostInteraction>> insert(
    _is.DatabaseSession session,
    List<PostInteraction> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PostInteraction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PostInteraction] and returns the inserted row.
  ///
  /// The returned [PostInteraction] will have its `id` field set.
  Future<PostInteraction> insertRow(
    _is.DatabaseSession session,
    PostInteraction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PostInteraction>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PostInteraction]s in the list and returns the resulting rows.
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
  /// The returned [PostInteraction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostInteraction>> upsert(
    _is.DatabaseSession session,
    List<PostInteraction> rows, {
    required _is.ColumnSelections<PostInteractionTable> conflictColumns,
    _is.ColumnSelections<PostInteractionTable>? updateColumns,
    _is.WhereExpressionBuilder<PostInteractionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PostInteraction>(
      rows,
      conflictColumns: conflictColumns(PostInteraction.t),
      updateColumns: updateColumns?.call(PostInteraction.t),
      updateWhere: updateWhere?.call(PostInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PostInteraction] and returns the resulting row.
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
  /// The returned [PostInteraction] will have its `id` field set.
  Future<PostInteraction?> upsertRow(
    _is.DatabaseSession session,
    PostInteraction row, {
    required _is.ColumnSelections<PostInteractionTable> conflictColumns,
    _is.ColumnSelections<PostInteractionTable>? updateColumns,
    _is.WhereExpressionBuilder<PostInteractionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PostInteraction>(
      row,
      conflictColumns: conflictColumns(PostInteraction.t),
      updateColumns: updateColumns?.call(PostInteraction.t),
      updateWhere: updateWhere?.call(PostInteraction.t),
      transaction: transaction,
    );
  }

  /// Updates all [PostInteraction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostInteraction>> update(
    _is.DatabaseSession session,
    List<PostInteraction> rows, {
    _is.ColumnSelections<PostInteractionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PostInteraction>(
      rows,
      columns: columns?.call(PostInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PostInteraction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PostInteraction> updateRow(
    _is.DatabaseSession session,
    PostInteraction row, {
    _is.ColumnSelections<PostInteractionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PostInteraction>(
      row,
      columns: columns?.call(PostInteraction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostInteraction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PostInteraction?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PostInteractionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PostInteraction>(
      id,
      columnValues: columnValues(PostInteraction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PostInteraction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostInteraction>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PostInteractionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PostInteractionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PostInteraction>(
      columnValues: columnValues(PostInteraction.t.updateTable),
      where: where(PostInteraction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PostInteraction]s in the list and returns the deleted rows.
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
  Future<List<PostInteraction>> delete(
    _is.DatabaseSession session,
    List<PostInteraction> rows, {
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PostInteraction>(
      rows,
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PostInteraction].
  Future<PostInteraction> deleteRow(
    _is.DatabaseSession session,
    PostInteraction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PostInteraction>(
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
  Future<List<PostInteraction>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostInteractionTable> where,
    _is.OrderByBuilder<PostInteractionTable>? orderBy,
    _is.OrderByListBuilder<PostInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PostInteraction>(
      where: where(PostInteraction.t),
      orderBy: orderBy?.call(PostInteraction.t),
      orderByList: orderByList?.call(PostInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostInteractionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PostInteraction>(
      where: where?.call(PostInteraction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PostInteraction] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostInteractionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PostInteraction>(
      where: where(PostInteraction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
