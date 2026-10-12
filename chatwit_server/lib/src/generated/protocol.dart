/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatwit_server/src/generated/model/comment.dart' as _iav58hmp;
import 'package:chatwit_server/src/generated/model/conversation.dart'
    as _ifw5rts0;
import 'package:chatwit_server/src/generated/model/follow.dart' as _ij98cumb;
import 'package:chatwit_server/src/generated/model/like.dart' as _ik9p5i5c;
import 'package:chatwit_server/src/generated/model/message.dart' as _i6h3gn7y;
import 'package:chatwit_server/src/generated/model/poll.dart' as _i69r0688;
import 'package:chatwit_server/src/generated/model/post.dart' as _igasesjr;
import 'package:chatwit_server/src/generated/model/profile_photo.dart'
    as _ifvet6nx;
import 'package:chatwit_server/src/generated/model/story.dart' as _ig6z4a17;
import 'package:chatwit_server/src/generated/model/user_notification.dart'
    as _i5n31hyi;
import 'package:chatwit_server/src/generated/model/user_registration.dart'
    as _iu3v6w0t;
import 'package:chatwit_server/src/generated/model/voice_recording.dart'
    as _ie4wwrks;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'model/bookmark.dart' as _i959diro;
import 'model/call_signal_event.dart' as _ik7lx2wf;
import 'model/comment.dart' as _iwzlvd5y;
import 'model/conversation.dart' as _i572tlub;
import 'model/conversation_visibility.dart' as _ieyjc0xl;
import 'model/device_token.dart' as _idx2xfcv;
import 'model/follow.dart' as _i0c921n7;
import 'model/hashtag.dart' as _i7gyyjqp;
import 'model/like.dart' as _iuk6cly0;
import 'model/mention.dart' as _igtq2vxu;
import 'model/message.dart' as _i6u51s7v;
import 'model/message_visibility.dart' as _i0esun7f;
import 'model/poll.dart' as _itxro0vi;
import 'model/poll_vote.dart' as _ioay62bc;
import 'model/post.dart' as _izp1hub3;
import 'model/post_interaction.dart' as _iqzgo8oe;
import 'model/post_share.dart' as _izcam7je;
import 'model/profile_photo.dart' as _ir6uk5nw;
import 'model/story.dart' as _itna30mb;
import 'model/user_interaction.dart' as _iacbo30p;
import 'model/user_notification.dart' as _ingntjwe;
import 'model/user_preference.dart' as _i47jhipq;
import 'model/user_registration.dart' as _i1k9df3h;
import 'model/voice_recording.dart' as _in4cxty5;
export 'greetings/greeting.dart';
export 'model/bookmark.dart';
export 'model/call_signal_event.dart';
export 'model/comment.dart';
export 'model/conversation.dart';
export 'model/conversation_visibility.dart';
export 'model/device_token.dart';
export 'model/follow.dart';
export 'model/hashtag.dart';
export 'model/like.dart';
export 'model/mention.dart';
export 'model/message.dart';
export 'model/message_visibility.dart';
export 'model/poll.dart';
export 'model/poll_vote.dart';
export 'model/post.dart';
export 'model/post_interaction.dart';
export 'model/post_share.dart';
export 'model/profile_photo.dart';
export 'model/story.dart';
export 'model/user_interaction.dart';
export 'model/user_notification.dart';
export 'model/user_preference.dart';
export 'model/user_registration.dart';
export 'model/voice_recording.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'bookmark',
      dartName: 'Bookmark',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'bookmark_user_post_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'postId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'call_signal_event',
      dartName: 'CallSignalEvent',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fromUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'toUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'payload',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'chat_messages',
      dartName: 'Message',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'senderId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'receiverId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'comment',
      dartName: 'Comment',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'authorId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fullName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'profileImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'videoUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'comment_fk_0',
          columns: ['authorId'],
          referenceTable: 'user_registration',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'conversation_visibility',
      dartName: 'ConversationVisibility',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'otherUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'hiddenBefore',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'conversation_visibility_user_other_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'otherUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'device_token',
      dartName: 'DeviceToken',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'token',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'deviceType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'follow',
      dartName: 'Follow',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'followerId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'followerName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'followingId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'followingName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'follow_follower_following_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'followerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'followingId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'hashtag',
      dartName: 'Hashtag',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'tag',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'like',
      dartName: 'Like',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'username',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'mention',
      dartName: 'Mention',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'message_visibility',
      dartName: 'MessageVisibility',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'messageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'message_visibility_user_message_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'messageId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'poll',
      dartName: 'Poll',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'question',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'options',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdByUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'totalVotes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'isClosed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'poll_vote',
      dartName: 'PollVote',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'pollId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'optionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'post',
      dartName: 'Post',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'authorId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'fullName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'profileImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'videoUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'audience',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'everyone\'',
        ),
        _isp.ColumnDefinition(
          name: 'viewCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'post_fk_0',
          columns: ['authorId'],
          referenceTable: 'user_registration',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'post_interaction',
      dartName: 'PostInteraction',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'interactionType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'post_interaction_user_post_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'postId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'interactionType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'post_share',
      dartName: 'PostShare',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'postId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'post_share_post_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'postId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'profile_photo',
      dartName: 'ProfilePhoto',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'imageType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'profile_photo_user_type_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'imageType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'stories',
      dartName: 'Story',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'profileImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'mediaUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'mediaType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_interaction',
      dartName: 'UserInteraction',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'targetUserId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'score',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_interaction_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_notification',
      dartName: 'UserNotification',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'relatedUserId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'relatedPostId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'isRead',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_preference',
      dartName: 'UserPreference',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'categories',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_registration',
      dartName: 'UserRegistration',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'firstName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'surname',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'middleName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'username',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dateOfBirth',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'gender',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'occupation',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'backgroundUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'profileImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'website',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isLocationPublic',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'isDobPublic',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'user_registration_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'auth_user_id_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'username_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'username',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'voice_recording',
      dartName: 'VoiceRecording',
      schema: 'public',
      module: 'chatwit',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'callRoomId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fromUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'toUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'recordingUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'duration',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i959diro.Bookmark) {
      return _i959diro.Bookmark.fromJson(data) as T;
    }
    if (t == _ik7lx2wf.CallSignalEvent) {
      return _ik7lx2wf.CallSignalEvent.fromJson(data) as T;
    }
    if (t == _iwzlvd5y.Comment) {
      return _iwzlvd5y.Comment.fromJson(data) as T;
    }
    if (t == _i572tlub.Conversation) {
      return _i572tlub.Conversation.fromJson(data) as T;
    }
    if (t == _ieyjc0xl.ConversationVisibility) {
      return _ieyjc0xl.ConversationVisibility.fromJson(data) as T;
    }
    if (t == _idx2xfcv.DeviceToken) {
      return _idx2xfcv.DeviceToken.fromJson(data) as T;
    }
    if (t == _i0c921n7.Follow) {
      return _i0c921n7.Follow.fromJson(data) as T;
    }
    if (t == _i7gyyjqp.Hashtag) {
      return _i7gyyjqp.Hashtag.fromJson(data) as T;
    }
    if (t == _iuk6cly0.Like) {
      return _iuk6cly0.Like.fromJson(data) as T;
    }
    if (t == _igtq2vxu.Mention) {
      return _igtq2vxu.Mention.fromJson(data) as T;
    }
    if (t == _i6u51s7v.Message) {
      return _i6u51s7v.Message.fromJson(data) as T;
    }
    if (t == _i0esun7f.MessageVisibility) {
      return _i0esun7f.MessageVisibility.fromJson(data) as T;
    }
    if (t == _itxro0vi.Poll) {
      return _itxro0vi.Poll.fromJson(data) as T;
    }
    if (t == _ioay62bc.PollVote) {
      return _ioay62bc.PollVote.fromJson(data) as T;
    }
    if (t == _izp1hub3.Post) {
      return _izp1hub3.Post.fromJson(data) as T;
    }
    if (t == _iqzgo8oe.PostInteraction) {
      return _iqzgo8oe.PostInteraction.fromJson(data) as T;
    }
    if (t == _izcam7je.PostShare) {
      return _izcam7je.PostShare.fromJson(data) as T;
    }
    if (t == _ir6uk5nw.ProfilePhoto) {
      return _ir6uk5nw.ProfilePhoto.fromJson(data) as T;
    }
    if (t == _itna30mb.Story) {
      return _itna30mb.Story.fromJson(data) as T;
    }
    if (t == _iacbo30p.UserInteraction) {
      return _iacbo30p.UserInteraction.fromJson(data) as T;
    }
    if (t == _ingntjwe.UserNotification) {
      return _ingntjwe.UserNotification.fromJson(data) as T;
    }
    if (t == _i47jhipq.UserPreference) {
      return _i47jhipq.UserPreference.fromJson(data) as T;
    }
    if (t == _i1k9df3h.UserRegistration) {
      return _i1k9df3h.UserRegistration.fromJson(data) as T;
    }
    if (t == _in4cxty5.VoiceRecording) {
      return _in4cxty5.VoiceRecording.fromJson(data) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i959diro.Bookmark?>()) {
      return (data != null ? _i959diro.Bookmark.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ik7lx2wf.CallSignalEvent?>()) {
      return (data != null ? _ik7lx2wf.CallSignalEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwzlvd5y.Comment?>()) {
      return (data != null ? _iwzlvd5y.Comment.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i572tlub.Conversation?>()) {
      return (data != null ? _i572tlub.Conversation.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieyjc0xl.ConversationVisibility?>()) {
      return (data != null
              ? _ieyjc0xl.ConversationVisibility.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idx2xfcv.DeviceToken?>()) {
      return (data != null ? _idx2xfcv.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0c921n7.Follow?>()) {
      return (data != null ? _i0c921n7.Follow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7gyyjqp.Hashtag?>()) {
      return (data != null ? _i7gyyjqp.Hashtag.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iuk6cly0.Like?>()) {
      return (data != null ? _iuk6cly0.Like.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igtq2vxu.Mention?>()) {
      return (data != null ? _igtq2vxu.Mention.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6u51s7v.Message?>()) {
      return (data != null ? _i6u51s7v.Message.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0esun7f.MessageVisibility?>()) {
      return (data != null ? _i0esun7f.MessageVisibility.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_itxro0vi.Poll?>()) {
      return (data != null ? _itxro0vi.Poll.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioay62bc.PollVote?>()) {
      return (data != null ? _ioay62bc.PollVote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izp1hub3.Post?>()) {
      return (data != null ? _izp1hub3.Post.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqzgo8oe.PostInteraction?>()) {
      return (data != null ? _iqzgo8oe.PostInteraction.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izcam7je.PostShare?>()) {
      return (data != null ? _izcam7je.PostShare.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir6uk5nw.ProfilePhoto?>()) {
      return (data != null ? _ir6uk5nw.ProfilePhoto.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itna30mb.Story?>()) {
      return (data != null ? _itna30mb.Story.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iacbo30p.UserInteraction?>()) {
      return (data != null ? _iacbo30p.UserInteraction.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ingntjwe.UserNotification?>()) {
      return (data != null ? _ingntjwe.UserNotification.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i47jhipq.UserPreference?>()) {
      return (data != null ? _i47jhipq.UserPreference.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1k9df3h.UserRegistration?>()) {
      return (data != null ? _i1k9df3h.UserRegistration.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in4cxty5.VoiceRecording?>()) {
      return (data != null ? _in4cxty5.VoiceRecording.fromJson(data) : null)
          as T;
    }
    if (t == List<_igasesjr.Post>) {
      return (data as List).map((e) => deserialize<_igasesjr.Post>(e)).toList()
          as T;
    }
    if (t == List<_i6h3gn7y.Message>) {
      return (data as List)
              .map((e) => deserialize<_i6h3gn7y.Message>(e))
              .toList()
          as T;
    }
    if (t == List<_ifw5rts0.Conversation>) {
      return (data as List)
              .map((e) => deserialize<_ifw5rts0.Conversation>(e))
              .toList()
          as T;
    }
    if (t == List<_ij98cumb.Follow>) {
      return (data as List)
              .map((e) => deserialize<_ij98cumb.Follow>(e))
              .toList()
          as T;
    }
    if (t == List<_i5n31hyi.UserNotification>) {
      return (data as List)
              .map((e) => deserialize<_i5n31hyi.UserNotification>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i69r0688.Poll>) {
      return (data as List).map((e) => deserialize<_i69r0688.Poll>(e)).toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == dynamic) {
      return deserializeDynamicFieldValue(data) as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_ik9p5i5c.Like>) {
      return (data as List).map((e) => deserialize<_ik9p5i5c.Like>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_iav58hmp.Comment>) {
      return (data as List)
              .map((e) => deserialize<_iav58hmp.Comment>(e))
              .toList()
          as T;
    }
    if (t == List<_ig6z4a17.Story>) {
      return (data as List).map((e) => deserialize<_ig6z4a17.Story>(e)).toList()
          as T;
    }
    if (t == List<_ifvet6nx.ProfilePhoto>) {
      return (data as List)
              .map((e) => deserialize<_ifvet6nx.ProfilePhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_iu3v6w0t.UserRegistration>) {
      return (data as List)
              .map((e) => deserialize<_iu3v6w0t.UserRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_ie4wwrks.VoiceRecording>) {
      return (data as List)
              .map((e) => deserialize<_ie4wwrks.VoiceRecording>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _i959diro.Bookmark => 'Bookmark',
      _ik7lx2wf.CallSignalEvent => 'CallSignalEvent',
      _iwzlvd5y.Comment => 'Comment',
      _i572tlub.Conversation => 'Conversation',
      _ieyjc0xl.ConversationVisibility => 'ConversationVisibility',
      _idx2xfcv.DeviceToken => 'DeviceToken',
      _i0c921n7.Follow => 'Follow',
      _i7gyyjqp.Hashtag => 'Hashtag',
      _iuk6cly0.Like => 'Like',
      _igtq2vxu.Mention => 'Mention',
      _i6u51s7v.Message => 'Message',
      _i0esun7f.MessageVisibility => 'MessageVisibility',
      _itxro0vi.Poll => 'Poll',
      _ioay62bc.PollVote => 'PollVote',
      _izp1hub3.Post => 'Post',
      _iqzgo8oe.PostInteraction => 'PostInteraction',
      _izcam7je.PostShare => 'PostShare',
      _ir6uk5nw.ProfilePhoto => 'ProfilePhoto',
      _itna30mb.Story => 'Story',
      _iacbo30p.UserInteraction => 'UserInteraction',
      _ingntjwe.UserNotification => 'UserNotification',
      _i47jhipq.UserPreference => 'UserPreference',
      _i1k9df3h.UserRegistration => 'UserRegistration',
      _in4cxty5.VoiceRecording => 'VoiceRecording',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('chatwit.', '');
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i959diro.Bookmark():
        return 'Bookmark';
      case _ik7lx2wf.CallSignalEvent():
        return 'CallSignalEvent';
      case _iwzlvd5y.Comment():
        return 'Comment';
      case _i572tlub.Conversation():
        return 'Conversation';
      case _ieyjc0xl.ConversationVisibility():
        return 'ConversationVisibility';
      case _idx2xfcv.DeviceToken():
        return 'DeviceToken';
      case _i0c921n7.Follow():
        return 'Follow';
      case _i7gyyjqp.Hashtag():
        return 'Hashtag';
      case _iuk6cly0.Like():
        return 'Like';
      case _igtq2vxu.Mention():
        return 'Mention';
      case _i6u51s7v.Message():
        return 'Message';
      case _i0esun7f.MessageVisibility():
        return 'MessageVisibility';
      case _itxro0vi.Poll():
        return 'Poll';
      case _ioay62bc.PollVote():
        return 'PollVote';
      case _izp1hub3.Post():
        return 'Post';
      case _iqzgo8oe.PostInteraction():
        return 'PostInteraction';
      case _izcam7je.PostShare():
        return 'PostShare';
      case _ir6uk5nw.ProfilePhoto():
        return 'ProfilePhoto';
      case _itna30mb.Story():
        return 'Story';
      case _iacbo30p.UserInteraction():
        return 'UserInteraction';
      case _ingntjwe.UserNotification():
        return 'UserNotification';
      case _i47jhipq.UserPreference():
        return 'UserPreference';
      case _i1k9df3h.UserRegistration():
        return 'UserRegistration';
      case _in4cxty5.VoiceRecording():
        return 'VoiceRecording';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'Bookmark') {
      return deserialize<_i959diro.Bookmark>(data['data']);
    }
    if (dataClassName == 'CallSignalEvent') {
      return deserialize<_ik7lx2wf.CallSignalEvent>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_iwzlvd5y.Comment>(data['data']);
    }
    if (dataClassName == 'Conversation') {
      return deserialize<_i572tlub.Conversation>(data['data']);
    }
    if (dataClassName == 'ConversationVisibility') {
      return deserialize<_ieyjc0xl.ConversationVisibility>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_idx2xfcv.DeviceToken>(data['data']);
    }
    if (dataClassName == 'Follow') {
      return deserialize<_i0c921n7.Follow>(data['data']);
    }
    if (dataClassName == 'Hashtag') {
      return deserialize<_i7gyyjqp.Hashtag>(data['data']);
    }
    if (dataClassName == 'Like') {
      return deserialize<_iuk6cly0.Like>(data['data']);
    }
    if (dataClassName == 'Mention') {
      return deserialize<_igtq2vxu.Mention>(data['data']);
    }
    if (dataClassName == 'Message') {
      return deserialize<_i6u51s7v.Message>(data['data']);
    }
    if (dataClassName == 'MessageVisibility') {
      return deserialize<_i0esun7f.MessageVisibility>(data['data']);
    }
    if (dataClassName == 'Poll') {
      return deserialize<_itxro0vi.Poll>(data['data']);
    }
    if (dataClassName == 'PollVote') {
      return deserialize<_ioay62bc.PollVote>(data['data']);
    }
    if (dataClassName == 'Post') {
      return deserialize<_izp1hub3.Post>(data['data']);
    }
    if (dataClassName == 'PostInteraction') {
      return deserialize<_iqzgo8oe.PostInteraction>(data['data']);
    }
    if (dataClassName == 'PostShare') {
      return deserialize<_izcam7je.PostShare>(data['data']);
    }
    if (dataClassName == 'ProfilePhoto') {
      return deserialize<_ir6uk5nw.ProfilePhoto>(data['data']);
    }
    if (dataClassName == 'Story') {
      return deserialize<_itna30mb.Story>(data['data']);
    }
    if (dataClassName == 'UserInteraction') {
      return deserialize<_iacbo30p.UserInteraction>(data['data']);
    }
    if (dataClassName == 'UserNotification') {
      return deserialize<_ingntjwe.UserNotification>(data['data']);
    }
    if (dataClassName == 'UserPreference') {
      return deserialize<_i47jhipq.UserPreference>(data['data']);
    }
    if (dataClassName == 'UserRegistration') {
      return deserialize<_i1k9df3h.UserRegistration>(data['data']);
    }
    if (dataClassName == 'VoiceRecording') {
      return deserialize<_in4cxty5.VoiceRecording>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('chatwit', this);
    _iacs.Protocol().registerHostProtocol('chatwit', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i959diro.Bookmark:
        return _i959diro.Bookmark.t;
      case _ik7lx2wf.CallSignalEvent:
        return _ik7lx2wf.CallSignalEvent.t;
      case _iwzlvd5y.Comment:
        return _iwzlvd5y.Comment.t;
      case _ieyjc0xl.ConversationVisibility:
        return _ieyjc0xl.ConversationVisibility.t;
      case _idx2xfcv.DeviceToken:
        return _idx2xfcv.DeviceToken.t;
      case _i0c921n7.Follow:
        return _i0c921n7.Follow.t;
      case _i7gyyjqp.Hashtag:
        return _i7gyyjqp.Hashtag.t;
      case _iuk6cly0.Like:
        return _iuk6cly0.Like.t;
      case _igtq2vxu.Mention:
        return _igtq2vxu.Mention.t;
      case _i6u51s7v.Message:
        return _i6u51s7v.Message.t;
      case _i0esun7f.MessageVisibility:
        return _i0esun7f.MessageVisibility.t;
      case _itxro0vi.Poll:
        return _itxro0vi.Poll.t;
      case _ioay62bc.PollVote:
        return _ioay62bc.PollVote.t;
      case _izp1hub3.Post:
        return _izp1hub3.Post.t;
      case _iqzgo8oe.PostInteraction:
        return _iqzgo8oe.PostInteraction.t;
      case _izcam7je.PostShare:
        return _izcam7je.PostShare.t;
      case _ir6uk5nw.ProfilePhoto:
        return _ir6uk5nw.ProfilePhoto.t;
      case _itna30mb.Story:
        return _itna30mb.Story.t;
      case _iacbo30p.UserInteraction:
        return _iacbo30p.UserInteraction.t;
      case _ingntjwe.UserNotification:
        return _ingntjwe.UserNotification.t;
      case _i47jhipq.UserPreference:
        return _i47jhipq.UserPreference.t;
      case _i1k9df3h.UserRegistration:
        return _i1k9df3h.UserRegistration.t;
      case _in4cxty5.VoiceRecording:
        return _in4cxty5.VoiceRecording.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'chatwit';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
