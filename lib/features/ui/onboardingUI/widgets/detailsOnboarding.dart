

import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DetailsOnboarding extends StatelessWidget {
  final String image ,title , subTitle;
  DetailsOnboarding({this.image, this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(300),
          child: SvgPicture.asset(
              image,
              semanticsLabel: 'Acme Logo'
          ),
        ),

        // height: ScreenUtil().setHeight(300),
        // width: ScreenUtil().setWidth(300),
        SizedBox(height: ScreenUtil().setHeight(70),),

        Text(
          title,
          style: kTitleOnboarding,
        ),
        SizedBox(height: ScreenUtil().setHeight(20),),
        Text(
          subTitle,
          style: kSubTitleOnboarding,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
