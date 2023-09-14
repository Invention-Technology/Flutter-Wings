import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../../immutable/main.wings.dart';
import 'notification.model.dart';

///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class WingsNotification {
  static WingsNotification? _instance;

  factory WingsNotification() {
    _instance ??= WingsNotification._();

    return _instance!;
  }

  WingsNotification._();

  static Future<void> init() async {
    _instance = WingsNotification();

    await WingsNotification()._init();
  }

  Future<void> _init() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      // 'resource://drawable/ic_launcher',
      'resource://drawable/splash',
      // null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications',
          importance: NotificationImportance.Max,
          playSound: true,
          criticalAlerts: true,
          groupKey: "1",
        ),
      ],
      debug: true,
    );
  }

  static Future<void> clear() async {
    AwesomeNotifications().dispose();
    AwesomeNotifications().cancelAll();
  }

  /// Use this method to detect when a new notification or a schedule is created

  bool listening = false;

  Future<void> createNotificationChat(Map<String, dynamic> message) async {
    final data = WingsNotificationModel().fromJson(message);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueID(),
          // -1 is replaced by a random number
          channelKey: 'high_importance_channel',
          title: data.title,
          body: data.body,
          groupKey: "1",
          displayOnBackground: true,
          displayOnForeground: true,
          payload: data.toShowNotification()),
    );

    _onEventReceived(data);
  }

  int createUniqueID({int maxValue = 9999}) {
    Random random = Random();
    return random.nextInt(maxValue);
  }

  void _onEventReceived(WingsNotificationModel model) {
    for (var ele in model.refreshPages) {
      var refreshController = Wings.find(tag: ele.toString());

      if (refreshController != null) {
        refreshController.refresh();
      }
    }

    if (model.closePage != null && model.closePage.toString().isNotEmpty) {
      var closeController = Wings.find(tag: model.closePage.toString());

      if (closeController != null) {
        if (model.closePage == 'CompleteOrderController') {
          Wings.pop();
          Wings.pop();
        }
      } else if (model.closePage == 'CompleteOrderController' &&
          Wings.find(tag: 'OrderDetailsController') != null) {
        Wings.pop();
      }
    }
  }
}
