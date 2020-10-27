
import 'package:beauty/value/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ContainerCart extends StatelessWidget {
 final int height ;
 final Widget child ;
 ContainerCart({this.height, this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(height),
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(20),
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15),
      ),
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(15),
          horizontal: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: sCardShadow,
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
