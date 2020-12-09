

import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';

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
            onTap: (){
              if (ConnectivityService.connectivityStatus ==
                  ConnectivityHStatus.online) {
            onTap();
              }else{
                Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
                  titleText:  Text(
                    'لا يوجد اتصال بالانترنت',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  messageText: Text(
                    'يرجى فحص الاتصال بالشبكة',
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
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