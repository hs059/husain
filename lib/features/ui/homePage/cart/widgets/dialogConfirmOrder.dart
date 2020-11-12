

import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';


class DialogConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        child: Wrap(
          children: [
            TitleSubTitle(
              title: 'Order Success',
              subTitle:
              'Your order is being processed by the system, you can see the progress at',
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
              child: Button(text: 'Done', onTap: (){
                kNavigatorPushAndRemoveUntil(context, HomePage());
              }),
            )
          ],
        ),
      ),
    );
  }
}
