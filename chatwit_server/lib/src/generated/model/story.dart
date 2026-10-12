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

abstract class Story implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Story._({
    this.id,
    required this.userId,
    this.userName,
    this.profileImageUrl,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.expiresAt,
  });

  factory Story({
    int? id,
    required String userId,
    String? userName,
    String? profileImageUrl,
    required String mediaUrl,
    required String mediaType,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _StoryImpl;

  factory Story.fromJson(Map<String, dynamic> jsonSerialization) {
    return Story(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      mediaUrl: jsonSerialization['mediaUrl'] as String,
      mediaType: jsonSerialization['mediaType'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = StoryTable();

  static const db = StoryRepository._();

  @override
  int? id;

  String userId;

  String? userName;

  String? profileImageUrl;

  String mediaUrl;

  String mediaType;

  DateTime createdAt;

  DateTime expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Story]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Story copyWith({
    int? id,
    String? userId,
    String? userName,
    String? profileImageUrl,
    String? mediaUrl,
    String? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Story',
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Story',
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  static StoryInclude include() {
    return StoryInclude._();
  }

  static StoryIncludeList includeList({
    _is.WhereExpressionBuilder<StoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    StoryInclude? include,
  }) {
    return StoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoryImpl extends Story {
  _StoryImpl({
    int? id,
    required String userId,
    String? userName,
    String? profileImageUrl,
    required String mediaUrl,
    required String mediaType,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         userName: userName,
         profileImageUrl: profileImageUrl,
         mediaUrl: mediaUrl,
         mediaType: mediaType,
         createdAt: createdAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [Story]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Story copyWith({
    Object? id = _Undefined,
    String? userId,
    Object? userName = _Undefined,
    Object? profileImageUrl = _Undefined,
    String? mediaUrl,
    String? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return Story(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      userName: userName is String? ? userName : this.userName,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class StoryUpdateTable extends _is.UpdateTable<StoryTable> {
  StoryUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> userName(String? value) => _is.ColumnValue(
    table.userName,
    value,
  );

  _is.ColumnValue<String, String> profileImageUrl(String? value) =>
      _is.ColumnValue(
        table.profileImageUrl,
        value,
      );

  _is.ColumnValue<String, String> mediaUrl(String value) => _is.ColumnValue(
    table.mediaUrl,
    value,
  );

  _is.ColumnValue<String, String> mediaType(String value) => _is.ColumnValue(
    table.mediaType,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class StoryTable extends _is.Table<int?> {
  StoryTable({super.tableRelation}) : super(tableName: 'stories') {
    updateTable = StoryUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    userName = _is.ColumnString(
      'userName',
      this,
    );
    profileImageUrl = _is.ColumnString(
      'profileImageUrl',
      this,
    );
    mediaUrl = _is.ColumnString(
      'mediaUrl',
      this,
    );
    mediaType = _is.ColumnString(
      'mediaType',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final StoryUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString userName;

  late final _is.ColumnString profileImageUrl;

  late final _is.ColumnString mediaUrl;

  late final _is.ColumnString mediaType;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    userName,
    profileImageUrl,
    mediaUrl,
    mediaType,
    createdAt,
    expiresAt,
  ];
}

class StoryInclude extends _is.IncludeObject {
  StoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Story.t;
}

class StoryIncludeList extends _is.IncludeList {
  StoryIncludeList._({
    _is.WhereExpressionBuilder<StoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Story.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Story.t;
}

class StoryRepository {
  const StoryRepository._();

  /// Returns a list of [Story]s matching the given query parameters.
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
  Future<List<Story>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Story>(
      where: where?.call(Story.t),
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Story] matching the given query parameters.
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
  Future<Story?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoryTable>? where,
    int? offset,
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Story>(
      where: where?.call(Story.t),
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Story] by its [id] or null if no such row exists.
  Future<Story?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Story>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Story]s in the list and returns the inserted rows.
  ///
  /// The returned [Story]s will have their `id` fields set.
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
  Future<List<Story>> insert(
    _is.DatabaseSession session,
    List<Story> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Story>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Story] and returns the inserted row.
  ///
  /// The returned [Story] will have its `id` field set.
  Future<Story> insertRow(
    _is.DatabaseSession session,
    Story row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Story>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Story]s in the list and returns the resulting rows.
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
  /// The returned [Story]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Story>> upsert(
    _is.DatabaseSession session,
    List<Story> rows, {
    required _is.ColumnSelections<StoryTable> conflictColumns,
    _is.ColumnSelections<StoryTable>? updateColumns,
    _is.WhereExpressionBuilder<StoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Story>(
      rows,
      conflictColumns: conflictColumns(Story.t),
      updateColumns: updateColumns?.call(Story.t),
      updateWhere: updateWhere?.call(Story.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Story] and returns the resulting row.
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
  /// The returned [Story] will have its `id` field set.
  Future<Story?> upsertRow(
    _is.DatabaseSession session,
    Story row, {
    required _is.ColumnSelections<StoryTable> conflictColumns,
    _is.ColumnSelections<StoryTable>? updateColumns,
    _is.WhereExpressionBuilder<StoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Story>(
      row,
      conflictColumns: conflictColumns(Story.t),
      updateColumns: updateColumns?.call(Story.t),
      updateWhere: updateWhere?.call(Story.t),
      transaction: transaction,
    );
  }

  /// Updates all [Story]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Story>> update(
    _is.DatabaseSession session,
    List<Story> rows, {
    _is.ColumnSelections<StoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Story>(
      rows,
      columns: columns?.call(Story.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Story]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Story> updateRow(
    _is.DatabaseSession session,
    Story row, {
    _is.ColumnSelections<StoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Story>(
      row,
      columns: columns?.call(Story.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Story] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Story?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Story>(
      id,
      columnValues: columnValues(Story.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Story]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Story>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Story>(
      columnValues: columnValues(Story.t.updateTable),
      where: where(Story.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Story]s in the list and returns the deleted rows.
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
  Future<List<Story>> delete(
    _is.DatabaseSession session,
    List<Story> rows, {
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Story>(
      rows,
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Story].
  Future<Story> deleteRow(
    _is.DatabaseSession session,
    Story row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Story>(
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
  Future<List<Story>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoryTable> where,
    _is.OrderByBuilder<StoryTable>? orderBy,
    _is.OrderByListBuilder<StoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Story>(
      where: where(Story.t),
      orderBy: orderBy?.call(Story.t),
      orderByList: orderByList?.call(Story.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Story>(
      where: where?.call(Story.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Story] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Story>(
      where: where(Story.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
