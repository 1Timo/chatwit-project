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

abstract class Poll implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Poll._({
    this.id,
    required this.question,
    required this.options,
    required this.createdByUserId,
    required this.createdAt,
    int? totalVotes,
    bool? isClosed,
    this.expiresAt,
  }) : totalVotes = totalVotes ?? 0,
       isClosed = isClosed ?? false;

  factory Poll({
    int? id,
    required String question,
    required String options,
    required String createdByUserId,
    required DateTime createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  }) = _PollImpl;

  factory Poll.fromJson(Map<String, dynamic> jsonSerialization) {
    return Poll(
      id: jsonSerialization['id'] as int?,
      question: jsonSerialization['question'] as String,
      options: jsonSerialization['options'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      totalVotes: jsonSerialization['totalVotes'] as int?,
      isClosed: jsonSerialization['isClosed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isClosed']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  static final t = PollTable();

  static const db = PollRepository._();

  @override
  int? id;

  String question;

  String options;

  String createdByUserId;

  DateTime createdAt;

  int totalVotes;

  bool isClosed;

  DateTime? expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Poll]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Poll copyWith({
    int? id,
    String? question,
    String? options,
    String? createdByUserId,
    DateTime? createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Poll',
      if (id != null) 'id': id,
      'question': question,
      'options': options,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'totalVotes': totalVotes,
      'isClosed': isClosed,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Poll',
      if (id != null) 'id': id,
      'question': question,
      'options': options,
      'createdByUserId': createdByUserId,
      'createdAt': createdAt.toJson(),
      'totalVotes': totalVotes,
      'isClosed': isClosed,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  static PollInclude include() {
    return PollInclude._();
  }

  static PollIncludeList includeList({
    _is.WhereExpressionBuilder<PollTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    PollInclude? include,
  }) {
    return PollIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollImpl extends Poll {
  _PollImpl({
    int? id,
    required String question,
    required String options,
    required String createdByUserId,
    required DateTime createdAt,
    int? totalVotes,
    bool? isClosed,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         question: question,
         options: options,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         totalVotes: totalVotes,
         isClosed: isClosed,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [Poll]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Poll copyWith({
    Object? id = _Undefined,
    String? question,
    String? options,
    String? createdByUserId,
    DateTime? createdAt,
    int? totalVotes,
    bool? isClosed,
    Object? expiresAt = _Undefined,
  }) {
    return Poll(
      id: id is int? ? id : this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      totalVotes: totalVotes ?? this.totalVotes,
      isClosed: isClosed ?? this.isClosed,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}

class PollUpdateTable extends _is.UpdateTable<PollTable> {
  PollUpdateTable(super.table);

  _is.ColumnValue<String, String> question(String value) => _is.ColumnValue(
    table.question,
    value,
  );

  _is.ColumnValue<String, String> options(String value) => _is.ColumnValue(
    table.options,
    value,
  );

  _is.ColumnValue<String, String> createdByUserId(String value) =>
      _is.ColumnValue(
        table.createdByUserId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<int, int> totalVotes(int value) => _is.ColumnValue(
    table.totalVotes,
    value,
  );

  _is.ColumnValue<bool, bool> isClosed(bool value) => _is.ColumnValue(
    table.isClosed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class PollTable extends _is.Table<int?> {
  PollTable({super.tableRelation}) : super(tableName: 'poll') {
    updateTable = PollUpdateTable(this);
    question = _is.ColumnString(
      'question',
      this,
    );
    options = _is.ColumnString(
      'options',
      this,
    );
    createdByUserId = _is.ColumnString(
      'createdByUserId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    totalVotes = _is.ColumnInt(
      'totalVotes',
      this,
      hasDefault: true,
    );
    isClosed = _is.ColumnBool(
      'isClosed',
      this,
      hasDefault: true,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final PollUpdateTable updateTable;

  late final _is.ColumnString question;

  late final _is.ColumnString options;

  late final _is.ColumnString createdByUserId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnInt totalVotes;

  late final _is.ColumnBool isClosed;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    question,
    options,
    createdByUserId,
    createdAt,
    totalVotes,
    isClosed,
    expiresAt,
  ];
}

class PollInclude extends _is.IncludeObject {
  PollInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Poll.t;
}

class PollIncludeList extends _is.IncludeList {
  PollIncludeList._({
    _is.WhereExpressionBuilder<PollTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Poll.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Poll.t;
}

class PollRepository {
  const PollRepository._();

  /// Returns a list of [Poll]s matching the given query parameters.
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
  Future<List<Poll>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Poll>(
      where: where?.call(Poll.t),
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Poll] matching the given query parameters.
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
  Future<Poll?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollTable>? where,
    int? offset,
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Poll>(
      where: where?.call(Poll.t),
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Poll] by its [id] or null if no such row exists.
  Future<Poll?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Poll>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Poll]s in the list and returns the inserted rows.
  ///
  /// The returned [Poll]s will have their `id` fields set.
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
  Future<List<Poll>> insert(
    _is.DatabaseSession session,
    List<Poll> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Poll>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Poll] and returns the inserted row.
  ///
  /// The returned [Poll] will have its `id` field set.
  Future<Poll> insertRow(
    _is.DatabaseSession session,
    Poll row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Poll>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Poll]s in the list and returns the resulting rows.
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
  /// The returned [Poll]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Poll>> upsert(
    _is.DatabaseSession session,
    List<Poll> rows, {
    required _is.ColumnSelections<PollTable> conflictColumns,
    _is.ColumnSelections<PollTable>? updateColumns,
    _is.WhereExpressionBuilder<PollTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Poll>(
      rows,
      conflictColumns: conflictColumns(Poll.t),
      updateColumns: updateColumns?.call(Poll.t),
      updateWhere: updateWhere?.call(Poll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Poll] and returns the resulting row.
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
  /// The returned [Poll] will have its `id` field set.
  Future<Poll?> upsertRow(
    _is.DatabaseSession session,
    Poll row, {
    required _is.ColumnSelections<PollTable> conflictColumns,
    _is.ColumnSelections<PollTable>? updateColumns,
    _is.WhereExpressionBuilder<PollTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Poll>(
      row,
      conflictColumns: conflictColumns(Poll.t),
      updateColumns: updateColumns?.call(Poll.t),
      updateWhere: updateWhere?.call(Poll.t),
      transaction: transaction,
    );
  }

  /// Updates all [Poll]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Poll>> update(
    _is.DatabaseSession session,
    List<Poll> rows, {
    _is.ColumnSelections<PollTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Poll>(
      rows,
      columns: columns?.call(Poll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Poll]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Poll> updateRow(
    _is.DatabaseSession session,
    Poll row, {
    _is.ColumnSelections<PollTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Poll>(
      row,
      columns: columns?.call(Poll.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Poll] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Poll?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PollUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Poll>(
      id,
      columnValues: columnValues(Poll.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Poll]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Poll>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PollUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PollTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Poll>(
      columnValues: columnValues(Poll.t.updateTable),
      where: where(Poll.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Poll]s in the list and returns the deleted rows.
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
  Future<List<Poll>> delete(
    _is.DatabaseSession session,
    List<Poll> rows, {
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Poll>(
      rows,
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Poll].
  Future<Poll> deleteRow(
    _is.DatabaseSession session,
    Poll row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Poll>(
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
  Future<List<Poll>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PollTable> where,
    _is.OrderByBuilder<PollTable>? orderBy,
    _is.OrderByListBuilder<PollTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Poll>(
      where: where(Poll.t),
      orderBy: orderBy?.call(Poll.t),
      orderByList: orderByList?.call(Poll.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PollTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Poll>(
      where: where?.call(Poll.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Poll] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PollTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Poll>(
      where: where(Poll.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
