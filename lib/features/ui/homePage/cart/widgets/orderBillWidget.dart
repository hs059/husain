

import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class OrderBillWidget extends StatelessWidget {
  final String title ;
  final Widget subTitle ;
  OrderBillWidget({this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 title,
                  style: kGrayText33,
                ), subTitle
              ],
            ),
          ),

          MyDivider(),

        ],
      ),
    );
  }
}
