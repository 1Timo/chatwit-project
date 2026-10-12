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

abstract class Message
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Message._({
    this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    this.text,
    required this.createdAt,
  });

  factory Message({
    int? id,
    required String senderId,
    required String senderName,
    required String receiverId,
    String? text,
    required DateTime createdAt,
  }) = _MessageImpl;

  factory Message.fromJson(Map<String, dynamic> jsonSerialization) {
    return Message(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as String,
      senderName: jsonSerialization['senderName'] as String,
      receiverId: jsonSerialization['receiverId'] as String,
      text: jsonSerialization['text'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MessageTable();

  static const db = MessageRepository._();

  @override
  int? id;

  String senderId;

  String senderName;

  String receiverId;

  String? text;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Message copyWith({
    int? id,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? text,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Message',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      if (text != null) 'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Message',
      if (id != null) 'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      if (text != null) 'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  static MessageInclude include() {
    return MessageInclude._();
  }

  static MessageIncludeList includeList({
    _is.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    MessageInclude? include,
  }) {
    return MessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageImpl extends Message {
  _MessageImpl({
    int? id,
    required String senderId,
    required String senderName,
    required String receiverId,
    String? text,
    required DateTime createdAt,
  }) : super._(
         id: id,
         senderId: senderId,
         senderName: senderName,
         receiverId: receiverId,
         text: text,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Message copyWith({
    Object? id = _Undefined,
    String? senderId,
    String? senderName,
    String? receiverId,
    Object? text = _Undefined,
    DateTime? createdAt,
  }) {
    return Message(
      id: id is int? ? id : this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      text: text is String? ? text : this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MessageUpdateTable extends _is.UpdateTable<MessageTable> {
  MessageUpdateTable(super.table);

  _is.ColumnValue<String, String> senderId(String value) => _is.ColumnValue(
    table.senderId,
    value,
  );

  _is.ColumnValue<String, String> senderName(String value) => _is.ColumnValue(
    table.senderName,
    value,
  );

  _is.ColumnValue<String, String> receiverId(String value) => _is.ColumnValue(
    table.receiverId,
    value,
  );

  _is.ColumnValue<String, String> text(String? value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MessageTable extends _is.Table<int?> {
  MessageTable({super.tableRelation}) : super(tableName: 'chat_messages') {
    updateTable = MessageUpdateTable(this);
    senderId = _is.ColumnString(
      'senderId',
      this,
    );
    senderName = _is.ColumnString(
      'senderName',
      this,
    );
    receiverId = _is.ColumnString(
      'receiverId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MessageUpdateTable updateTable;

  late final _is.ColumnString senderId;

  late final _is.ColumnString senderName;

  late final _is.ColumnString receiverId;

  late final _is.ColumnString text;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    senderId,
    senderName,
    receiverId,
    text,
    createdAt,
  ];
}

class MessageInclude extends _is.IncludeObject {
  MessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Message.t;
}

class MessageIncludeList extends _is.IncludeList {
  MessageIncludeList._({
    _is.WhereExpressionBuilder<MessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Message.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Message.t;
}

class MessageRepository {
  const MessageRepository._();

  /// Returns a list of [Message]s matching the given query parameters.
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
  Future<List<Message>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Message>(
      where: where?.call(Message.t),
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Message] matching the given query parameters.
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
  Future<Message?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageTable>? where,
    int? offset,
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Message>(
      where: where?.call(Message.t),
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Message] by its [id] or null if no such row exists.
  Future<Message?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Message>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Message]s in the list and returns the inserted rows.
  ///
  /// The returned [Message]s will have their `id` fields set.
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
  Future<List<Message>> insert(
    _is.DatabaseSession session,
    List<Message> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Message>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Message] and returns the inserted row.
  ///
  /// The returned [Message] will have its `id` field set.
  Future<Message> insertRow(
    _is.DatabaseSession session,
    Message row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Message>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Message]s in the list and returns the resulting rows.
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
  /// The returned [Message]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Message>> upsert(
    _is.DatabaseSession session,
    List<Message> rows, {
    required _is.ColumnSelections<MessageTable> conflictColumns,
    _is.ColumnSelections<MessageTable>? updateColumns,
    _is.WhereExpressionBuilder<MessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Message>(
      rows,
      conflictColumns: conflictColumns(Message.t),
      updateColumns: updateColumns?.call(Message.t),
      updateWhere: updateWhere?.call(Message.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Message] and returns the resulting row.
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
  /// The returned [Message] will have its `id` field set.
  Future<Message?> upsertRow(
    _is.DatabaseSession session,
    Message row, {
    required _is.ColumnSelections<MessageTable> conflictColumns,
    _is.ColumnSelections<MessageTable>? updateColumns,
    _is.WhereExpressionBuilder<MessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Message>(
      row,
      conflictColumns: conflictColumns(Message.t),
      updateColumns: updateColumns?.call(Message.t),
      updateWhere: updateWhere?.call(Message.t),
      transaction: transaction,
    );
  }

  /// Updates all [Message]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Message>> update(
    _is.DatabaseSession session,
    List<Message> rows, {
    _is.ColumnSelections<MessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Message>(
      rows,
      columns: columns?.call(Message.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Message]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Message> updateRow(
    _is.DatabaseSession session,
    Message row, {
    _is.ColumnSelections<MessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Message>(
      row,
      columns: columns?.call(Message.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Message] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Message?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MessageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Message>(
      id,
      columnValues: columnValues(Message.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Message]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Message>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MessageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Message>(
      columnValues: columnValues(Message.t.updateTable),
      where: where(Message.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Message]s in the list and returns the deleted rows.
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
  Future<List<Message>> delete(
    _is.DatabaseSession session,
    List<Message> rows, {
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Message>(
      rows,
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Message].
  Future<Message> deleteRow(
    _is.DatabaseSession session,
    Message row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Message>(
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
  Future<List<Message>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MessageTable> where,
    _is.OrderByBuilder<MessageTable>? orderBy,
    _is.OrderByListBuilder<MessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Message>(
      where: where(Message.t),
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Message>(
      where: where?.call(Message.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Message] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Message>(
      where: where(Message.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
