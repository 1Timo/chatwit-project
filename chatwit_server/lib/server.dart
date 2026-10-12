import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage_s3/serverpod_cloud_storage_s3.dart'
    as s3;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/services/storage_config.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

Future<void> run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Initialize auth services BEFORE pod.start()
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfig(
        refreshTokenHashPepper: pod.getPassword(
          'jwtRefreshTokenHashPepper',
        )!,
        algorithm: JwtAlgorithm.hmacSha512(
          SecretKey(pod.getPassword('jwtHmacSha512PrivateKey')!),
        ),
      ),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
      GoogleIdpConfig(
        clientSecret: GoogleClientSecret.fromJsonString(
          pod.getPassword('googleClientSecret')!,
        ),
      ),
    ],
    // ✅ Handle post-auth user setup if needed
    authUsersConfig: AuthUsersConfig(
      onAfterAuthUserCreated: (session, authUser, {required transaction}) async {
        // Serverpod Auth automatically creates a UserInfo row.
        // We will create the full UserRegistration record later in the registration screen.
        session.log(
          'New auth user created: ${authUser.id}',
          level: LogLevel.info,
        );
      },
    ),
  );

  // Initialize storage config from environment variables
  final storageConfig = StorageConfig.fromEnvironment();

  pod.addCloudStorage(
    s3.S3CloudStorage(
      serverpod: pod,
      storageId: 'public',
      public: true,
      region: storageConfig.region,
      bucket: storageConfig.bucket,
    ),
  );

  await pod.start();

  // Web server routes
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }
}

String _envRequired(String key) {
  final value = Platform.environment[key];
  if (value == null || value.trim().isEmpty) {
    throw StateError('Missing required environment variable: $key');
  }
  return value;
}

Future<void> _sendVerificationEmail(
  Session session, {
  required String email,
  required String subject,
  required String text,
}) async {
  final apiKey = session.passwords['sendgridApiKey'];
  if (apiKey == null || apiKey.trim().isEmpty) {
    throw StateError('Missing required password: sendgridApiKey');
  }

  try {
    final response = await http
        .post(
          Uri.https('api.sendgrid.com', '/v3/mail/send'),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'personalizations': [
              {
                'to': [
                  {'email': email},
                ],
              },
            ],
            'from': {
              'email': _envRequired('SMTP_FROM_EMAIL'),
              'name': 'ChatWit',
            },
            'subject': subject,
            'content': [
              {'type': 'text/plain', 'value': text},
            ],
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 202) {
      throw StateError(
        'SendGrid rejected the email (HTTP ${response.statusCode}): '
        '${response.body}',
      );
    }

    session.log('Verification email sent to $email', level: LogLevel.info);
  } catch (error, stackTrace) {
    session.log(
      'Failed to send verification email to $email: $error',
      level: LogLevel.error,
    );
    session.log(stackTrace.toString(), level: LogLevel.error);
    rethrow;
  }
}

Future<void> _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  await _sendVerificationEmail(
    session,
    email: email,
    subject: 'Verify your email',
    text: 'Your verification code is: $verificationCode',
  );
}

Future<void> _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  await _sendVerificationEmail(
    session,
    email: email,
    subject: 'Reset your password',
    text: 'Your password reset code is: $verificationCode',
  );
}
