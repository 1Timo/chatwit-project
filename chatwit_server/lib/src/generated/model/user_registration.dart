/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatwit_server/src/generated/protocol.dart' as _ibxtvcw4;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;

abstract class UserRegistration
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserRegistration._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.firstName,
    required this.surname,
    this.middleName,
    required this.username,
    required this.dateOfBirth,
    required this.gender,
    this.bio,
    this.occupation,
    this.backgroundUrl,
    this.profileImageUrl,
    this.location,
    this.website,
    bool? isLocationPublic,
    bool? isDobPublic,
    this.createdAt,
  }) : isLocationPublic = isLocationPublic ?? true,
       isDobPublic = isDobPublic ?? false;

  factory UserRegistration({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  }) = _UserRegistrationImpl;

  factory UserRegistration.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRegistration(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ibxtvcw4.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      firstName: jsonSerialization['firstName'] as String,
      surname: jsonSerialization['surname'] as String,
      middleName: jsonSerialization['middleName'] as String?,
      username: jsonSerialization['username'] as String,
      dateOfBirth: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['dateOfBirth'],
      ),
      gender: jsonSerialization['gender'] as String,
      bio: jsonSerialization['bio'] as String?,
      occupation: jsonSerialization['occupation'] as String?,
      backgroundUrl: jsonSerialization['backgroundUrl'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      location: jsonSerialization['location'] as String?,
      website: jsonSerialization['website'] as String?,
      isLocationPublic: jsonSerialization['isLocationPublic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['isLocationPublic'],
            ),
      isDobPublic: jsonSerialization['isDobPublic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDobPublic']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = UserRegistrationTable();

  static const db = UserRegistrationRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String firstName;

  String surname;

  String? middleName;

  String username;

  DateTime dateOfBirth;

  String gender;

  String? bio;

  String? occupation;

  String? backgroundUrl;

  String? profileImageUrl;

  String? location;

  String? website;

  bool isLocationPublic;

  bool isDobPublic;

  DateTime? createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserRegistration]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserRegistration copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? firstName,
    String? surname,
    String? middleName,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRegistration',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'surname': surname,
      if (middleName != null) 'middleName': middleName,
      'username': username,
      'dateOfBirth': dateOfBirth.toJson(),
      'gender': gender,
      if (bio != null) 'bio': bio,
      if (occupation != null) 'occupation': occupation,
      if (backgroundUrl != null) 'backgroundUrl': backgroundUrl,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      'isLocationPublic': isLocationPublic,
      'isDobPublic': isDobPublic,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRegistration',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'surname': surname,
      if (middleName != null) 'middleName': middleName,
      'username': username,
      'dateOfBirth': dateOfBirth.toJson(),
      'gender': gender,
      if (bio != null) 'bio': bio,
      if (occupation != null) 'occupation': occupation,
      if (backgroundUrl != null) 'backgroundUrl': backgroundUrl,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      'isLocationPublic': isLocationPublic,
      'isDobPublic': isDobPublic,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static UserRegistrationInclude include({_iacs.AuthUserInclude? authUser}) {
    return UserRegistrationInclude._(authUser: authUser);
  }

  static UserRegistrationIncludeList includeList({
    _is.WhereExpressionBuilder<UserRegistrationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    UserRegistrationInclude? include,
  }) {
    return UserRegistrationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRegistrationImpl extends UserRegistration {
  _UserRegistrationImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    String? bio,
    String? occupation,
    String? backgroundUrl,
    String? profileImageUrl,
    String? location,
    String? website,
    bool? isLocationPublic,
    bool? isDobPublic,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         firstName: firstName,
         surname: surname,
         middleName: middleName,
         username: username,
         dateOfBirth: dateOfBirth,
         gender: gender,
         bio: bio,
         occupation: occupation,
         backgroundUrl: backgroundUrl,
         profileImageUrl: profileImageUrl,
         location: location,
         website: website,
         isLocationPublic: isLocationPublic,
         isDobPublic: isDobPublic,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserRegistration]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserRegistration copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? firstName,
    String? surname,
    Object? middleName = _Undefined,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    Object? bio = _Undefined,
    Object? occupation = _Undefined,
    Object? backgroundUrl = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? location = _Undefined,
    Object? website = _Undefined,
    bool? isLocationPublic,
    bool? isDobPublic,
    Object? createdAt = _Undefined,
  }) {
    return UserRegistration(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      middleName: middleName is String? ? middleName : this.middleName,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bio: bio is String? ? bio : this.bio,
      occupation: occupation is String? ? occupation : this.occupation,
      backgroundUrl: backgroundUrl is String?
          ? backgroundUrl
          : this.backgroundUrl,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      location: location is String? ? location : this.location,
      website: website is String? ? website : this.website,
      isLocationPublic: isLocationPublic ?? this.isLocationPublic,
      isDobPublic: isDobPublic ?? this.isDobPublic,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class UserRegistrationUpdateTable
    extends _is.UpdateTable<UserRegistrationTable> {
  UserRegistrationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> firstName(String value) => _is.ColumnValue(
    table.firstName,
    value,
  );

  _is.ColumnValue<String, String> surname(String value) => _is.ColumnValue(
    table.surname,
    value,
  );

  _is.ColumnValue<String, String> middleName(String? value) => _is.ColumnValue(
    table.middleName,
    value,
  );

  _is.ColumnValue<String, String> username(String value) => _is.ColumnValue(
    table.username,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dateOfBirth(DateTime value) =>
      _is.ColumnValue(
        table.dateOfBirth,
        value,
      );

  _is.ColumnValue<String, String> gender(String value) => _is.ColumnValue(
    table.gender,
    value,
  );

  _is.ColumnValue<String, String> bio(String? value) => _is.ColumnValue(
    table.bio,
    value,
  );

  _is.ColumnValue<String, String> occupation(String? value) => _is.ColumnValue(
    table.occupation,
    value,
  );

  _is.ColumnValue<String, String> backgroundUrl(String? value) =>
      _is.ColumnValue(
        table.backgroundUrl,
        value,
      );

  _is.ColumnValue<String, String> profileImageUrl(String? value) =>
      _is.ColumnValue(
        table.profileImageUrl,
        value,
      );

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> website(String? value) => _is.ColumnValue(
    table.website,
    value,
  );

  _is.ColumnValue<bool, bool> isLocationPublic(bool value) => _is.ColumnValue(
    table.isLocationPublic,
    value,
  );

  _is.ColumnValue<bool, bool> isDobPublic(bool value) => _is.ColumnValue(
    table.isDobPublic,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserRegistrationTable extends _is.Table<int?> {
  UserRegistrationTable({super.tableRelation})
    : super(tableName: 'user_registration') {
    updateTable = UserRegistrationUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    firstName = _is.ColumnString(
      'firstName',
      this,
    );
    surname = _is.ColumnString(
      'surname',
      this,
    );
    middleName = _is.ColumnString(
      'middleName',
      this,
    );
    username = _is.ColumnString(
      'username',
      this,
    );
    dateOfBirth = _is.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    gender = _is.ColumnString(
      'gender',
      this,
    );
    bio = _is.ColumnString(
      'bio',
      this,
    );
    occupation = _is.ColumnString(
      'occupation',
      this,
    );
    backgroundUrl = _is.ColumnString(
      'backgroundUrl',
      this,
    );
    profileImageUrl = _is.ColumnString(
      'profileImageUrl',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    website = _is.ColumnString(
      'website',
      this,
    );
    isLocationPublic = _is.ColumnBool(
      'isLocationPublic',
      this,
      hasDefault: true,
    );
    isDobPublic = _is.ColumnBool(
      'isDobPublic',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserRegistrationUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString firstName;

  late final _is.ColumnString surname;

  late final _is.ColumnString middleName;

  late final _is.ColumnString username;

  late final _is.ColumnDateTime dateOfBirth;

  late final _is.ColumnString gender;

  late final _is.ColumnString bio;

  late final _is.ColumnString occupation;

  late final _is.ColumnString backgroundUrl;

  late final _is.ColumnString profileImageUrl;

  late final _is.ColumnString location;

  late final _is.ColumnString website;

  late final _is.ColumnBool isLocationPublic;

  late final _is.ColumnBool isDobPublic;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: UserRegistration.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    firstName,
    surname,
    middleName,
    username,
    dateOfBirth,
    gender,
    bio,
    occupation,
    backgroundUrl,
    profileImageUrl,
    location,
    website,
    isLocationPublic,
    isDobPublic,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class UserRegistrationInclude extends _is.IncludeObject {
  UserRegistrationInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => UserRegistration.t;
}

class UserRegistrationIncludeList extends _is.IncludeList {
  UserRegistrationIncludeList._({
    _is.WhereExpressionBuilder<UserRegistrationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRegistration.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserRegistration.t;
}

class UserRegistrationRepository {
  const UserRegistrationRepository._();

  final attachRow = const UserRegistrationAttachRowRepository._();

  /// Returns a list of [UserRegistration]s matching the given query parameters.
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
  Future<List<UserRegistration>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRegistrationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    _is.Transaction? transaction,
    UserRegistrationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRegistration>(
      where: where?.call(UserRegistration.t),
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRegistration] matching the given query parameters.
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
  Future<UserRegistration?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRegistrationTable>? where,
    int? offset,
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    _is.Transaction? transaction,
    UserRegistrationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRegistration>(
      where: where?.call(UserRegistration.t),
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRegistration] by its [id] or null if no such row exists.
  Future<UserRegistration?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    UserRegistrationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRegistration>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRegistration]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRegistration]s will have their `id` fields set.
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
  Future<List<UserRegistration>> insert(
    _is.DatabaseSession session,
    List<UserRegistration> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserRegistration>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserRegistration] and returns the inserted row.
  ///
  /// The returned [UserRegistration] will have its `id` field set.
  Future<UserRegistration> insertRow(
    _is.DatabaseSession session,
    UserRegistration row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRegistration>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserRegistration]s in the list and returns the resulting rows.
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
  /// The returned [UserRegistration]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRegistration>> upsert(
    _is.DatabaseSession session,
    List<UserRegistration> rows, {
    required _is.ColumnSelections<UserRegistrationTable> conflictColumns,
    _is.ColumnSelections<UserRegistrationTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRegistrationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserRegistration>(
      rows,
      conflictColumns: conflictColumns(UserRegistration.t),
      updateColumns: updateColumns?.call(UserRegistration.t),
      updateWhere: updateWhere?.call(UserRegistration.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserRegistration] and returns the resulting row.
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
  /// The returned [UserRegistration] will have its `id` field set.
  Future<UserRegistration?> upsertRow(
    _is.DatabaseSession session,
    UserRegistration row, {
    required _is.ColumnSelections<UserRegistrationTable> conflictColumns,
    _is.ColumnSelections<UserRegistrationTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRegistrationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserRegistration>(
      row,
      conflictColumns: conflictColumns(UserRegistration.t),
      updateColumns: updateColumns?.call(UserRegistration.t),
      updateWhere: updateWhere?.call(UserRegistration.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserRegistration]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRegistration>> update(
    _is.DatabaseSession session,
    List<UserRegistration> rows, {
    _is.ColumnSelections<UserRegistrationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserRegistration>(
      rows,
      columns: columns?.call(UserRegistration.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserRegistration]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRegistration> updateRow(
    _is.DatabaseSession session,
    UserRegistration row, {
    _is.ColumnSelections<UserRegistrationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRegistration>(
      row,
      columns: columns?.call(UserRegistration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRegistration] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRegistration?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserRegistrationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRegistration>(
      id,
      columnValues: columnValues(UserRegistration.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRegistration]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRegistration>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserRegistrationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserRegistrationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserRegistration>(
      columnValues: columnValues(UserRegistration.t.updateTable),
      where: where(UserRegistration.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserRegistration]s in the list and returns the deleted rows.
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
  Future<List<UserRegistration>> delete(
    _is.DatabaseSession session,
    List<UserRegistration> rows, {
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserRegistration>(
      rows,
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserRegistration].
  Future<UserRegistration> deleteRow(
    _is.DatabaseSession session,
    UserRegistration row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRegistration>(
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
  Future<List<UserRegistration>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRegistrationTable> where,
    _is.OrderByBuilder<UserRegistrationTable>? orderBy,
    _is.OrderByListBuilder<UserRegistrationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserRegistration>(
      where: where(UserRegistration.t),
      orderBy: orderBy?.call(UserRegistration.t),
      orderByList: orderByList?.call(UserRegistration.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRegistrationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserRegistration>(
      where: where?.call(UserRegistration.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRegistration] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRegistrationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRegistration>(
      where: where(UserRegistration.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserRegistrationAttachRowRepository {
  const UserRegistrationAttachRowRepository._();

  /// Creates a relation between the given [UserRegistration] and [AuthUser]
  /// by setting the [UserRegistration]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    UserRegistration userRegistration,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (userRegistration.id == null) {
      throw ArgumentError.notNull('userRegistration.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $userRegistration = userRegistration.copyWith(authUserId: authUser.id);
    await session.db.updateRow<UserRegistration>(
      $userRegistration,
      columns: [UserRegistration.t.authUserId],
      transaction: transaction,
    );
  }
}
