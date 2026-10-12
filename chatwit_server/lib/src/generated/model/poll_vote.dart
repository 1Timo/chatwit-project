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

abstract class PollVote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PollVote._({
    this.id,
    required this.pollId,
    required this.userId,
    required this.optionIndex,
    required this.createdAt,
  });

  factory PollVote({
    int? id,
    required int pollId,
    required String userId,
    required int optionIndex,
    required DateTime createdAt,
  }) = _PollVoteImpl;

  factory PollVote.fromJson(Map<String, dynamic> jsonSerialization) {
    return PollVote(
      id: jsonSerialization['id'] as int?,
      pollId: jsonSerialization['pollId'] as int,
      userId: jsonSerialization['userId'] as String,
      optionIndex: jsonSerialization['optionIndex'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PollVoteTable();

  static const db = PollVoteRepository._();

  @override
  int? id;

  int pollId;

  String userId;

  int optionIndex;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PollVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PollVote copyWith({
    int? id,
    int? pollId,
    String? userId,
    int? optionIndex,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PollVote',
      if (id != null) 'id': id,
      'pollId': pollId,
      'userId': userId,
      'optionIndex': optionIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PollVote',
      if (id != null) 'id': id,
      'pollId': pollId,
      'userId': userId,
      'optionIndex': optionIndex,
      'createdAt': createdAt.toJson(),
    };
  }

  static PollVoteInclude include() {
    return PollVoteInclude._();
  }

  static PollVoteIncludeList includeList({
    _is.WhereExpressionBuilder<PollVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    PollVoteInclude? include,
  }) {
    return PollVoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollVoteImpl extends PollVote {
  _PollVoteImpl({
    int? id,
    required int pollId,
    required String userId,
    required int optionIndex,
    required DateTime createdAt,
  }) : super._(
         id: id,
         pollId: pollId,
         userId: userId,
         optionIndex: optionIndex,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PollVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PollVote copyWith({
    Object? id = _Undefined,
    int? pollId,
    String? userId,
    int? optionIndex,
    DateTime? createdAt,
  }) {
    return PollVote(
      id: id is int? ? id : this.id,
      pollId: pollId ?? this.pollId,
      userId: userId ?? this.userId,
      optionIndex: optionIndex ?? this.optionIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PollVoteUpdateTable extends _is.UpdateTable<PollVoteTable> {
  PollVoteUpdateTable(super.table);

  _is.ColumnValue<int, int> pollId(int value) => _is.ColumnValue(
    table.pollId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> optionIndex(int value) => _is.ColumnValue(
    table.optionIndex,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PollVoteTable extends _is.Table<int?> {
  PollVoteTable({super.tableRelation}) : super(tableName: 'poll_vote') {
    updateTable = PollVoteUpdateTable(this);
    pollId = _is.ColumnInt(
      'pollId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    optionIndex = _is.ColumnInt(
      'optionIndex',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PollVoteUpdateTable updateTable;

  late final _is.ColumnInt pollId;

  late final _is.ColumnString userId;

  late final _is.ColumnInt optionIndex;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    pollId,
    userId,
    optionIndex,
    createdAt,
  ];
}

class PollVoteInclude extends _is.IncludeObject {
  PollVoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PollVote.t;
}

class PollVoteIncludeList extends _is.IncludeList {
  PollVoteIncludeList._({
    _is.WhereExpressionBuilder<PollVoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PollVote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PollVote.t;
}

class PollVoteRepository {
  const PollVoteRepository._();

  /// Returns a list of [PollVote]s matching the given query parameters.
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
  Future<List<PollVote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PollVote>(
      where: where?.call(PollVote.t),
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PollVote] matching the given query parameters.
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
  Future<PollVote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollVoteTable>? where,
    int? offset,
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PollVote>(
      where: where?.call(PollVote.t),
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PollVote] by its [id] or null if no such row exists.
  Future<PollVote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PollVote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PollVote]s in the list and returns the inserted rows.
  ///
  /// The returned [PollVote]s will have their `id` fields set.
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
  Future<List<PollVote>> insert(
    _is.DatabaseSession session,
    List<PollVote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PollVote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PollVote] and returns the inserted row.
  ///
  /// The returned [PollVote] will have its `id` field set.
  Future<PollVote> insertRow(
    _is.DatabaseSession session,
    PollVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PollVote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PollVote]s in the list and returns the resulting rows.
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
  /// The returned [PollVote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PollVote>> upsert(
    _is.DatabaseSession session,
    List<PollVote> rows, {
    required _is.ColumnSelections<PollVoteTable> conflictColumns,
    _is.ColumnSelections<PollVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<PollVoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PollVote>(
      rows,
      conflictColumns: conflictColumns(PollVote.t),
      updateColumns: updateColumns?.call(PollVote.t),
      updateWhere: updateWhere?.call(PollVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PollVote] and returns the resulting row.
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
  /// The returned [PollVote] will have its `id` field set.
  Future<PollVote?> upsertRow(
    _is.DatabaseSession session,
    PollVote row, {
    required _is.ColumnSelections<PollVoteTable> conflictColumns,
    _is.ColumnSelections<PollVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<PollVoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PollVote>(
      row,
      conflictColumns: conflictColumns(PollVote.t),
      updateColumns: updateColumns?.call(PollVote.t),
      updateWhere: updateWhere?.call(PollVote.t),
      transaction: transaction,
    );
  }

  /// Updates all [PollVote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PollVote>> update(
    _is.DatabaseSession session,
    List<PollVote> rows, {
    _is.ColumnSelections<PollVoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PollVote>(
      rows,
      columns: columns?.call(PollVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PollVote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PollVote> updateRow(
    _is.DatabaseSession session,
    PollVote row, {
    _is.ColumnSelections<PollVoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PollVote>(
      row,
      columns: columns?.call(PollVote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PollVote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PollVote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PollVoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PollVote>(
      id,
      columnValues: columnValues(PollVote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PollVote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PollVote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PollVoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PollVoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PollVote>(
      columnValues: columnValues(PollVote.t.updateTable),
      where: where(PollVote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PollVote]s in the list and returns the deleted rows.
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
  Future<List<PollVote>> delete(
    _is.DatabaseSession session,
    List<PollVote> rows, {
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PollVote>(
      rows,
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PollVote].
  Future<PollVote> deleteRow(
    _is.DatabaseSession session,
    PollVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PollVote>(
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
  Future<List<PollVote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PollVoteTable> where,
    _is.OrderByBuilder<PollVoteTable>? orderBy,
    _is.OrderByListBuilder<PollVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PollVote>(
      where: where(PollVote.t),
      orderBy: orderBy?.call(PollVote.t),
      orderByList: orderByList?.call(PollVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollVoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PollVote>(
      where: where?.call(PollVote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PollVote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PollVoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PollVote>(
      where: where(PollVote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
