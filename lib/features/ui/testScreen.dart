import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget{
  String url;
  TestScreen(this.url);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(body: Center(child: Text(url??'null'),),);
  }
}