import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key key,
      this.hintText,
      this.password = false,
      this.validator,
      this.onSaved,
      this.iconData,
      this.type, this.textInputType = TextInputType.text,
      });

  final String hintText;
  final Function validator;
  final Function onSaved;
  final IconData iconData;
  final TextInputType textInputType;
  final bool password;
  Widget type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
      ),
      child: TextFormField(

        validator: (value) => validator(value),
        onSaved: (newValue) => onSaved(newValue),
        obscureText: password,
        cursorColor: Colors.grey,
        keyboardType:textInputType ,
        decoration: InputDecoration(
          icon: type,
          suffix: GestureDetector(
            child: Icon(iconData,color: Color(0xffEDF1F7),),

            onTap: () {
              Provider.of<UiProvider>(context, listen: false).fmToggleEye();
            },
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
            width: ScreenUtil().setWidth(2),
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
            width: ScreenUtil().setWidth(2),
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
            width: ScreenUtil().setWidth(0.5),
          )),
        ),
      ),
    );
  }
}
