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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../endpoints/bookmark_endpoint.dart' as _irqz9g6z;
import '../endpoints/call_signal_endpoint.dart' as _id9vwbx7;
import '../endpoints/chat_endpoint.dart' as _ihc7hrsa;
import '../endpoints/email_idp_endpoint.dart' as _ilutrrxn;
import '../endpoints/file_endpoint.dart' as _iiw2d7cj;
import '../endpoints/follow_endpoint.dart' as _imrfmyfa;
import '../endpoints/google_idp_endpoint.dart' as _iiimk4ot;
import '../endpoints/notification_database_endpoint.dart' as _iywgwwpw;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/poll_endpoint.dart' as _ip1ycqqu;
import '../endpoints/post_endpoint.dart' as _iysl4a9p;
import '../endpoints/refresh_jwt_tokens_endpoint.dart' as _iaxm0zi1;
import '../endpoints/story_endpoint.dart' as _iiu4mi32;
import '../endpoints/user_preference_endpoint.dart' as _i3sl96h6;
import '../endpoints/user_profile_edit_endpoint.dart' as _iko41amg;
import '../endpoints/user_registration_endpoint.dart' as _iyqeg5ab;
import '../endpoints/voice_recording_endpoint.dart' as _ihbrzkxx;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'bookmark': _irqz9g6z.BookmarkEndpoint()
        ..initialize(
          server,
          'bookmark',
          null,
        ),
      'callSignal': _id9vwbx7.CallSignalEndpoint()
        ..initialize(
          server,
          'callSignal',
          null,
        ),
      'chat': _ihc7hrsa.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'emailIdp': _ilutrrxn.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'file': _iiw2d7cj.FileEndpoint()
        ..initialize(
          server,
          'file',
          null,
        ),
      'follow': _imrfmyfa.FollowEndpoint()
        ..initialize(
          server,
          'follow',
          null,
        ),
      'googleIdp': _iiimk4ot.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'notificationDatabase': _iywgwwpw.NotificationDatabaseEndpoint()
        ..initialize(
          server,
          'notificationDatabase',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'poll': _ip1ycqqu.PollEndpoint()
        ..initialize(
          server,
          'poll',
          null,
        ),
      'post': _iysl4a9p.PostEndpoint()
        ..initialize(
          server,
          'post',
          null,
        ),
      'refreshJwtTokens': _iaxm0zi1.RefreshJwtTokensEndpoint()
        ..initialize(
          server,
          'refreshJwtTokens',
          null,
        ),
      'story': _iiu4mi32.StoryEndpoint()
        ..initialize(
          server,
          'story',
          null,
        ),
      'userPreference': _i3sl96h6.UserPreferenceEndpoint()
        ..initialize(
          server,
          'userPreference',
          null,
        ),
      'userProfileEdit': _iko41amg.UserProfileEditEndpoint()
        ..initialize(
          server,
          'userProfileEdit',
          null,
        ),
      'userRegistration': _iyqeg5ab.UserRegistrationEndpoint()
        ..initialize(
          server,
          'userRegistration',
          null,
        ),
      'voiceRecording': _ihbrzkxx.VoiceRecordingEndpoint()
        ..initialize(
          server,
          'voiceRecording',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['bookmark'] = _is.EndpointConnector(
      name: 'bookmark',
      endpoint: endpoints['bookmark']!,
      methodConnectors: {
        'toggleBookmark': _is.MethodConnector(
          name: 'toggleBookmark',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bookmark'] as _irqz9g6z.BookmarkEndpoint)
                  .toggleBookmark(
                    session,
                    params['postId'],
                  ),
        ),
        'getBookmarkedPosts': _is.MethodConnector(
          name: 'getBookmarkedPosts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bookmark'] as _irqz9g6z.BookmarkEndpoint)
                  .getBookmarkedPosts(session),
        ),
        'isBookmarked': _is.MethodConnector(
          name: 'isBookmarked',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bookmark'] as _irqz9g6z.BookmarkEndpoint)
                  .isBookmarked(
                    session,
                    params['postId'],
                  ),
        ),
      },
    );
    connectors['callSignal'] = _is.EndpointConnector(
      name: 'callSignal',
      endpoint: endpoints['callSignal']!,
      methodConnectors: {
        'sendSignal': _is.MethodConnector(
          name: 'sendSignal',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'toUserId': _is.ParameterDescription(
              name: 'toUserId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'payload': _is.ParameterDescription(
              name: 'payload',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['callSignal'] as _id9vwbx7.CallSignalEndpoint)
                      .sendSignal(
                        session,
                        roomId: params['roomId'],
                        toUserId: params['toUserId'],
                        type: params['type'],
                        payload: params['payload'],
                      ),
        ),
        'listenToSignals': _is.MethodStreamConnector(
          name: 'listenToSignals',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['callSignal'] as _id9vwbx7.CallSignalEndpoint)
                  .listenToSignals(
                    session,
                    roomId: params['roomId'],
                  ),
        ),
      },
    );
    connectors['chat'] = _is.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'receiverId': _is.ParameterDescription(
              name: 'receiverId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).sendMessage(
                    session,
                    params['receiverId'],
                    params['text'],
                  ),
        ),
        'getConversation': _is.MethodConnector(
          name: 'getConversation',
          params: {
            'otherUserId': _is.ParameterDescription(
              name: 'otherUserId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).getConversation(
                    session,
                    params['otherUserId'],
                  ),
        ),
        'deleteMessageForMe': _is.MethodConnector(
          name: 'deleteMessageForMe',
          params: {
            'messageId': _is.ParameterDescription(
              name: 'messageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .deleteMessageForMe(
                    session,
                    params['messageId'],
                  ),
        ),
        'deleteMessageForEveryone': _is.MethodConnector(
          name: 'deleteMessageForEveryone',
          params: {
            'messageId': _is.ParameterDescription(
              name: 'messageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .deleteMessageForEveryone(
                    session,
                    params['messageId'],
                  ),
        ),
        'deleteConversationForMe': _is.MethodConnector(
          name: 'deleteConversationForMe',
          params: {
            'otherUserId': _is.ParameterDescription(
              name: 'otherUserId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .deleteConversationForMe(
                    session,
                    params['otherUserId'],
                  ),
        ),
        'deleteConversationForEveryone': _is.MethodConnector(
          name: 'deleteConversationForEveryone',
          params: {
            'otherUserId': _is.ParameterDescription(
              name: 'otherUserId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .deleteConversationForEveryone(
                    session,
                    params['otherUserId'],
                  ),
        ),
        'getRecentConversations': _is.MethodConnector(
          name: 'getRecentConversations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .getRecentConversations(session),
        ),
        'listenToMessages': _is.MethodStreamConnector(
          name: 'listenToMessages',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .listenToMessages(session),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ilutrrxn.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['file'] = _is.EndpointConnector(
      name: 'file',
      endpoint: endpoints['file']!,
      methodConnectors: {
        'getUploadDescription': _is.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['file'] as _iiw2d7cj.FileEndpoint)
                  .getUploadDescription(
                    session,
                    params['path'],
                  ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['file'] as _iiw2d7cj.FileEndpoint).verifyUpload(
                    session,
                    params['path'],
                  ),
        ),
        'getPublicUrl': _is.MethodConnector(
          name: 'getPublicUrl',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['file'] as _iiw2d7cj.FileEndpoint).getPublicUrl(
                    session,
                    params['path'],
                  ),
        ),
      },
    );
    connectors['follow'] = _is.EndpointConnector(
      name: 'follow',
      endpoint: endpoints['follow']!,
      methodConnectors: {
        'toggleFollow': _is.MethodConnector(
          name: 'toggleFollow',
          params: {
            'followingId': _is.ParameterDescription(
              name: 'followingId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'followingName': _is.ParameterDescription(
              name: 'followingName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['follow'] as _imrfmyfa.FollowEndpoint)
                  .toggleFollow(
                    session,
                    params['followingId'],
                    params['followingName'],
                  ),
        ),
        'getFollowing': _is.MethodConnector(
          name: 'getFollowing',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['follow'] as _imrfmyfa.FollowEndpoint)
                  .getFollowing(session),
        ),
        'getFollowers': _is.MethodConnector(
          name: 'getFollowers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['follow'] as _imrfmyfa.FollowEndpoint)
                  .getFollowers(session),
        ),
        'getUserFollowing': _is.MethodConnector(
          name: 'getUserFollowing',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['follow'] as _imrfmyfa.FollowEndpoint)
                  .getUserFollowing(
                    session,
                    params['userId'],
                  ),
        ),
        'getUserFollowers': _is.MethodConnector(
          name: 'getUserFollowers',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['follow'] as _imrfmyfa.FollowEndpoint)
                  .getUserFollowers(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _iiimk4ot.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _iiimk4ot.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _iiimk4ot.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['notificationDatabase'] = _is.EndpointConnector(
      name: 'notificationDatabase',
      endpoint: endpoints['notificationDatabase']!,
      methodConnectors: {
        'getNotifications': _is.MethodConnector(
          name: 'getNotifications',
          params: {
            'unreadOnly': _is.ParameterDescription(
              name: 'unreadOnly',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationDatabase']
                          as _iywgwwpw.NotificationDatabaseEndpoint)
                      .getNotifications(
                        session,
                        unreadOnly: params['unreadOnly'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'markAsRead': _is.MethodConnector(
          name: 'markAsRead',
          params: {
            'notificationId': _is.ParameterDescription(
              name: 'notificationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationDatabase']
                          as _iywgwwpw.NotificationDatabaseEndpoint)
                      .markAsRead(
                        session,
                        params['notificationId'],
                      ),
        ),
        'markAllAsRead': _is.MethodConnector(
          name: 'markAllAsRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationDatabase']
                          as _iywgwwpw.NotificationDatabaseEndpoint)
                      .markAllAsRead(session),
        ),
        'getUnreadCount': _is.MethodConnector(
          name: 'getUnreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationDatabase']
                          as _iywgwwpw.NotificationDatabaseEndpoint)
                      .getUnreadCount(session),
        ),
        'deleteNotification': _is.MethodConnector(
          name: 'deleteNotification',
          params: {
            'notificationId': _is.ParameterDescription(
              name: 'notificationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationDatabase']
                          as _iywgwwpw.NotificationDatabaseEndpoint)
                      .deleteNotification(
                        session,
                        params['notificationId'],
                      ),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'registerDeviceToken': _is.MethodConnector(
          name: 'registerDeviceToken',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'deviceType': _is.ParameterDescription(
              name: 'deviceType',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .registerDeviceToken(
                        session,
                        params['token'],
                        params['deviceType'],
                      ),
        ),
        'unregisterDeviceToken': _is.MethodConnector(
          name: 'unregisterDeviceToken',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .unregisterDeviceToken(
                        session,
                        params['token'],
                      ),
        ),
        'sendPushNotification': _is.MethodConnector(
          name: 'sendPushNotification',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .sendPushNotification(
                        session,
                        params['userId'],
                        params['title'],
                        params['body'],
                      ),
        ),
      },
    );
    connectors['poll'] = _is.EndpointConnector(
      name: 'poll',
      endpoint: endpoints['poll']!,
      methodConnectors: {
        'createPoll': _is.MethodConnector(
          name: 'createPoll',
          params: {
            'question': _is.ParameterDescription(
              name: 'question',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'options': _is.ParameterDescription(
              name: 'options',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'expiresAt': _is.ParameterDescription(
              name: 'expiresAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['poll'] as _ip1ycqqu.PollEndpoint).createPoll(
                    session,
                    question: params['question'],
                    options: params['options'],
                    expiresAt: params['expiresAt'],
                  ),
        ),
        'getPolls': _is.MethodConnector(
          name: 'getPolls',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['poll'] as _ip1ycqqu.PollEndpoint).getPolls(
                session,
                limit: params['limit'],
              ),
        ),
        'getPoll': _is.MethodConnector(
          name: 'getPoll',
          params: {
            'pollId': _is.ParameterDescription(
              name: 'pollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['poll'] as _ip1ycqqu.PollEndpoint).getPoll(
                session,
                params['pollId'],
              ),
        ),
        'vote': _is.MethodConnector(
          name: 'vote',
          params: {
            'pollId': _is.ParameterDescription(
              name: 'pollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'optionIndex': _is.ParameterDescription(
              name: 'optionIndex',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['poll'] as _ip1ycqqu.PollEndpoint).vote(
                session,
                pollId: params['pollId'],
                optionIndex: params['optionIndex'],
              ),
        ),
        'getPollSummary': _is.MethodConnector(
          name: 'getPollSummary',
          params: {
            'pollId': _is.ParameterDescription(
              name: 'pollId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['poll'] as _ip1ycqqu.PollEndpoint).getPollSummary(
                    session,
                    params['pollId'],
                  ),
        ),
      },
    );
    connectors['post'] = _is.EndpointConnector(
      name: 'post',
      endpoint: endpoints['post']!,
      methodConnectors: {
        'createPost': _is.MethodConnector(
          name: 'createPost',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _is.ParameterDescription(
              name: 'imageUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'videoUrl': _is.ParameterDescription(
              name: 'videoUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'audience': _is.ParameterDescription(
              name: 'audience',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'sharedWithUserIds': _is.ParameterDescription(
              name: 'sharedWithUserIds',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).createPost(
                    session,
                    params['text'],
                    params['imageUrl'],
                    params['videoUrl'],
                    params['category'],
                    params['location'],
                    params['audience'],
                    params['sharedWithUserIds'],
                  ),
        ),
        'getAllPosts': _is.MethodConnector(
          name: 'getAllPosts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getAllPosts(session),
        ),
        'getPaginatedPosts': _is.MethodConnector(
          name: 'getPaginatedPosts',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getPaginatedPosts(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getUserPosts': _is.MethodConnector(
          name: 'getUserPosts',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).getUserPosts(
                    session,
                    params['userId'],
                  ),
        ),
        'editPost': _is.MethodConnector(
          name: 'editPost',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newText': _is.ParameterDescription(
              name: 'newText',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint).editPost(
                session,
                params['postId'],
                params['newText'],
              ),
        ),
        'deletePost': _is.MethodConnector(
          name: 'deletePost',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).deletePost(
                    session,
                    params['postId'],
                  ),
        ),
        'toggleLike': _is.MethodConnector(
          name: 'toggleLike',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).toggleLike(
                    session,
                    params['postId'],
                  ),
        ),
        'getLikes': _is.MethodConnector(
          name: 'getLikes',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint).getLikes(
                session,
                params['postId'],
              ),
        ),
        'incrementViewCount': _is.MethodConnector(
          name: 'incrementViewCount',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .incrementViewCount(
                    session,
                    params['postId'],
                  ),
        ),
        'batchIncrementViewCounts': _is.MethodConnector(
          name: 'batchIncrementViewCounts',
          params: {
            'postIds': _is.ParameterDescription(
              name: 'postIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .batchIncrementViewCounts(
                    session,
                    params['postIds'],
                  ),
        ),
        'logInteraction': _is.MethodConnector(
          name: 'logInteraction',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'score': _is.ParameterDescription(
              name: 'score',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'targetUserId': _is.ParameterDescription(
              name: 'targetUserId',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).logInteraction(
                    session,
                    params['category'],
                    params['score'],
                    targetUserId: params['targetUserId'],
                  ),
        ),
        'getRecommendedFeed': _is.MethodConnector(
          name: 'getRecommendedFeed',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getRecommendedFeed(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'createComment': _is.MethodConnector(
          name: 'createComment',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _is.ParameterDescription(
              name: 'imageUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'videoUrl': _is.ParameterDescription(
              name: 'videoUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).createComment(
                    session,
                    params['postId'],
                    params['text'],
                    params['imageUrl'],
                    params['videoUrl'],
                  ),
        ),
        'getComments': _is.MethodConnector(
          name: 'getComments',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).getComments(
                    session,
                    params['postId'],
                  ),
        ),
        'editComment': _is.MethodConnector(
          name: 'editComment',
          params: {
            'commentId': _is.ParameterDescription(
              name: 'commentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newText': _is.ParameterDescription(
              name: 'newText',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).editComment(
                    session,
                    params['commentId'],
                    params['newText'],
                  ),
        ),
        'deleteComment': _is.MethodConnector(
          name: 'deleteComment',
          params: {
            'commentId': _is.ParameterDescription(
              name: 'commentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).deleteComment(
                    session,
                    params['commentId'],
                  ),
        ),
        'searchPosts': _is.MethodConnector(
          name: 'searchPosts',
          params: {
            'keyword': _is.ParameterDescription(
              name: 'keyword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).searchPosts(
                    session,
                    params['keyword'],
                  ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['post'] as _iysl4a9p.PostEndpoint).verifyUpload(
                    session,
                    params['path'],
                  ),
        ),
        'getUploadDescription': _is.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getUploadDescription(
                    session,
                    params['path'],
                  ),
        ),
        'logRecommendationFeedback': _is.MethodConnector(
          name: 'logRecommendationFeedback',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'interested': _is.ParameterDescription(
              name: 'interested',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .logRecommendationFeedback(
                    session,
                    params['postId'],
                    params['interested'],
                  ),
        ),
        'getPostsByHashtag': _is.MethodConnector(
          name: 'getPostsByHashtag',
          params: {
            'tag': _is.ParameterDescription(
              name: 'tag',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getPostsByHashtag(
                    session,
                    tag: params['tag'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getTrendingHashtags': _is.MethodConnector(
          name: 'getTrendingHashtags',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['post'] as _iysl4a9p.PostEndpoint)
                  .getTrendingHashtags(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['refreshJwtTokens'] = _is.EndpointConnector(
      name: 'refreshJwtTokens',
      endpoint: endpoints['refreshJwtTokens']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['refreshJwtTokens']
                          as _iaxm0zi1.RefreshJwtTokensEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['story'] = _is.EndpointConnector(
      name: 'story',
      endpoint: endpoints['story']!,
      methodConnectors: {
        'createStory': _is.MethodConnector(
          name: 'createStory',
          params: {
            'mediaUrl': _is.ParameterDescription(
              name: 'mediaUrl',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mediaType': _is.ParameterDescription(
              name: 'mediaType',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['story'] as _iiu4mi32.StoryEndpoint).createStory(
                    session,
                    mediaUrl: params['mediaUrl'],
                    mediaType: params['mediaType'],
                  ),
        ),
        'deleteStory': _is.MethodConnector(
          name: 'deleteStory',
          params: {
            'storyId': _is.ParameterDescription(
              name: 'storyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['story'] as _iiu4mi32.StoryEndpoint).deleteStory(
                    session,
                    params['storyId'],
                  ),
        ),
        'getActiveStories': _is.MethodConnector(
          name: 'getActiveStories',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['story'] as _iiu4mi32.StoryEndpoint)
                  .getActiveStories(session),
        ),
        'getUploadDescription': _is.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['story'] as _iiu4mi32.StoryEndpoint)
                  .getUploadDescription(
                    session,
                    params['path'],
                  ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['story'] as _iiu4mi32.StoryEndpoint).verifyUpload(
                    session,
                    params['path'],
                  ),
        ),
      },
    );
    connectors['userPreference'] = _is.EndpointConnector(
      name: 'userPreference',
      endpoint: endpoints['userPreference']!,
      methodConnectors: {
        'getAvailableCategories': _is.MethodConnector(
          name: 'getAvailableCategories',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .getAvailableCategories(session),
        ),
        'saveUserPreferences': _is.MethodConnector(
          name: 'saveUserPreferences',
          params: {
            'categories': _is.ParameterDescription(
              name: 'categories',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .saveUserPreferences(
                        session,
                        params['categories'],
                      ),
        ),
        'getUserPreferences': _is.MethodConnector(
          name: 'getUserPreferences',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .getUserPreferences(session),
        ),
        'getTrendingByCategory': _is.MethodConnector(
          name: 'getTrendingByCategory',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .getTrendingByCategory(
                        session,
                        category: params['category'],
                        limit: params['limit'],
                      ),
        ),
        'getTrendingFeed': _is.MethodConnector(
          name: 'getTrendingFeed',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .getTrendingFeed(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getPersonalizedFeed': _is.MethodConnector(
          name: 'getPersonalizedFeed',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userPreference']
                          as _i3sl96h6.UserPreferenceEndpoint)
                      .getPersonalizedFeed(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
      },
    );
    connectors['userProfileEdit'] = _is.EndpointConnector(
      name: 'userProfileEdit',
      endpoint: endpoints['userProfileEdit']!,
      methodConnectors: {
        'removeUserImage': _is.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iko41amg.UserProfileEditEndpoint)
                      .removeUserImage(session),
        ),
        'setUserImage': _is.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _is.ParameterDescription(
              name: 'image',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iko41amg.UserProfileEditEndpoint)
                      .setUserImage(
                        session,
                        params['image'],
                      ),
        ),
        'changeUserName': _is.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iko41amg.UserProfileEditEndpoint)
                      .changeUserName(
                        session,
                        params['userName'],
                      ),
        ),
        'changeFullName': _is.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iko41amg.UserProfileEditEndpoint)
                      .changeFullName(
                        session,
                        params['fullName'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iko41amg.UserProfileEditEndpoint)
                      .get(session),
        ),
      },
    );
    connectors['userRegistration'] = _is.EndpointConnector(
      name: 'userRegistration',
      endpoint: endpoints['userRegistration']!,
      methodConnectors: {
        'isRegistrationComplete': _is.MethodConnector(
          name: 'isRegistrationComplete',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .isRegistrationComplete(session),
        ),
        'submitRegistration': _is.MethodConnector(
          name: 'submitRegistration',
          params: {
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'surname': _is.ParameterDescription(
              name: 'surname',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'middleName': _is.ParameterDescription(
              name: 'middleName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'dateOfBirth': _is.ParameterDescription(
              name: 'dateOfBirth',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'sex': _is.ParameterDescription(
              name: 'sex',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'occupation': _is.ParameterDescription(
              name: 'occupation',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'website': _is.ParameterDescription(
              name: 'website',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .submitRegistration(
                        session,
                        firstName: params['firstName'],
                        surname: params['surname'],
                        middleName: params['middleName'],
                        username: params['username'],
                        dateOfBirth: params['dateOfBirth'],
                        sex: params['sex'],
                        occupation: params['occupation'],
                        location: params['location'],
                        website: params['website'],
                      ),
        ),
        'deleteAccount': _is.MethodConnector(
          name: 'deleteAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .deleteAccount(session),
        ),
        'getUserInfo': _is.MethodConnector(
          name: 'getUserInfo',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .getUserInfo(
                        session,
                        params['userId'],
                      ),
        ),
        'updateBio': _is.MethodConnector(
          name: 'updateBio',
          params: {
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .updateBio(
                        session,
                        params['bio'],
                      ),
        ),
        'updateBackgroundUrl': _is.MethodConnector(
          name: 'updateBackgroundUrl',
          params: {
            'backgroundUrl': _is.ParameterDescription(
              name: 'backgroundUrl',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .updateBackgroundUrl(
                        session,
                        params['backgroundUrl'],
                      ),
        ),
        'updateProfileImageUrl': _is.MethodConnector(
          name: 'updateProfileImageUrl',
          params: {
            'profileImageUrl': _is.ParameterDescription(
              name: 'profileImageUrl',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .updateProfileImageUrl(
                        session,
                        params['profileImageUrl'],
                      ),
        ),
        'getProfilePhotoHistory': _is.MethodConnector(
          name: 'getProfilePhotoHistory',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .getProfilePhotoHistory(
                        session,
                        params['userId'],
                      ),
        ),
        'deleteProfilePhoto': _is.MethodConnector(
          name: 'deleteProfilePhoto',
          params: {
            'photoId': _is.ParameterDescription(
              name: 'photoId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .deleteProfilePhoto(
                        session,
                        params['photoId'],
                      ),
        ),
        'getAllUsers': _is.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .getAllUsers(session),
        ),
        'searchUsers': _is.MethodConnector(
          name: 'searchUsers',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .searchUsers(
                        session,
                        params['query'],
                      ),
        ),
        'getUploadDescription': _is.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .getUploadDescription(
                        session,
                        params['path'],
                      ),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'surname': _is.ParameterDescription(
              name: 'surname',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'occupation': _is.ParameterDescription(
              name: 'occupation',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'website': _is.ParameterDescription(
              name: 'website',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'isLocationPublic': _is.ParameterDescription(
              name: 'isLocationPublic',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'isDobPublic': _is.ParameterDescription(
              name: 'isDobPublic',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'dateOfBirth': _is.ParameterDescription(
              name: 'dateOfBirth',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .updateProfile(
                        session,
                        firstName: params['firstName'],
                        surname: params['surname'],
                        bio: params['bio'],
                        occupation: params['occupation'],
                        website: params['website'],
                        location: params['location'],
                        isLocationPublic: params['isLocationPublic'],
                        isDobPublic: params['isDobPublic'],
                        dateOfBirth: params['dateOfBirth'],
                      ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userRegistration']
                          as _iyqeg5ab.UserRegistrationEndpoint)
                      .verifyUpload(
                        session,
                        params['path'],
                      ),
        ),
      },
    );
    connectors['voiceRecording'] = _is.EndpointConnector(
      name: 'voiceRecording',
      endpoint: endpoints['voiceRecording']!,
      methodConnectors: {
        'getUploadDescription': _is.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .getUploadDescription(
                        session,
                        params['path'],
                      ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .verifyUpload(
                        session,
                        params['path'],
                      ),
        ),
        'completeVoiceRecording': _is.MethodConnector(
          name: 'completeVoiceRecording',
          params: {
            'callRoomId': _is.ParameterDescription(
              name: 'callRoomId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'toUserId': _is.ParameterDescription(
              name: 'toUserId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'recordingPath': _is.ParameterDescription(
              name: 'recordingPath',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'durationMs': _is.ParameterDescription(
              name: 'durationMs',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .completeVoiceRecording(
                        session,
                        callRoomId: params['callRoomId'],
                        toUserId: params['toUserId'],
                        recordingPath: params['recordingPath'],
                        durationMs: params['durationMs'],
                      ),
        ),
        'getUserVoiceRecordings': _is.MethodConnector(
          name: 'getUserVoiceRecordings',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .getUserVoiceRecordings(session),
        ),
        'getCallVoiceRecordings': _is.MethodConnector(
          name: 'getCallVoiceRecordings',
          params: {
            'callRoomId': _is.ParameterDescription(
              name: 'callRoomId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .getCallVoiceRecordings(
                        session,
                        params['callRoomId'],
                      ),
        ),
        'deleteVoiceRecording': _is.MethodConnector(
          name: 'deleteVoiceRecording',
          params: {
            'recordingId': _is.ParameterDescription(
              name: 'recordingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceRecording']
                          as _ihbrzkxx.VoiceRecordingEndpoint)
                      .deleteVoiceRecording(
                        session,
                        params['recordingId'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
