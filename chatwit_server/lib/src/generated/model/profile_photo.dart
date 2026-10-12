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

abstract class ProfilePhoto
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProfilePhoto._({
    this.id,
    required this.userId,
    required this.imageType,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ProfilePhoto({
    int? id,
    required String userId,
    required String imageType,
    required String imageUrl,
    required DateTime createdAt,
  }) = _ProfilePhotoImpl;

  factory ProfilePhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfilePhoto(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      imageType: jsonSerialization['imageType'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ProfilePhotoTable();

  static const db = ProfilePhotoRepository._();

  @override
  int? id;

  String userId;

  String imageType;

  String imageUrl;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProfilePhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProfilePhoto copyWith({
    int? id,
    String? userId,
    String? imageType,
    String? imageUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfilePhoto',
      if (id != null) 'id': id,
      'userId': userId,
      'imageType': imageType,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfilePhoto',
      if (id != null) 'id': id,
      'userId': userId,
      'imageType': imageType,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProfilePhotoInclude include() {
    return ProfilePhotoInclude._();
  }

  static ProfilePhotoIncludeList includeList({
    _is.WhereExpressionBuilder<ProfilePhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    ProfilePhotoInclude? include,
  }) {
    return ProfilePhotoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfilePhotoImpl extends ProfilePhoto {
  _ProfilePhotoImpl({
    int? id,
    required String userId,
    required String imageType,
    required String imageUrl,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         imageType: imageType,
         imageUrl: imageUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProfilePhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProfilePhoto copyWith({
    Object? id = _Undefined,
    String? userId,
    String? imageType,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return ProfilePhoto(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      imageType: imageType ?? this.imageType,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProfilePhotoUpdateTable extends _is.UpdateTable<ProfilePhotoTable> {
  ProfilePhotoUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> imageType(String value) => _is.ColumnValue(
    table.imageType,
    value,
  );

  _is.ColumnValue<String, String> imageUrl(String value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ProfilePhotoTable extends _is.Table<int?> {
  ProfilePhotoTable({super.tableRelation}) : super(tableName: 'profile_photo') {
    updateTable = ProfilePhotoUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    imageType = _is.ColumnString(
      'imageType',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ProfilePhotoUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString imageType;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    imageType,
    imageUrl,
    createdAt,
  ];
}

class ProfilePhotoInclude extends _is.IncludeObject {
  ProfilePhotoInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProfilePhoto.t;
}

class ProfilePhotoIncludeList extends _is.IncludeList {
  ProfilePhotoIncludeList._({
    _is.WhereExpressionBuilder<ProfilePhotoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProfilePhoto.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProfilePhoto.t;
}

class ProfilePhotoRepository {
  const ProfilePhotoRepository._();

  /// Returns a list of [ProfilePhoto]s matching the given query parameters.
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
  Future<List<ProfilePhoto>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfilePhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProfilePhoto>(
      where: where?.call(ProfilePhoto.t),
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProfilePhoto] matching the given query parameters.
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
  Future<ProfilePhoto?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfilePhotoTable>? where,
    int? offset,
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProfilePhoto>(
      where: where?.call(ProfilePhoto.t),
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProfilePhoto] by its [id] or null if no such row exists.
  Future<ProfilePhoto?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProfilePhoto>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProfilePhoto]s in the list and returns the inserted rows.
  ///
  /// The returned [ProfilePhoto]s will have their `id` fields set.
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
  Future<List<ProfilePhoto>> insert(
    _is.DatabaseSession session,
    List<ProfilePhoto> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProfilePhoto>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProfilePhoto] and returns the inserted row.
  ///
  /// The returned [ProfilePhoto] will have its `id` field set.
  Future<ProfilePhoto> insertRow(
    _is.DatabaseSession session,
    ProfilePhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProfilePhoto>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProfilePhoto]s in the list and returns the resulting rows.
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
  /// The returned [ProfilePhoto]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfilePhoto>> upsert(
    _is.DatabaseSession session,
    List<ProfilePhoto> rows, {
    required _is.ColumnSelections<ProfilePhotoTable> conflictColumns,
    _is.ColumnSelections<ProfilePhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfilePhotoTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProfilePhoto>(
      rows,
      conflictColumns: conflictColumns(ProfilePhoto.t),
      updateColumns: updateColumns?.call(ProfilePhoto.t),
      updateWhere: updateWhere?.call(ProfilePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProfilePhoto] and returns the resulting row.
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
  /// The returned [ProfilePhoto] will have its `id` field set.
  Future<ProfilePhoto?> upsertRow(
    _is.DatabaseSession session,
    ProfilePhoto row, {
    required _is.ColumnSelections<ProfilePhotoTable> conflictColumns,
    _is.ColumnSelections<ProfilePhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfilePhotoTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProfilePhoto>(
      row,
      conflictColumns: conflictColumns(ProfilePhoto.t),
      updateColumns: updateColumns?.call(ProfilePhoto.t),
      updateWhere: updateWhere?.call(ProfilePhoto.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProfilePhoto]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfilePhoto>> update(
    _is.DatabaseSession session,
    List<ProfilePhoto> rows, {
    _is.ColumnSelections<ProfilePhotoTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProfilePhoto>(
      rows,
      columns: columns?.call(ProfilePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProfilePhoto]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProfilePhoto> updateRow(
    _is.DatabaseSession session,
    ProfilePhoto row, {
    _is.ColumnSelections<ProfilePhotoTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProfilePhoto>(
      row,
      columns: columns?.call(ProfilePhoto.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProfilePhoto] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProfilePhoto?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProfilePhotoUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProfilePhoto>(
      id,
      columnValues: columnValues(ProfilePhoto.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProfilePhoto]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfilePhoto>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProfilePhotoUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProfilePhotoTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProfilePhoto>(
      columnValues: columnValues(ProfilePhoto.t.updateTable),
      where: where(ProfilePhoto.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProfilePhoto]s in the list and returns the deleted rows.
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
  Future<List<ProfilePhoto>> delete(
    _is.DatabaseSession session,
    List<ProfilePhoto> rows, {
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProfilePhoto>(
      rows,
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProfilePhoto].
  Future<ProfilePhoto> deleteRow(
    _is.DatabaseSession session,
    ProfilePhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProfilePhoto>(
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
  Future<List<ProfilePhoto>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfilePhotoTable> where,
    _is.OrderByBuilder<ProfilePhotoTable>? orderBy,
    _is.OrderByListBuilder<ProfilePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProfilePhoto>(
      where: where(ProfilePhoto.t),
      orderBy: orderBy?.call(ProfilePhoto.t),
      orderByList: orderByList?.call(ProfilePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfilePhotoTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProfilePhoto>(
      where: where?.call(ProfilePhoto.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProfilePhoto] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfilePhotoTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProfilePhoto>(
      where: where(ProfilePhoto.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
