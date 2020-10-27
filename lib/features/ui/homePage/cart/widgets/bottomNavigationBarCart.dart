

import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget bottomNavigationBarCart ({Function onTap ,Widget widget}){
  return Container(
    color: Colors.white,
    height: ScreenUtil().setHeight(82),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: ScreenUtil().setHeight(44),
          width: ScreenUtil().setWidth(345),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(45),
              decoration: BoxDecoration(
                color: Color(0xffDAA095),
                borderRadius: BorderRadius.circular(6),
              ),
              child: widget,
            ),
          ),
        ),
      ],
    ),
  );
}