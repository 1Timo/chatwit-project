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

abstract class ConversationVisibility
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ConversationVisibility._({
    this.id,
    required this.userId,
    required this.otherUserId,
    required this.hiddenBefore,
  });

  factory ConversationVisibility({
    int? id,
    required String userId,
    required String otherUserId,
    required DateTime hiddenBefore,
  }) = _ConversationVisibilityImpl;

  factory ConversationVisibility.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ConversationVisibility(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      otherUserId: jsonSerialization['otherUserId'] as String,
      hiddenBefore: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['hiddenBefore'],
      ),
    );
  }

  static final t = ConversationVisibilityTable();

  static const db = ConversationVisibilityRepository._();

  @override
  int? id;

  String userId;

  String otherUserId;

  DateTime hiddenBefore;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConversationVisibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ConversationVisibility copyWith({
    int? id,
    String? userId,
    String? otherUserId,
    DateTime? hiddenBefore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'otherUserId': otherUserId,
      'hiddenBefore': hiddenBefore.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'otherUserId': otherUserId,
      'hiddenBefore': hiddenBefore.toJson(),
    };
  }

  static ConversationVisibilityInclude include() {
    return ConversationVisibilityInclude._();
  }

  static ConversationVisibilityIncludeList includeList({
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    ConversationVisibilityInclude? include,
  }) {
    return ConversationVisibilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationVisibilityImpl extends ConversationVisibility {
  _ConversationVisibilityImpl({
    int? id,
    required String userId,
    required String otherUserId,
    required DateTime hiddenBefore,
  }) : super._(
         id: id,
         userId: userId,
         otherUserId: otherUserId,
         hiddenBefore: hiddenBefore,
       );

  /// Returns a shallow copy of this [ConversationVisibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ConversationVisibility copyWith({
    Object? id = _Undefined,
    String? userId,
    String? otherUserId,
    DateTime? hiddenBefore,
  }) {
    return ConversationVisibility(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      otherUserId: otherUserId ?? this.otherUserId,
      hiddenBefore: hiddenBefore ?? this.hiddenBefore,
    );
  }
}

class ConversationVisibilityUpdateTable
    extends _is.UpdateTable<ConversationVisibilityTable> {
  ConversationVisibilityUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> otherUserId(String value) => _is.ColumnValue(
    table.otherUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> hiddenBefore(DateTime value) =>
      _is.ColumnValue(
        table.hiddenBefore,
        value,
      );
}

class ConversationVisibilityTable extends _is.Table<int?> {
  ConversationVisibilityTable({super.tableRelation})
    : super(tableName: 'conversation_visibility') {
    updateTable = ConversationVisibilityUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    otherUserId = _is.ColumnString(
      'otherUserId',
      this,
    );
    hiddenBefore = _is.ColumnDateTime(
      'hiddenBefore',
      this,
    );
  }

  late final ConversationVisibilityUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString otherUserId;

  late final _is.ColumnDateTime hiddenBefore;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    otherUserId,
    hiddenBefore,
  ];
}

class ConversationVisibilityInclude extends _is.IncludeObject {
  ConversationVisibilityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ConversationVisibility.t;
}

class ConversationVisibilityIncludeList extends _is.IncludeList {
  ConversationVisibilityIncludeList._({
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConversationVisibility.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ConversationVisibility.t;
}

class ConversationVisibilityRepository {
  const ConversationVisibilityRepository._();

  /// Returns a list of [ConversationVisibility]s matching the given query parameters.
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
  Future<List<ConversationVisibility>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConversationVisibility>(
      where: where?.call(ConversationVisibility.t),
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConversationVisibility] matching the given query parameters.
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
  Future<ConversationVisibility?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? where,
    int? offset,
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConversationVisibility>(
      where: where?.call(ConversationVisibility.t),
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConversationVisibility] by its [id] or null if no such row exists.
  Future<ConversationVisibility?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConversationVisibility>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConversationVisibility]s in the list and returns the inserted rows.
  ///
  /// The returned [ConversationVisibility]s will have their `id` fields set.
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
  Future<List<ConversationVisibility>> insert(
    _is.DatabaseSession session,
    List<ConversationVisibility> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ConversationVisibility>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ConversationVisibility] and returns the inserted row.
  ///
  /// The returned [ConversationVisibility] will have its `id` field set.
  Future<ConversationVisibility> insertRow(
    _is.DatabaseSession session,
    ConversationVisibility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConversationVisibility>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ConversationVisibility]s in the list and returns the resulting rows.
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
  /// The returned [ConversationVisibility]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationVisibility>> upsert(
    _is.DatabaseSession session,
    List<ConversationVisibility> rows, {
    required _is.ColumnSelections<ConversationVisibilityTable> conflictColumns,
    _is.ColumnSelections<ConversationVisibilityTable>? updateColumns,
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ConversationVisibility>(
      rows,
      conflictColumns: conflictColumns(ConversationVisibility.t),
      updateColumns: updateColumns?.call(ConversationVisibility.t),
      updateWhere: updateWhere?.call(ConversationVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ConversationVisibility] and returns the resulting row.
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
  /// The returned [ConversationVisibility] will have its `id` field set.
  Future<ConversationVisibility?> upsertRow(
    _is.DatabaseSession session,
    ConversationVisibility row, {
    required _is.ColumnSelections<ConversationVisibilityTable> conflictColumns,
    _is.ColumnSelections<ConversationVisibilityTable>? updateColumns,
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ConversationVisibility>(
      row,
      conflictColumns: conflictColumns(ConversationVisibility.t),
      updateColumns: updateColumns?.call(ConversationVisibility.t),
      updateWhere: updateWhere?.call(ConversationVisibility.t),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationVisibility]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationVisibility>> update(
    _is.DatabaseSession session,
    List<ConversationVisibility> rows, {
    _is.ColumnSelections<ConversationVisibilityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ConversationVisibility>(
      rows,
      columns: columns?.call(ConversationVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ConversationVisibility]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConversationVisibility> updateRow(
    _is.DatabaseSession session,
    ConversationVisibility row, {
    _is.ColumnSelections<ConversationVisibilityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConversationVisibility>(
      row,
      columns: columns?.call(ConversationVisibility.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationVisibility] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConversationVisibility?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ConversationVisibilityUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ConversationVisibility>(
      id,
      columnValues: columnValues(ConversationVisibility.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationVisibility]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationVisibility>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ConversationVisibilityUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ConversationVisibilityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ConversationVisibility>(
      columnValues: columnValues(ConversationVisibility.t.updateTable),
      where: where(ConversationVisibility.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ConversationVisibility]s in the list and returns the deleted rows.
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
  Future<List<ConversationVisibility>> delete(
    _is.DatabaseSession session,
    List<ConversationVisibility> rows, {
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ConversationVisibility>(
      rows,
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ConversationVisibility].
  Future<ConversationVisibility> deleteRow(
    _is.DatabaseSession session,
    ConversationVisibility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConversationVisibility>(
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
  Future<List<ConversationVisibility>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConversationVisibilityTable> where,
    _is.OrderByBuilder<ConversationVisibilityTable>? orderBy,
    _is.OrderByListBuilder<ConversationVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ConversationVisibility>(
      where: where(ConversationVisibility.t),
      orderBy: orderBy?.call(ConversationVisibility.t),
      orderByList: orderByList?.call(ConversationVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationVisibilityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ConversationVisibility>(
      where: where?.call(ConversationVisibility.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConversationVisibility] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConversationVisibilityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConversationVisibility>(
      where: where(ConversationVisibility.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
