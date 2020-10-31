
import 'package:beauty/value/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ContainerCart extends StatelessWidget {
 final Widget child ;
 ContainerCart({ this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
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
