


import 'package:beauty/features/ui/homePage/profile/screens/myOrder.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ListTileProfile extends StatelessWidget {
  final String image ;
  final String title ;
  final Widget route ;
  ListTileProfile({this.image, this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        image,
        fit: BoxFit.contain,
      ),
      title: Text(
        title,
        style: kProfile,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (ConnectivityService.connectivityStatus ==
            ConnectivityHStatus.online) {
          kNavigatorPush(context, route);

        }else{
          Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
            titleText:  Text(
              'لا يوجد اتصال بالانترنت',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            messageText: Text(
              'يرجى فحص الاتصال بالشبكة',
              textAlign: TextAlign.center,
            ),
          );
        }

      }

    );
  }
}
