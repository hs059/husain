import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class BrandProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '100% original',
              style: kDiscount,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            //ToDo:ShowProduct brand
            Text(
              'See more of the same brand',
              style: kSubProductTitle,
            ),
          ],
        ),
        Container(
          width: ScreenUtil().setWidth(125),
          child: Image.asset('assets/images/brand1.png'),
        ),
      ],
    );
  }
}
