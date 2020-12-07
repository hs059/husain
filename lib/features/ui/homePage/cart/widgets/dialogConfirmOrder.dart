

import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';


class DialogConfirmOrder extends StatelessWidget {
 final  Function onTap ;
 DialogConfirmOrder({this.onTap});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        child: Wrap(
          children: [
            TitleSubTitle(
              title: 'تم الطلب بنجاح',
              subTitle:
              ' تتم معالجة طلبك بواسطة النظام ، يمكنك رؤية الطلب و حالته في خانة طلباتي في صفحة معلومات المستخدم ',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            SvgPicture.asset(
              'assets/svg/endOrder.svg',
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Button(text: 'تأكيد الطلب', onTap: onTap),
            )
          ],
        ),
      ),
    );
  }
}
