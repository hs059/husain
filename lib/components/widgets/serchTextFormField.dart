
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    Key key,
    this.validator, this.onSaved,
  }) ;

  final Function validator;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration:   BoxDecoration(
        color: Color(0xffF5F5F5),

        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
      ),
      child: TextFormField(
        validator: (value) => validator(value),
        onSaved: (newValue) => onSaved(newValue),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          icon: GestureDetector(child: Icon( Icons.search,color: kGrayText,),
            onTap: () {
            },
          )  ,
          hintText: 'Search in 3beauty',
          hintStyle:kSearchHint,
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kGrayLight,
                width: ScreenUtil().setWidth(2),
              )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: ScreenUtil().setWidth(2),
              )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kGrayLight,
                width: ScreenUtil().setWidth(0.5),
              )),
        ),
      ),
    );
  }
}
