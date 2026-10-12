import 'package:chatwit_client/chatwit_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

export 'package:chatwit_client/chatwit_client.dart';
export 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    hide Protocol, EndpointRefreshJwtTokens;

// Global client and auth manager
late Client client;
late FlutterAuthSessionManager authManager;
