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
import 'package:chatwit_client/src/protocol/model/comment.dart' as _in32nkod;
import 'package:chatwit_client/src/protocol/model/conversation.dart'
    as _igejyjm9;
import 'package:chatwit_client/src/protocol/model/follow.dart' as _i8bd7a66;
import 'package:chatwit_client/src/protocol/model/like.dart' as _iv0ugiln;
import 'package:chatwit_client/src/protocol/model/message.dart' as _i96rmjqe;
import 'package:chatwit_client/src/protocol/model/poll.dart' as _ib0b6q21;
import 'package:chatwit_client/src/protocol/model/post.dart' as _ipkjcj6i;
import 'package:chatwit_client/src/protocol/model/profile_photo.dart'
    as _iut9lv6g;
import 'package:chatwit_client/src/protocol/model/story.dart' as _iwsjwlp6;
import 'package:chatwit_client/src/protocol/model/user_notification.dart'
    as _i7uwbyee;
import 'package:chatwit_client/src/protocol/model/user_registration.dart'
    as _il7jsi9g;
import 'package:chatwit_client/src/protocol/model/voice_recording.dart'
    as _in07n00n;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
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
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i959diro.Bookmark?>()) {
      return (data != null ? _i959diro.Bookmark.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik7lx2wf.CallSignalEvent?>()) {
      return (data != null ? _ik7lx2wf.CallSignalEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwzlvd5y.Comment?>()) {
      return (data != null ? _iwzlvd5y.Comment.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i572tlub.Conversation?>()) {
      return (data != null ? _i572tlub.Conversation.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieyjc0xl.ConversationVisibility?>()) {
      return (data != null
              ? _ieyjc0xl.ConversationVisibility.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idx2xfcv.DeviceToken?>()) {
      return (data != null ? _idx2xfcv.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0c921n7.Follow?>()) {
      return (data != null ? _i0c921n7.Follow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7gyyjqp.Hashtag?>()) {
      return (data != null ? _i7gyyjqp.Hashtag.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iuk6cly0.Like?>()) {
      return (data != null ? _iuk6cly0.Like.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igtq2vxu.Mention?>()) {
      return (data != null ? _igtq2vxu.Mention.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6u51s7v.Message?>()) {
      return (data != null ? _i6u51s7v.Message.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0esun7f.MessageVisibility?>()) {
      return (data != null ? _i0esun7f.MessageVisibility.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_itxro0vi.Poll?>()) {
      return (data != null ? _itxro0vi.Poll.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ioay62bc.PollVote?>()) {
      return (data != null ? _ioay62bc.PollVote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izp1hub3.Post?>()) {
      return (data != null ? _izp1hub3.Post.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqzgo8oe.PostInteraction?>()) {
      return (data != null ? _iqzgo8oe.PostInteraction.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izcam7je.PostShare?>()) {
      return (data != null ? _izcam7je.PostShare.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir6uk5nw.ProfilePhoto?>()) {
      return (data != null ? _ir6uk5nw.ProfilePhoto.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itna30mb.Story?>()) {
      return (data != null ? _itna30mb.Story.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iacbo30p.UserInteraction?>()) {
      return (data != null ? _iacbo30p.UserInteraction.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ingntjwe.UserNotification?>()) {
      return (data != null ? _ingntjwe.UserNotification.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i47jhipq.UserPreference?>()) {
      return (data != null ? _i47jhipq.UserPreference.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1k9df3h.UserRegistration?>()) {
      return (data != null ? _i1k9df3h.UserRegistration.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_in4cxty5.VoiceRecording?>()) {
      return (data != null ? _in4cxty5.VoiceRecording.fromJson(data) : null)
          as T;
    }
    if (t == List<_ipkjcj6i.Post>) {
      return (data as List).map((e) => deserialize<_ipkjcj6i.Post>(e)).toList()
          as T;
    }
    if (t == List<_i96rmjqe.Message>) {
      return (data as List)
              .map((e) => deserialize<_i96rmjqe.Message>(e))
              .toList()
          as T;
    }
    if (t == List<_igejyjm9.Conversation>) {
      return (data as List)
              .map((e) => deserialize<_igejyjm9.Conversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i8bd7a66.Follow>) {
      return (data as List)
              .map((e) => deserialize<_i8bd7a66.Follow>(e))
              .toList()
          as T;
    }
    if (t == List<_i7uwbyee.UserNotification>) {
      return (data as List)
              .map((e) => deserialize<_i7uwbyee.UserNotification>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ib0b6q21.Poll>) {
      return (data as List).map((e) => deserialize<_ib0b6q21.Poll>(e)).toList()
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
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_iv0ugiln.Like>) {
      return (data as List).map((e) => deserialize<_iv0ugiln.Like>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_in32nkod.Comment>) {
      return (data as List)
              .map((e) => deserialize<_in32nkod.Comment>(e))
              .toList()
          as T;
    }
    if (t == List<_iwsjwlp6.Story>) {
      return (data as List).map((e) => deserialize<_iwsjwlp6.Story>(e)).toList()
          as T;
    }
    if (t == List<_iut9lv6g.ProfilePhoto>) {
      return (data as List)
              .map((e) => deserialize<_iut9lv6g.ProfilePhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_il7jsi9g.UserRegistration>) {
      return (data as List)
              .map((e) => deserialize<_il7jsi9g.UserRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_in07n00n.VoiceRecording>) {
      return (data as List)
              .map((e) => deserialize<_in07n00n.VoiceRecording>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('chatwit', this);
    _iacc.Protocol().registerHostProtocol('chatwit', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
