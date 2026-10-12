import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatwit_flutter/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final StreamController<RemoteMessage> _messagesController =
      StreamController<RemoteMessage>.broadcast();
  static bool _initialized = false;

  static Stream<RemoteMessage> get messages => _messagesController.stream;

  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    // Set up foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Initialise Local Notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _localNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    // Create Notification Channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'chatwit_high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    _setupMessageListeners();
  }

  static void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _messagesController.add(message);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'chatwit_high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  static bool _isRequestingPermission = false;

  static Future<bool> requestPermissions() async {
    if (_isRequestingPermission) return false;
    _isRequestingPermission = true;

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } finally {
      _isRequestingPermission = false;
    }
  }

  static Future<String?> getDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}

// Global background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
