
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String text ;
  final Function onTap ;
  Button({@required this.text,@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

          onTap();

      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(45),
        padding: EdgeInsets.symmetric(horizontal:5),
        decoration: BoxDecoration(
          color: Color(0xffDAA095),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: kBtnText,
          ),
        ),
      ),
    );
  }
}
