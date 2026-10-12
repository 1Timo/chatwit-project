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

abstract class UserPreference
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserPreference._({
    this.id,
    required this.userId,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPreference({
    int? id,
    required String userId,
    required String categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserPreferenceImpl;

  factory UserPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPreference(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      categories: jsonSerialization['categories'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserPreferenceTable();

  static const db = UserPreferenceRepository._();

  @override
  int? id;

  String userId;

  String categories;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserPreference copyWith({
    int? id,
    String? userId,
    String? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPreference',
      if (id != null) 'id': id,
      'userId': userId,
      'categories': categories,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserPreference',
      if (id != null) 'id': id,
      'userId': userId,
      'categories': categories,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserPreferenceInclude include() {
    return UserPreferenceInclude._();
  }

  static UserPreferenceIncludeList includeList({
    _is.WhereExpressionBuilder<UserPreferenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    UserPreferenceInclude? include,
  }) {
    return UserPreferenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPreferenceImpl extends UserPreference {
  _UserPreferenceImpl({
    int? id,
    required String userId,
    required String categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         categories: categories,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserPreference]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserPreference copyWith({
    Object? id = _Undefined,
    String? userId,
    String? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreference(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserPreferenceUpdateTable extends _is.UpdateTable<UserPreferenceTable> {
  UserPreferenceUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> categories(String value) => _is.ColumnValue(
    table.categories,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserPreferenceTable extends _is.Table<int?> {
  UserPreferenceTable({super.tableRelation})
    : super(tableName: 'user_preference') {
    updateTable = UserPreferenceUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    categories = _is.ColumnString(
      'categories',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final UserPreferenceUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString categories;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    categories,
    createdAt,
    updatedAt,
  ];
}

class UserPreferenceInclude extends _is.IncludeObject {
  UserPreferenceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserPreference.t;
}

class UserPreferenceIncludeList extends _is.IncludeList {
  UserPreferenceIncludeList._({
    _is.WhereExpressionBuilder<UserPreferenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPreference.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserPreference.t;
}

class UserPreferenceRepository {
  const UserPreferenceRepository._();

  /// Returns a list of [UserPreference]s matching the given query parameters.
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
  Future<List<UserPreference>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserPreferenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserPreference>(
      where: where?.call(UserPreference.t),
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserPreference] matching the given query parameters.
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
  Future<UserPreference?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserPreferenceTable>? where,
    int? offset,
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserPreference>(
      where: where?.call(UserPreference.t),
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserPreference] by its [id] or null if no such row exists.
  Future<UserPreference?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserPreference>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserPreference]s in the list and returns the inserted rows.
  ///
  /// The returned [UserPreference]s will have their `id` fields set.
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
  Future<List<UserPreference>> insert(
    _is.DatabaseSession session,
    List<UserPreference> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserPreference>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserPreference] and returns the inserted row.
  ///
  /// The returned [UserPreference] will have its `id` field set.
  Future<UserPreference> insertRow(
    _is.DatabaseSession session,
    UserPreference row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserPreference>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserPreference]s in the list and returns the resulting rows.
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
  /// The returned [UserPreference]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserPreference>> upsert(
    _is.DatabaseSession session,
    List<UserPreference> rows, {
    required _is.ColumnSelections<UserPreferenceTable> conflictColumns,
    _is.ColumnSelections<UserPreferenceTable>? updateColumns,
    _is.WhereExpressionBuilder<UserPreferenceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserPreference>(
      rows,
      conflictColumns: conflictColumns(UserPreference.t),
      updateColumns: updateColumns?.call(UserPreference.t),
      updateWhere: updateWhere?.call(UserPreference.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserPreference] and returns the resulting row.
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
  /// The returned [UserPreference] will have its `id` field set.
  Future<UserPreference?> upsertRow(
    _is.DatabaseSession session,
    UserPreference row, {
    required _is.ColumnSelections<UserPreferenceTable> conflictColumns,
    _is.ColumnSelections<UserPreferenceTable>? updateColumns,
    _is.WhereExpressionBuilder<UserPreferenceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserPreference>(
      row,
      conflictColumns: conflictColumns(UserPreference.t),
      updateColumns: updateColumns?.call(UserPreference.t),
      updateWhere: updateWhere?.call(UserPreference.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserPreference]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserPreference>> update(
    _is.DatabaseSession session,
    List<UserPreference> rows, {
    _is.ColumnSelections<UserPreferenceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserPreference>(
      rows,
      columns: columns?.call(UserPreference.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserPreference]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserPreference> updateRow(
    _is.DatabaseSession session,
    UserPreference row, {
    _is.ColumnSelections<UserPreferenceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserPreference>(
      row,
      columns: columns?.call(UserPreference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPreference] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserPreference?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserPreferenceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserPreference>(
      id,
      columnValues: columnValues(UserPreference.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserPreference]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserPreference>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserPreferenceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserPreferenceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserPreference>(
      columnValues: columnValues(UserPreference.t.updateTable),
      where: where(UserPreference.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserPreference]s in the list and returns the deleted rows.
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
  Future<List<UserPreference>> delete(
    _is.DatabaseSession session,
    List<UserPreference> rows, {
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserPreference>(
      rows,
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserPreference].
  Future<UserPreference> deleteRow(
    _is.DatabaseSession session,
    UserPreference row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserPreference>(
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
  Future<List<UserPreference>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserPreferenceTable> where,
    _is.OrderByBuilder<UserPreferenceTable>? orderBy,
    _is.OrderByListBuilder<UserPreferenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserPreference>(
      where: where(UserPreference.t),
      orderBy: orderBy?.call(UserPreference.t),
      orderByList: orderByList?.call(UserPreference.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserPreferenceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserPreference>(
      where: where?.call(UserPreference.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserPreference] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserPreferenceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserPreference>(
      where: where(UserPreference.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
