import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/base/base_bottom_sheet.dart';
import 'package:kai_chat/core/base/base_button.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:kai_chat/core/routes/routing.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:kai_chat/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

// Top Level so Dart runtime can access
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final SendPort? sendPort =
      IsolateNameServer.lookupPortByName('background_message_port');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Handling a background message ${message.messageId}');
  debugPrint('Background message ${message.toMap()}');
  sendPort?.send(message.toMap());
}

class FirebaseMessagingService extends GetxService {
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  // Initialize Local Notification
  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          // Update on Android res drawable file
          android: AndroidInitializationSettings("app_logo")),
      onDidReceiveNotificationResponse: (details) {
        _handleRedirection(jsonDecode(details.payload ?? "{}"));
      },
    );
    // Create an Android Notification Channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Update iOS foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  // Show Local Notification in app
  void showFlutterNotification(RemoteMessage message) {
    debugPrint("Show Flutter notification ${message.toMap()}");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        // TODO: Remove test data
        payload: '{"title":"Test","body":"Test","extra":{"id":"123123"}}',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications",
            channelDescription:
                "This channel is used for important notifications.",
            importance: Importance.max,
            priority: Priority.high,
            icon: 'app_logo',
          ),
        ),
      );
    }
  }

  // Handle ontap on firebase notification
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from a terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // Handle the initial message
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Handle background interaction via Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // Handle ontap on local notification
  void _handleMessage(RemoteMessage message) {
    debugPrint("On click message, ${message.toMap()}");
    // TODO: Remove test data
    Map<String, dynamic>? payload =
        jsonDecode('{"title":"Test","body":"Test","extra":{"id":"123123"}}');
    _handleRedirection(payload);
  }

  void _handleRedirection(Map<String, dynamic>? data) {
    debugPrint("Redirection data ${data}");

    Get.toNamed(Routes.chat, arguments: data);
  }

  // Check Notification Permission for Android 13 above
  Future<bool> _isAllowNotification() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
    debugPrint(
        "Notification Setting ${settings.authorizationStatus} ${settings.criticalAlert}");
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      BaseBottomSheet.show(
          child: PopScope(
              canPop: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Push Notification is required for better user experience!",
                    style: MyTextStyle.l.bold,
                  ),
                  const Spacer(),
                  BaseButton(
                      text: "Go to setting",
                      fullWidth: true,
                      onClick: () {
                        openAppSettings();
                      })
                ],
              ).padding(const EdgeInsets.all(AppValues.double20))));
      return false;
    }
    return true;
  }

  // Register Isolate Receiver Port
  void setupIsolatePort() {
    final ReceivePort receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'background_message_port',
    );
    receivePort.listen((dynamic message) async {
      debugPrint(
          "Check flutter notification $isFlutterLocalNotificationsInitialized");
      await flutterLocalNotificationsPlugin.cancelAll();
      showFlutterNotification(RemoteMessage.fromMap(message));
    });
  }

  Future<void> init() async {
    if (await _isAllowNotification()) {
      // Initialize local notifications
      await setupFlutterNotifications();

      // Setup interaction handling
      await setupInteractedMessage();

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        debugPrint("FCM Token ${fcmToken}");
      }).onError((err) {});

      debugPrint(
          "FCM GET Token ${await FirebaseMessaging.instance.getToken()}");

      // Register the background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Setup Isolate Port to listen to top-level pragma changes
      setupIsolatePort();

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen(showFlutterNotification);
    }
  }
}
