import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../features/auth/controller/auth.dart';
import 'notification.wings.dart';
import 'topics.enum.dart';

class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static PushNotificationService? _instance;

  factory PushNotificationService() {
    _instance ??= PushNotificationService._();

    return _instance!;
  }

  PushNotificationService._();

  String get userTopic {
    if (!Auth().loggedIn) return Topics.guests.name;

    return Topics.users.name;
  }

  static Future<void> init() async {
    // TODO: Add firebase options file call here
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);

    await PushNotificationService()._init();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _init() async {
    await setupInteractedMessage();

    await subscribe();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    String? token = await getToken();

    if (token != null) {
      // TODO: Update FCM Token
      // Auth().updateFcmToken(token);
    }
    // log(token.toString());

    // this update refresh token FCM
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      // TODO: Update FCM TOKEN
      // Auth().updateFcmToken(fcmToken);
    });

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        sound: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false);

    if (initialMessage != null) {}
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await registerNotificationListeners();

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (ex) {
      return null;
    }
  }

  registerNotificationListeners() async {
    // this listen Notification message [notification or data]
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("${message.data}", name: "RemoteMessage");

      WingsNotification().createNotificationChat(message.data);
    });
  }

  Future<void> subscribe({Topics? topics}) async {
    String topic = topics != null ? topics.name : userTopic;

    messaging.subscribeToTopic(topic).whenComplete(() {});
  }

  Future<void> unsubscribe({Topics? topics, bool loggedIn = false}) async {
    if (loggedIn) {
      messaging.unsubscribeFromTopic(Topics.users.name).whenComplete(() {});
    } else {
      String topic = topics != null ? topics.name : userTopic;
      messaging.unsubscribeFromTopic(topic).whenComplete(() {});
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call initializeApp before using other Firebase services.
    // TODO: Add firebase options file call here
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);

    await WingsNotification.init();

    WingsNotification().createNotificationChat(message.data);
  }
}
