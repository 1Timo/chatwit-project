import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as loc;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatwit_flutter/firebase_options.dart';
import 'package:chatwit_flutter/core/notification_service.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:chatwit_flutter/screens/login_screen.dart';
import 'package:chatwit_flutter/screens/feed_screen.dart';
import 'package:chatwit_flutter/screens/create_post_screen.dart';
import 'package:chatwit_flutter/screens/registration_screen.dart';
import 'package:chatwit_flutter/screens/signup_screen.dart';
import 'package:chatwit_flutter/screens/settings/user_profile_edit_screen.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/google_auth_config.dart';
import 'package:chatwit_flutter/core/server_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client = Client(ServerUrl.baseUri.toString())
    ..connectivityMonitor = FlutterConnectivityMonitor();
  authManager = FlutterAuthSessionManager(
    caller: client.modules.serverpod_auth_core,
  );
  client.authKeyProvider = authManager;

  if (googleAndroidClientId.isEmpty || googleServerClientId.isEmpty) {
    googleSignInConfigurationError =
        'Google Sign-In is not configured for this build.';
  } else {
    // Configure Serverpod before the login screen can be tapped.
    try {
      await authManager.initializeGoogleSignIn(
        clientId: googleAndroidClientId,
        serverClientId: googleServerClientId,
      );
    } catch (e) {
      googleSignInConfigurationError = 'Google Sign-In initialization failed.';
      debugPrint('Google Sign-In initialization failed: $e');
    }
  }

  runApp(const ProviderScope(child: ChatWitApp()));
  unawaited(_initializeServices());
}

Future<void> _initializeServices() async {
  // Initialize Hive for Drafts
  try {
    await Hive.initFlutter();
    await Hive.openBox('post_drafts');
  } catch (e) {
    debugPrint('Hive initialization failed: $e');
  }

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await NotificationService.initialize();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  try {
    await authManager.initialize().timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Auth initialization timed out or failed: $e');
  }
}

class ChatWitApp extends StatelessWidget {
  const ChatWitApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF1F2937);
    const charcoal = Color(0xFF374151);
    const muted = Color(0xFF6B7280);
    const divider = Color(0xFFE5E7EB);

    return MaterialApp(
      title: 'Chatwit',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: charcoal,
          onPrimary: Colors.white,
          secondary: muted,
          onSecondary: Colors.white,
          error: Color(0xFFB42318),
          onError: Colors.white,
          surface: Colors.white,
          onSurface: ink,
          outline: Color(0xFFD1D5DB),
          outlineVariant: divider,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: ink,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: Border(bottom: BorderSide(color: divider)),
        ),
        dividerTheme: const DividerThemeData(
          color: divider,
          thickness: 1,
          space: 1,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: muted,
          textColor: ink,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: charcoal,
          unselectedItemColor: muted,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: charcoal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: charcoal),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: divider),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF9E9E9E),
        ),
      ),
      localizationsDelegates: [
        loc.GlobalMaterialLocalizations.delegate,
        loc.GlobalWidgetsLocalizations.delegate,
        loc.GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: const AuthGate(),
      routes: {
        '/feed': (context) => const FeedScreen(),
        '/create-post': (context) => const PostScreen(),
        '/edit-profile': (context) => const UserProfileEditScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Future<bool>? _registrationCheck;
  bool _deviceTokenRegistrationStarted = false;

  @override
  void initState() {
    super.initState();
    authManager.authInfoListenable.addListener(_onAuthStateChanged);
    _updateRegistrationCheck();
  }

  @override
  void dispose() {
    authManager.authInfoListenable.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    _updateRegistrationCheck();
    setState(() {});
  }

  void _updateRegistrationCheck() {
    if (authManager.authInfo == null) {
      _registrationCheck = null;
      _deviceTokenRegistrationStarted = false;
      return;
    }

    _registrationCheck = client.userRegistration
        .isRegistrationComplete()
        .timeout(const Duration(seconds: 10));
  }

  void _registerDeviceToken() {
    if (_deviceTokenRegistrationStarted) return;
    _deviceTokenRegistrationStarted = true;

    final platform = Theme.of(context).platform;
    NotificationService.getDeviceToken()
        .then((token) {
          if (token != null) {
            return client.notification.registerDeviceToken(
              token,
              platform == TargetPlatform.iOS ? 'ios' : 'android',
            );
          }
        })
        .catchError((error) {
          debugPrint('Device token registration failed: $error');
        });
  }

  @override
  Widget build(BuildContext context) {
    final authInfo = authManager.authInfo;

    if (authInfo == null) {
      return const LoginScreen();
    }

    return FutureBuilder<bool>(
      future: _registrationCheck,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // If registration check fails, we might still be logged in
          // but the server call failed. Show error or retry.
          return Scaffold(
            body: Center(child: Text("Connection Error: ${snapshot.error}")),
          );
        } else {
          final isRegistered = snapshot.data ?? false;

          if (isRegistered) {
            _registerDeviceToken();
            return const FeedScreen();
          } else {
            return const RegistrationScreen();
          }
        }
      },
    );
  }
}
