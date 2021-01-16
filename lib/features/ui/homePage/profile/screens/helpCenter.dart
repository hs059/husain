import 'dart:io';

import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatelessWidget {
  String phone = '+9660503214127';
  String email = 'info@3beauty.net';

 @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBarCart(title: 'الدعم و المساندة'),
          body: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
            child: ContainerCart(
              // height: 160,
              child: Wrap(
                children: [
                  ListTile(
                    onTap: () => launch('mailto:$email'),
                    leading: SvgPicture.asset(
                      'assets/svg/emailBtn.svg',
                      fit: BoxFit.contain,
                      height: ScreenUtil().setHeight(35),
                      width: ScreenUtil().setWidth(35),
                    ),
                    title: Text(
                      'راسلنا',
                      style: kProfile,
                    ),
                  ),
                  MyDivider(),
                  ListTile(
                    onTap: () => launch('tel:+${phone.toString()}'),
                    leading: Image.asset(
                      'assets/images/phoneBtn.png',
                      fit: BoxFit.contain,
                      height: ScreenUtil().setHeight(35),
                      width: ScreenUtil().setWidth(35),
                    ),
                    title: Text(
                      'تواصل معنا',
                      style: kProfile,
                    ),
                  ),
                  MyDivider(),
                  ListTile(
                    onTap: () => launch("https://wa.me/$phone?text="),
                    leading: Container(
                      height: ScreenUtil().setHeight(35),
                      width: ScreenUtil().setWidth(35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kPinkLight,
                      ),
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      ' تواصل معنا عبر الواتس اب',
                      style: kProfile,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
