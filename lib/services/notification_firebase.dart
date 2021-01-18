import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationFirebaseHelper {
  BuildContext context;

  NotificationFirebaseHelper(BuildContext context);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  registerOnFirebase() async {
    _firebaseMessaging.subscribeToTopic('all');
    String token = await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic(token);
    print(token);
  }



  showNotification(String title, String body) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_devs');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: 'Welcome to the Local Notification demo ');
  }
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductMScreen();
    }));
  }
  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('received message');
        showNotification(
            message['notification']['title'], message['notification']['body']);
        Logger().d(message);
      },
      onResume: (Map<String, dynamic> message) async {
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
    );
  }
}
