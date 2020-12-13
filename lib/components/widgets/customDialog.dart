import 'dart:ui';

import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Function onTap ;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text,this.onTap}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(60),
            left: ScreenUtil().setWidth(15),
            right: ScreenUtil().setWidth(15),
            bottom: ScreenUtil().setHeight(15),
          ),
          margin: EdgeInsets.only(top:  ScreenUtil().setHeight(60)),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(blurRadius: 2, offset: Offset(0, 4), color: kBlack),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height:ScreenUtil().setHeight(15),),
              Text(widget.descriptions,style: TextStyle(fontSize: ScreenUtil().setSp(14)),textAlign: TextAlign.center,),
              SizedBox(height: ScreenUtil().setHeight(22),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button( onTap: (){
                    Navigator.of(context).pop();
                    widget.onTap();
                  },
                    text: widget.text,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(45),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Color(0xffDAA095),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'الغاء',
                          style: kBtnText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: ScreenUtil().setWidth(25),
          right: ScreenUtil().setWidth(25),
          child:Container(
            height: ScreenUtil().setHeight(95),
            width: ScreenUtil().setWidth(95),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: sCardShadow2,
                shape: BoxShape.circle,

                color: kPinkLight.withOpacity(0.8),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white,kPinkLight, kPinkDark,kBorder])
            ),
            child:SvgPicture.asset(
              'assets/svg/beauty0.svg',color:Colors.white,
              height: ScreenUtil().setHeight(95),
              width: ScreenUtil().setWidth(95),
            ),
          ),
        ),
      ],
    );
  }
}
