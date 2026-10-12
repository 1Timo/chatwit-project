import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> registerDeviceToken(
    Session session,
    String token,
    String deviceType,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return;

    final userId = authInfo.userIdentifier;

    final existing = await DeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );

    if (existing != null) {
      if (existing.userId != userId) {
        existing.userId = userId;
        existing.createdAt = DateTime.now();
        await DeviceToken.db.updateRow(session, existing);
      }
    } else {
      final deviceToken = DeviceToken(
        userId: userId,
        token: token,
        deviceType: deviceType,
        createdAt: DateTime.now(),
      );
      await DeviceToken.db.insertRow(session, deviceToken);
    }
  }

  Future<void> unregisterDeviceToken(Session session, String token) async {
    await DeviceToken.db.deleteWhere(
      session,
      where: (t) => t.token.equals(token),
    );
  }

  /// Sends a real push notification through Firebase Cloud Messaging HTTP v1.
  Future<void> sendPushNotification(
    Session session,
    String userId,
    String title,
    String body,
  ) async {
    final tokens = await DeviceToken.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (tokens.isEmpty) {
      session.log(
        'No registered devices found for user $userId.',
        level: LogLevel.info,
      );
      return;
    }

    final serviceAccountJson = session.serverpod.getPassword(
      'firebaseServiceAccount',
    );
    if (serviceAccountJson == null || serviceAccountJson.trim().isEmpty) {
      session.log(
        'Firebase service account is not configured.',
        level: LogLevel.error,
      );
      return;
    }

    try {
      final serviceAccountMap =
          jsonDecode(serviceAccountJson) as Map<String, dynamic>;
      final serviceAccount = ServiceAccountCredentials.fromJson(
        serviceAccountMap,
      );
      final authClient = await clientViaServiceAccount(
        serviceAccount,
        ['https://www.googleapis.com/auth/firebase.messaging'],
      );
      try {
        final projectId = serviceAccountMap['project_id'] as String?;
        if (projectId == null || projectId.isEmpty) {
          session.log(
            'Firebase service account has no project_id.',
            level: LogLevel.error,
          );
          return;
        }

        for (var deviceToken in tokens) {
          final response = await http.post(
            Uri.parse(
              'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer ${authClient.credentials.accessToken.data}',
            },
            body: jsonEncode({
              'message': {
                'token': deviceToken.token,
                'notification': {'title': title, 'body': body},
                'data': {
                  'type': 'chat',
                  'senderId': session.authenticated?.userIdentifier ?? '',
                },
              },
            }),
          );

          if (response.statusCode == 200) {
            session.log(
              'Push notification sent successfully to token: ${deviceToken.token}',
            );
          } else {
            session.log(
              'FCM Error (${response.statusCode}): ${response.body}',
              level: LogLevel.error,
            );
          }
        }
      } finally {
        authClient.close();
      }
    } catch (e) {
      session.log(
        'Failed to send push notification: $e',
        level: LogLevel.error,
      );
    }
  }
}
