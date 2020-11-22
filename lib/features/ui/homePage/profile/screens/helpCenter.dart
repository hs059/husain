import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HelpCenter extends StatelessWidget {
  String phone = '0546873286';
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
                    onTap: () =>  UrlLauncher.launch('mailto:$email'),
                    leading: SvgPicture.asset(
                      'assets/svg/emailBtn.svg',
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      'راسلنا',
                      style: kProfile,
                    ),
                  ),
                  MyDivider(),
                  ListTile(
                    onTap:() => UrlLauncher.launch('tel:+${phone.toString()}'),

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
                ],
              ),
            ),
          )),
    );
  }
}
