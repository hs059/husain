

import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ProductDescription extends StatelessWidget {
  final String name ;
  final String description ;
  ProductDescription({this.name, this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: kSubTitleProduct,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: ScreenUtil().setWidth(250),
              ),
              child: Text(
                description,
                style: kReviews,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
          ],
        ),
      ),
    );
  }
}
