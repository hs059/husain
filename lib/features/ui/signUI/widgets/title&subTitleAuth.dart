


import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TitleSubTitle extends StatelessWidget {
  final String title ;
  final String subTitle ;
   TitleSubTitle({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: kTitleSign,
          textAlign: TextAlign.center,

        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        Text(
          subTitle,
          style: kSubTitleSign,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
