

import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarCart({String title}){

return PreferredSize(
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kBorder,
          offset: Offset(0, 2.0),
          blurRadius: 4.0,
        )
      ]),
      child: AppBar(iconTheme: IconThemeData(color: Color(0xff121924)),
        backgroundColor: Colors.white, brightness: Brightness.light,
        title: Text(
          title,
          style: kSubCategoryText.copyWith(
            color: kBlack,
          ),
        ),
        elevation: 0.0,
      ),

    ),
    preferredSize: Size.fromHeight(kToolbarHeight),
  );
}