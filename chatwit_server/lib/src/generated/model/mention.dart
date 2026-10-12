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

abstract class Mention
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Mention._({
    this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
  });

  factory Mention({
    int? id,
    required String userId,
    required int postId,
    required DateTime createdAt,
  }) = _MentionImpl;

  factory Mention.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mention(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      postId: jsonSerialization['postId'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MentionTable();

  static const db = MentionRepository._();

  @override
  int? id;

  String userId;

  int postId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Mention]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Mention copyWith({
    int? id,
    String? userId,
    int? postId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mention',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mention',
      if (id != null) 'id': id,
      'userId': userId,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  static MentionInclude include() {
    return MentionInclude._();
  }

  static MentionIncludeList includeList({
    _is.WhereExpressionBuilder<MentionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    MentionInclude? include,
  }) {
    return MentionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MentionImpl extends Mention {
  _MentionImpl({
    int? id,
    required String userId,
    required int postId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         postId: postId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Mention]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Mention copyWith({
    Object? id = _Undefined,
    String? userId,
    int? postId,
    DateTime? createdAt,
  }) {
    return Mention(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MentionUpdateTable extends _is.UpdateTable<MentionTable> {
  MentionUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MentionTable extends _is.Table<int?> {
  MentionTable({super.tableRelation}) : super(tableName: 'mention') {
    updateTable = MentionUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MentionUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnInt postId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    postId,
    createdAt,
  ];
}

class MentionInclude extends _is.IncludeObject {
  MentionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Mention.t;
}

class MentionIncludeList extends _is.IncludeList {
  MentionIncludeList._({
    _is.WhereExpressionBuilder<MentionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mention.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Mention.t;
}

class MentionRepository {
  const MentionRepository._();

  /// Returns a list of [Mention]s matching the given query parameters.
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
  Future<List<Mention>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MentionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mention>(
      where: where?.call(Mention.t),
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mention] matching the given query parameters.
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
  Future<Mention?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MentionTable>? where,
    int? offset,
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mention>(
      where: where?.call(Mention.t),
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mention] by its [id] or null if no such row exists.
  Future<Mention?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mention>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mention]s in the list and returns the inserted rows.
  ///
  /// The returned [Mention]s will have their `id` fields set.
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
  Future<List<Mention>> insert(
    _is.DatabaseSession session,
    List<Mention> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Mention>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Mention] and returns the inserted row.
  ///
  /// The returned [Mention] will have its `id` field set.
  Future<Mention> insertRow(
    _is.DatabaseSession session,
    Mention row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mention>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Mention]s in the list and returns the resulting rows.
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
  /// The returned [Mention]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mention>> upsert(
    _is.DatabaseSession session,
    List<Mention> rows, {
    required _is.ColumnSelections<MentionTable> conflictColumns,
    _is.ColumnSelections<MentionTable>? updateColumns,
    _is.WhereExpressionBuilder<MentionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Mention>(
      rows,
      conflictColumns: conflictColumns(Mention.t),
      updateColumns: updateColumns?.call(Mention.t),
      updateWhere: updateWhere?.call(Mention.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Mention] and returns the resulting row.
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
  /// The returned [Mention] will have its `id` field set.
  Future<Mention?> upsertRow(
    _is.DatabaseSession session,
    Mention row, {
    required _is.ColumnSelections<MentionTable> conflictColumns,
    _is.ColumnSelections<MentionTable>? updateColumns,
    _is.WhereExpressionBuilder<MentionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Mention>(
      row,
      conflictColumns: conflictColumns(Mention.t),
      updateColumns: updateColumns?.call(Mention.t),
      updateWhere: updateWhere?.call(Mention.t),
      transaction: transaction,
    );
  }

  /// Updates all [Mention]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mention>> update(
    _is.DatabaseSession session,
    List<Mention> rows, {
    _is.ColumnSelections<MentionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Mention>(
      rows,
      columns: columns?.call(Mention.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Mention]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mention> updateRow(
    _is.DatabaseSession session,
    Mention row, {
    _is.ColumnSelections<MentionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mention>(
      row,
      columns: columns?.call(Mention.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mention] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mention?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MentionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Mention>(
      id,
      columnValues: columnValues(Mention.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mention]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mention>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MentionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MentionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Mention>(
      columnValues: columnValues(Mention.t.updateTable),
      where: where(Mention.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Mention]s in the list and returns the deleted rows.
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
  Future<List<Mention>> delete(
    _is.DatabaseSession session,
    List<Mention> rows, {
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Mention>(
      rows,
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Mention].
  Future<Mention> deleteRow(
    _is.DatabaseSession session,
    Mention row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mention>(
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
  Future<List<Mention>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MentionTable> where,
    _is.OrderByBuilder<MentionTable>? orderBy,
    _is.OrderByListBuilder<MentionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Mention>(
      where: where(Mention.t),
      orderBy: orderBy?.call(Mention.t),
      orderByList: orderByList?.call(Mention.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MentionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Mention>(
      where: where?.call(Mention.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mention] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MentionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mention>(
      where: where(Mention.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
