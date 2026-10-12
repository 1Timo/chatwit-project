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

abstract class MessageVisibility
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MessageVisibility._({
    this.id,
    required this.userId,
    required this.messageId,
  });

  factory MessageVisibility({
    int? id,
    required String userId,
    required int messageId,
  }) = _MessageVisibilityImpl;

  factory MessageVisibility.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessageVisibility(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      messageId: jsonSerialization['messageId'] as int,
    );
  }

  static final t = MessageVisibilityTable();

  static const db = MessageVisibilityRepository._();

  @override
  int? id;

  String userId;

  int messageId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MessageVisibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MessageVisibility copyWith({
    int? id,
    String? userId,
    int? messageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessageVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'messageId': messageId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MessageVisibility',
      if (id != null) 'id': id,
      'userId': userId,
      'messageId': messageId,
    };
  }

  static MessageVisibilityInclude include() {
    return MessageVisibilityInclude._();
  }

  static MessageVisibilityIncludeList includeList({
    _is.WhereExpressionBuilder<MessageVisibilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    MessageVisibilityInclude? include,
  }) {
    return MessageVisibilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageVisibilityImpl extends MessageVisibility {
  _MessageVisibilityImpl({
    int? id,
    required String userId,
    required int messageId,
  }) : super._(
         id: id,
         userId: userId,
         messageId: messageId,
       );

  /// Returns a shallow copy of this [MessageVisibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MessageVisibility copyWith({
    Object? id = _Undefined,
    String? userId,
    int? messageId,
  }) {
    return MessageVisibility(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      messageId: messageId ?? this.messageId,
    );
  }
}

class MessageVisibilityUpdateTable
    extends _is.UpdateTable<MessageVisibilityTable> {
  MessageVisibilityUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> messageId(int value) => _is.ColumnValue(
    table.messageId,
    value,
  );
}

class MessageVisibilityTable extends _is.Table<int?> {
  MessageVisibilityTable({super.tableRelation})
    : super(tableName: 'message_visibility') {
    updateTable = MessageVisibilityUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    messageId = _is.ColumnInt(
      'messageId',
      this,
    );
  }

  late final MessageVisibilityUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnInt messageId;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    messageId,
  ];
}

class MessageVisibilityInclude extends _is.IncludeObject {
  MessageVisibilityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MessageVisibility.t;
}

class MessageVisibilityIncludeList extends _is.IncludeList {
  MessageVisibilityIncludeList._({
    _is.WhereExpressionBuilder<MessageVisibilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MessageVisibility.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MessageVisibility.t;
}

class MessageVisibilityRepository {
  const MessageVisibilityRepository._();

  /// Returns a list of [MessageVisibility]s matching the given query parameters.
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
  Future<List<MessageVisibility>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageVisibilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MessageVisibility>(
      where: where?.call(MessageVisibility.t),
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MessageVisibility] matching the given query parameters.
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
  Future<MessageVisibility?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageVisibilityTable>? where,
    int? offset,
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MessageVisibility>(
      where: where?.call(MessageVisibility.t),
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MessageVisibility] by its [id] or null if no such row exists.
  Future<MessageVisibility?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MessageVisibility>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MessageVisibility]s in the list and returns the inserted rows.
  ///
  /// The returned [MessageVisibility]s will have their `id` fields set.
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
  Future<List<MessageVisibility>> insert(
    _is.DatabaseSession session,
    List<MessageVisibility> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MessageVisibility>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MessageVisibility] and returns the inserted row.
  ///
  /// The returned [MessageVisibility] will have its `id` field set.
  Future<MessageVisibility> insertRow(
    _is.DatabaseSession session,
    MessageVisibility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MessageVisibility>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MessageVisibility]s in the list and returns the resulting rows.
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
  /// The returned [MessageVisibility]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MessageVisibility>> upsert(
    _is.DatabaseSession session,
    List<MessageVisibility> rows, {
    required _is.ColumnSelections<MessageVisibilityTable> conflictColumns,
    _is.ColumnSelections<MessageVisibilityTable>? updateColumns,
    _is.WhereExpressionBuilder<MessageVisibilityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MessageVisibility>(
      rows,
      conflictColumns: conflictColumns(MessageVisibility.t),
      updateColumns: updateColumns?.call(MessageVisibility.t),
      updateWhere: updateWhere?.call(MessageVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MessageVisibility] and returns the resulting row.
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
  /// The returned [MessageVisibility] will have its `id` field set.
  Future<MessageVisibility?> upsertRow(
    _is.DatabaseSession session,
    MessageVisibility row, {
    required _is.ColumnSelections<MessageVisibilityTable> conflictColumns,
    _is.ColumnSelections<MessageVisibilityTable>? updateColumns,
    _is.WhereExpressionBuilder<MessageVisibilityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MessageVisibility>(
      row,
      conflictColumns: conflictColumns(MessageVisibility.t),
      updateColumns: updateColumns?.call(MessageVisibility.t),
      updateWhere: updateWhere?.call(MessageVisibility.t),
      transaction: transaction,
    );
  }

  /// Updates all [MessageVisibility]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MessageVisibility>> update(
    _is.DatabaseSession session,
    List<MessageVisibility> rows, {
    _is.ColumnSelections<MessageVisibilityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MessageVisibility>(
      rows,
      columns: columns?.call(MessageVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MessageVisibility]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MessageVisibility> updateRow(
    _is.DatabaseSession session,
    MessageVisibility row, {
    _is.ColumnSelections<MessageVisibilityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MessageVisibility>(
      row,
      columns: columns?.call(MessageVisibility.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessageVisibility] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MessageVisibility?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MessageVisibilityUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MessageVisibility>(
      id,
      columnValues: columnValues(MessageVisibility.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MessageVisibility]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MessageVisibility>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MessageVisibilityUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<MessageVisibilityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MessageVisibility>(
      columnValues: columnValues(MessageVisibility.t.updateTable),
      where: where(MessageVisibility.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MessageVisibility]s in the list and returns the deleted rows.
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
  Future<List<MessageVisibility>> delete(
    _is.DatabaseSession session,
    List<MessageVisibility> rows, {
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MessageVisibility>(
      rows,
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MessageVisibility].
  Future<MessageVisibility> deleteRow(
    _is.DatabaseSession session,
    MessageVisibility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MessageVisibility>(
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
  Future<List<MessageVisibility>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MessageVisibilityTable> where,
    _is.OrderByBuilder<MessageVisibilityTable>? orderBy,
    _is.OrderByListBuilder<MessageVisibilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MessageVisibility>(
      where: where(MessageVisibility.t),
      orderBy: orderBy?.call(MessageVisibility.t),
      orderByList: orderByList?.call(MessageVisibility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageVisibilityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MessageVisibility>(
      where: where?.call(MessageVisibility.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MessageVisibility] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MessageVisibilityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MessageVisibility>(
      where: where(MessageVisibility.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
