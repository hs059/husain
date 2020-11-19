

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

TabController tabControllerConstant;


String currency ='رس' ;

String baseUrl = 'https://3beauty.net/wp-json/beauty/v1/';
String regiserUrl = 'register';
String loginUrl = 'login';
String forget_password = 'forget_password';
String sign_out = 'sign_out';
String change_password = 'change_password';
String reset_password = 'reset_password';
String verify_registration = 'verify_registration';
String get_categories = 'get_categories';
String get_sub_categories = 'get_sub_categories?main_cat_id=';
String get_latest_products = 'get_latest_products';
String get_product_for_custom_category = 'get_product_for_custom_category';
String get_latest_brands = 'get_latest_brands';
String get_product_like = 'get_product_like';
String show_profile = 'show_profile';
String edit_profile = 'edit_profile';
String get_front_page_slides = 'get_front_page_slides';
String get_privacy_policy = 'get_privacy_policy';
String create_order = 'create_order';
String get_orders = 'get_orders';
String add_address = 'add_address';
String get_address = 'get_address';
String remove_address = 'remove_address';

List<String> getSliderIndex = [
  'get_first_slider',
  'get_second_slider',
  'get_third_slider',
];