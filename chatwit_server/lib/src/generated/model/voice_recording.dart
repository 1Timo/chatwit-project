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

abstract class VoiceRecording
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VoiceRecording._({
    this.id,
    required this.callRoomId,
    required this.fromUserId,
    required this.toUserId,
    required this.recordingUrl,
    required this.duration,
    required this.createdAt,
  });

  factory VoiceRecording({
    int? id,
    required String callRoomId,
    required String fromUserId,
    required String toUserId,
    required String recordingUrl,
    required int duration,
    required DateTime createdAt,
  }) = _VoiceRecordingImpl;

  factory VoiceRecording.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceRecording(
      id: jsonSerialization['id'] as int?,
      callRoomId: jsonSerialization['callRoomId'] as String,
      fromUserId: jsonSerialization['fromUserId'] as String,
      toUserId: jsonSerialization['toUserId'] as String,
      recordingUrl: jsonSerialization['recordingUrl'] as String,
      duration: jsonSerialization['duration'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = VoiceRecordingTable();

  static const db = VoiceRecordingRepository._();

  @override
  int? id;

  String callRoomId;

  String fromUserId;

  String toUserId;

  String recordingUrl;

  int duration;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VoiceRecording]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VoiceRecording copyWith({
    int? id,
    String? callRoomId,
    String? fromUserId,
    String? toUserId,
    String? recordingUrl,
    int? duration,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceRecording',
      if (id != null) 'id': id,
      'callRoomId': callRoomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'recordingUrl': recordingUrl,
      'duration': duration,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceRecording',
      if (id != null) 'id': id,
      'callRoomId': callRoomId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'recordingUrl': recordingUrl,
      'duration': duration,
      'createdAt': createdAt.toJson(),
    };
  }

  static VoiceRecordingInclude include() {
    return VoiceRecordingInclude._();
  }

  static VoiceRecordingIncludeList includeList({
    _is.WhereExpressionBuilder<VoiceRecordingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    VoiceRecordingInclude? include,
  }) {
    return VoiceRecordingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VoiceRecordingImpl extends VoiceRecording {
  _VoiceRecordingImpl({
    int? id,
    required String callRoomId,
    required String fromUserId,
    required String toUserId,
    required String recordingUrl,
    required int duration,
    required DateTime createdAt,
  }) : super._(
         id: id,
         callRoomId: callRoomId,
         fromUserId: fromUserId,
         toUserId: toUserId,
         recordingUrl: recordingUrl,
         duration: duration,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VoiceRecording]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VoiceRecording copyWith({
    Object? id = _Undefined,
    String? callRoomId,
    String? fromUserId,
    String? toUserId,
    String? recordingUrl,
    int? duration,
    DateTime? createdAt,
  }) {
    return VoiceRecording(
      id: id is int? ? id : this.id,
      callRoomId: callRoomId ?? this.callRoomId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      recordingUrl: recordingUrl ?? this.recordingUrl,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VoiceRecordingUpdateTable extends _is.UpdateTable<VoiceRecordingTable> {
  VoiceRecordingUpdateTable(super.table);

  _is.ColumnValue<String, String> callRoomId(String value) => _is.ColumnValue(
    table.callRoomId,
    value,
  );

  _is.ColumnValue<String, String> fromUserId(String value) => _is.ColumnValue(
    table.fromUserId,
    value,
  );

  _is.ColumnValue<String, String> toUserId(String value) => _is.ColumnValue(
    table.toUserId,
    value,
  );

  _is.ColumnValue<String, String> recordingUrl(String value) => _is.ColumnValue(
    table.recordingUrl,
    value,
  );

  _is.ColumnValue<int, int> duration(int value) => _is.ColumnValue(
    table.duration,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VoiceRecordingTable extends _is.Table<int?> {
  VoiceRecordingTable({super.tableRelation})
    : super(tableName: 'voice_recording') {
    updateTable = VoiceRecordingUpdateTable(this);
    callRoomId = _is.ColumnString(
      'callRoomId',
      this,
    );
    fromUserId = _is.ColumnString(
      'fromUserId',
      this,
    );
    toUserId = _is.ColumnString(
      'toUserId',
      this,
    );
    recordingUrl = _is.ColumnString(
      'recordingUrl',
      this,
    );
    duration = _is.ColumnInt(
      'duration',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final VoiceRecordingUpdateTable updateTable;

  late final _is.ColumnString callRoomId;

  late final _is.ColumnString fromUserId;

  late final _is.ColumnString toUserId;

  late final _is.ColumnString recordingUrl;

  late final _is.ColumnInt duration;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    callRoomId,
    fromUserId,
    toUserId,
    recordingUrl,
    duration,
    createdAt,
  ];
}

class VoiceRecordingInclude extends _is.IncludeObject {
  VoiceRecordingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VoiceRecording.t;
}

class VoiceRecordingIncludeList extends _is.IncludeList {
  VoiceRecordingIncludeList._({
    _is.WhereExpressionBuilder<VoiceRecordingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VoiceRecording.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VoiceRecording.t;
}

class VoiceRecordingRepository {
  const VoiceRecordingRepository._();

  /// Returns a list of [VoiceRecording]s matching the given query parameters.
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
  Future<List<VoiceRecording>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceRecordingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VoiceRecording>(
      where: where?.call(VoiceRecording.t),
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VoiceRecording] matching the given query parameters.
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
  Future<VoiceRecording?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceRecordingTable>? where,
    int? offset,
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VoiceRecording>(
      where: where?.call(VoiceRecording.t),
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VoiceRecording] by its [id] or null if no such row exists.
  Future<VoiceRecording?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VoiceRecording>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VoiceRecording]s in the list and returns the inserted rows.
  ///
  /// The returned [VoiceRecording]s will have their `id` fields set.
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
  Future<List<VoiceRecording>> insert(
    _is.DatabaseSession session,
    List<VoiceRecording> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VoiceRecording>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VoiceRecording] and returns the inserted row.
  ///
  /// The returned [VoiceRecording] will have its `id` field set.
  Future<VoiceRecording> insertRow(
    _is.DatabaseSession session,
    VoiceRecording row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VoiceRecording>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VoiceRecording]s in the list and returns the resulting rows.
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
  /// The returned [VoiceRecording]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceRecording>> upsert(
    _is.DatabaseSession session,
    List<VoiceRecording> rows, {
    required _is.ColumnSelections<VoiceRecordingTable> conflictColumns,
    _is.ColumnSelections<VoiceRecordingTable>? updateColumns,
    _is.WhereExpressionBuilder<VoiceRecordingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VoiceRecording>(
      rows,
      conflictColumns: conflictColumns(VoiceRecording.t),
      updateColumns: updateColumns?.call(VoiceRecording.t),
      updateWhere: updateWhere?.call(VoiceRecording.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VoiceRecording] and returns the resulting row.
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
  /// The returned [VoiceRecording] will have its `id` field set.
  Future<VoiceRecording?> upsertRow(
    _is.DatabaseSession session,
    VoiceRecording row, {
    required _is.ColumnSelections<VoiceRecordingTable> conflictColumns,
    _is.ColumnSelections<VoiceRecordingTable>? updateColumns,
    _is.WhereExpressionBuilder<VoiceRecordingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VoiceRecording>(
      row,
      conflictColumns: conflictColumns(VoiceRecording.t),
      updateColumns: updateColumns?.call(VoiceRecording.t),
      updateWhere: updateWhere?.call(VoiceRecording.t),
      transaction: transaction,
    );
  }

  /// Updates all [VoiceRecording]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceRecording>> update(
    _is.DatabaseSession session,
    List<VoiceRecording> rows, {
    _is.ColumnSelections<VoiceRecordingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VoiceRecording>(
      rows,
      columns: columns?.call(VoiceRecording.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VoiceRecording]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VoiceRecording> updateRow(
    _is.DatabaseSession session,
    VoiceRecording row, {
    _is.ColumnSelections<VoiceRecordingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VoiceRecording>(
      row,
      columns: columns?.call(VoiceRecording.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VoiceRecording] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VoiceRecording?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VoiceRecordingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VoiceRecording>(
      id,
      columnValues: columnValues(VoiceRecording.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VoiceRecording]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceRecording>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VoiceRecordingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VoiceRecordingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VoiceRecording>(
      columnValues: columnValues(VoiceRecording.t.updateTable),
      where: where(VoiceRecording.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VoiceRecording]s in the list and returns the deleted rows.
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
  Future<List<VoiceRecording>> delete(
    _is.DatabaseSession session,
    List<VoiceRecording> rows, {
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VoiceRecording>(
      rows,
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VoiceRecording].
  Future<VoiceRecording> deleteRow(
    _is.DatabaseSession session,
    VoiceRecording row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VoiceRecording>(
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
  Future<List<VoiceRecording>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VoiceRecordingTable> where,
    _is.OrderByBuilder<VoiceRecordingTable>? orderBy,
    _is.OrderByListBuilder<VoiceRecordingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VoiceRecording>(
      where: where(VoiceRecording.t),
      orderBy: orderBy?.call(VoiceRecording.t),
      orderByList: orderByList?.call(VoiceRecording.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceRecordingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VoiceRecording>(
      where: where?.call(VoiceRecording.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VoiceRecording] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VoiceRecordingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VoiceRecording>(
      where: where(VoiceRecording.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
