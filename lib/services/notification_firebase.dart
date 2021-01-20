import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/value/navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class NotificationFirebaseHelper {


  NotificationFirebaseHelper();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  registerOnFirebase() async {
    _firebaseMessaging.subscribeToTopic('all');
    String token = await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic(token);
    print(token);
  }



  showNotification(String title, String body,  BuildContext context) async {
    Future onSelectNotification(String id,) {
      Provider.of<ApiProvider>(context,listen: false).getProductDetailsNNNN( int.parse(id));
      kNavigatorPush(context, ProductMScreen());
    }
    var initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_devs');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification
    );
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  void getMessage(  BuildContext context ) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('received message');
        showNotification(
            message['notification']['title'], message['notification']['body'],context);
        Logger().d(message);
      },
      onResume: (Map<String, dynamic> message) async {
        kNavigatorPush(context, ProductMScreen());
        Logger().d('onResume');
        Logger().d(message);
        Logger().d(int.parse(message['data']['product_id']));
        Provider.of<ApiProvider>(context,listen: false).getProductDetailsNNNN( int.parse(message['data']['product_id']));

        Logger().d(message);

      },
      onLaunch: (Map<String, dynamic> message) async {
        Logger().d('onLaunch');
        Logger().d(message);
        Provider.of<ApiProvider>(context,listen: false).getProductDetailsSearch(
            int.parse(message['data']['product_id'])
            , context);

      },
    );
  }
}
