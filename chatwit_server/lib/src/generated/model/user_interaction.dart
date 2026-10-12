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

abstract class UserInteraction
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserInteraction._({
    this.id,
    required this.userId,
    this.category,
    this.targetUserId,
    required this.score,
    required this.createdAt,
  });

  factory UserInteraction({
    int? id,
    required String userId,
    String? category,
    String? targetUserId,
    required int score,
    required DateTime createdAt,
  }) = _UserInteractionImpl;

  factory UserInteraction.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInteraction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      category: jsonSerialization['category'] as String?,
      targetUserId: jsonSerialization['targetUserId'] as String?,
      score: jsonSerialization['score'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserInteractionTable();

  static const db = UserInteractionRepository._();

  @override
  int? id;

  String userId;

  String? category;

  String? targetUserId;

  int score;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserInteraction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserInteraction copyWith({
    int? id,
    String? userId,
    String? category,
    String? targetUserId,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      if (category != null) 'category': category,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserInteraction',
      if (id != null) 'id': id,
      'userId': userId,
      if (category != null) 'category': category,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserInteractionInclude include() {
    return UserInteractionInclude._();
  }

  static UserInteractionIncludeList includeList({
    _is.WhereExpressionBuilder<UserInteractionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    UserInteractionInclude? include,
  }) {
    return UserInteractionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInteractionImpl extends UserInteraction {
  _UserInteractionImpl({
    int? id,
    required String userId,
    String? category,
    String? targetUserId,
    required int score,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         category: category,
         targetUserId: targetUserId,
         score: score,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserInteraction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserInteraction copyWith({
    Object? id = _Undefined,
    String? userId,
    Object? category = _Undefined,
    Object? targetUserId = _Undefined,
    int? score,
    DateTime? createdAt,
  }) {
    return UserInteraction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      category: category is String? ? category : this.category,
      targetUserId: targetUserId is String? ? targetUserId : this.targetUserId,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserInteractionUpdateTable extends _is.UpdateTable<UserInteractionTable> {
  UserInteractionUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> category(String? value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> targetUserId(String? value) =>
      _is.ColumnValue(
        table.targetUserId,
        value,
      );

  _is.ColumnValue<int, int> score(int value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserInteractionTable extends _is.Table<int?> {
  UserInteractionTable({super.tableRelation})
    : super(tableName: 'user_interaction') {
    updateTable = UserInteractionUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    targetUserId = _is.ColumnString(
      'targetUserId',
      this,
    );
    score = _is.ColumnInt(
      'score',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserInteractionUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString category;

  late final _is.ColumnString targetUserId;

  late final _is.ColumnInt score;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    category,
    targetUserId,
    score,
    createdAt,
  ];
}

class UserInteractionInclude extends _is.IncludeObject {
  UserInteractionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserInteraction.t;
}

class UserInteractionIncludeList extends _is.IncludeList {
  UserInteractionIncludeList._({
    _is.WhereExpressionBuilder<UserInteractionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserInteraction.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserInteraction.t;
}

class UserInteractionRepository {
  const UserInteractionRepository._();

  /// Returns a list of [UserInteraction]s matching the given query parameters.
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
  Future<List<UserInteraction>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserInteractionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserInteraction>(
      where: where?.call(UserInteraction.t),
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserInteraction] matching the given query parameters.
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
  Future<UserInteraction?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserInteractionTable>? where,
    int? offset,
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserInteraction>(
      where: where?.call(UserInteraction.t),
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserInteraction] by its [id] or null if no such row exists.
  Future<UserInteraction?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserInteraction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserInteraction]s in the list and returns the inserted rows.
  ///
  /// The returned [UserInteraction]s will have their `id` fields set.
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
  Future<List<UserInteraction>> insert(
    _is.DatabaseSession session,
    List<UserInteraction> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserInteraction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserInteraction] and returns the inserted row.
  ///
  /// The returned [UserInteraction] will have its `id` field set.
  Future<UserInteraction> insertRow(
    _is.DatabaseSession session,
    UserInteraction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserInteraction>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserInteraction]s in the list and returns the resulting rows.
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
  /// The returned [UserInteraction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserInteraction>> upsert(
    _is.DatabaseSession session,
    List<UserInteraction> rows, {
    required _is.ColumnSelections<UserInteractionTable> conflictColumns,
    _is.ColumnSelections<UserInteractionTable>? updateColumns,
    _is.WhereExpressionBuilder<UserInteractionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserInteraction>(
      rows,
      conflictColumns: conflictColumns(UserInteraction.t),
      updateColumns: updateColumns?.call(UserInteraction.t),
      updateWhere: updateWhere?.call(UserInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserInteraction] and returns the resulting row.
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
  /// The returned [UserInteraction] will have its `id` field set.
  Future<UserInteraction?> upsertRow(
    _is.DatabaseSession session,
    UserInteraction row, {
    required _is.ColumnSelections<UserInteractionTable> conflictColumns,
    _is.ColumnSelections<UserInteractionTable>? updateColumns,
    _is.WhereExpressionBuilder<UserInteractionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserInteraction>(
      row,
      conflictColumns: conflictColumns(UserInteraction.t),
      updateColumns: updateColumns?.call(UserInteraction.t),
      updateWhere: updateWhere?.call(UserInteraction.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserInteraction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserInteraction>> update(
    _is.DatabaseSession session,
    List<UserInteraction> rows, {
    _is.ColumnSelections<UserInteractionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserInteraction>(
      rows,
      columns: columns?.call(UserInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserInteraction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserInteraction> updateRow(
    _is.DatabaseSession session,
    UserInteraction row, {
    _is.ColumnSelections<UserInteractionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserInteraction>(
      row,
      columns: columns?.call(UserInteraction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserInteraction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserInteraction?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserInteractionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserInteraction>(
      id,
      columnValues: columnValues(UserInteraction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserInteraction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserInteraction>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserInteractionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserInteractionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserInteraction>(
      columnValues: columnValues(UserInteraction.t.updateTable),
      where: where(UserInteraction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserInteraction]s in the list and returns the deleted rows.
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
  Future<List<UserInteraction>> delete(
    _is.DatabaseSession session,
    List<UserInteraction> rows, {
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserInteraction>(
      rows,
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserInteraction].
  Future<UserInteraction> deleteRow(
    _is.DatabaseSession session,
    UserInteraction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserInteraction>(
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
  Future<List<UserInteraction>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserInteractionTable> where,
    _is.OrderByBuilder<UserInteractionTable>? orderBy,
    _is.OrderByListBuilder<UserInteractionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserInteraction>(
      where: where(UserInteraction.t),
      orderBy: orderBy?.call(UserInteraction.t),
      orderByList: orderByList?.call(UserInteraction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserInteractionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserInteraction>(
      where: where?.call(UserInteraction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserInteraction] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserInteractionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserInteraction>(
      where: where(UserInteraction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
