import 'package:beauty/components/animate_do.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/services/location.dart';
import 'package:beauty/value/style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'homePage/homePage.dart';

class Splash extends StatefulWidget {
  final Widget screen;

  Splash(this.screen);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  _registerOnFirebase()async {
    _firebaseMessaging.subscribeToTopic('all');
    String token = await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic(token);
    print(token);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context,listen: false).getOnbourding();
    _registerOnFirebase();
    getMessage();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('flutter_devs');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android:    initializationSettingsAndroid,iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

  }
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return HomePage();
    }));
  }
  showNotification(String title,String body) async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android:android, iOS:iOS);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platform,
        payload: 'Welcome to the Local Notification demo ');
  }
  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('received message');
        showNotification(message['notification']['title'],message['notification']['body']);
        print(message);
        setState(() {});
      }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');

      setState(() {});
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch  $message');
      setState(() {});
    },

    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<ConnectivityStatus>(stream: ConnectivityService.connectionStatusController.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData){

                  if( snapshot.data ==ConnectivityStatus.WiFi || snapshot.data ==ConnectivityStatus.Cellular  ){
                    Provider.of<AuthProvider>(context, listen: false).getLogin();
                    Provider.of<AuthProvider>(context, listen: false).getLoginSocial();
                    Provider.of<ApiProvider>(context, listen: false).getSlider();
                    Provider.of<ApiProvider>(context, listen: false).getSection();
                    Provider.of<ApiProvider>(context, listen: false).getBrand();
                    Location.location.getCurrentLocation();
                    Provider.of<ApiProvider>(context,listen: false).getCategory();
                    Provider.of<ApiProvider>(context,listen: false).getPrivacyPolicy();
                    Provider.of<ApiProvider>(context,listen: false).getAllOrder();
                    Provider.of<DBProvider>(context,listen: false).setAllProducts();
                    Provider.of<ApiProvider>(context,listen: false).getAllAddress();
                    Provider.of<ApiProvider>(context,listen: false).getAllFav();

                    var delay = Duration(seconds: 4);
                    Future.delayed(delay, () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return widget.screen;
                        },
                      ));
                    });
                    return  JelloIn(
                      duration : Duration(milliseconds: 1500),
                      animate: true,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/beauty0.svg',
                          height: ScreenUtil().setHeight(350),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }else{
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/beauty0.svg',
                            height: ScreenUtil().setHeight(350),
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'لا يوجد اتصال بالانترنت',
                            style:
                            kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                          ),

                        ],
                      ),
                    );
                  }
                }
                else{
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/beauty0.svg',
                          height: ScreenUtil().setHeight(350),
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'لا يوجد اتصال بالانترنت',
                          style:
                          kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                        ),

                      ],
                    ),
                  );
                }

              }
          )

      ),
    );
  }
}