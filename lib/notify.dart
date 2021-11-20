import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: must_be_immutable
class LocalNotifications extends StatefulWidget {
  String title;

  LocalNotifications({this.title});

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    var androidSettings = AndroidInitializationSettings('app_icon');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  showSimpleNotification() async {
    var androidDetails = AndroidNotificationDetails('id', 'channel ',
        priority: Priority.high, importance: Importance.max);
    var iOSDetails = IOSNotificationDetails();
    var platformDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification',
        'Flutter Simple Notification', platformDetails,
        payload: 'Destination Screen (Simple Notification)');
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
