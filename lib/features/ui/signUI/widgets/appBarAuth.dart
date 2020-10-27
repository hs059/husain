import 'package:flutter/material.dart';

Widget appBarAuth(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back,
        color: Color(0xff121924),
      ),
    ),
  );
}
