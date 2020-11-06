

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'انقر مرة أخرى للمغادرة');
    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}

showToast(String title){

}

TabController tabController;



String baseUrl = 'https://3beauty.net/wp-json/beauty/v1/';
String regiserUrl = 'register';
String loginUrl = 'login';
String forget_password = 'forget_password';
String sign_out = 'sign_out';
String change_password = 'change_password';
String edit_profile = 'edit_profile';
String reset_password = 'reset_password';