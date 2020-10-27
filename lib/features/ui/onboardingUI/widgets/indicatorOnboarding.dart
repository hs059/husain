import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class IndicatorOnboarding extends StatelessWidget {
  final int numPages, currentPage;

  IndicatorOnboarding({this.numPages, this.currentPage});

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // height: ScreenUtil().setHeight(10),
      // width: ScreenUtil().setWidth(10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActive ? Color(0xffDAA095) : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          border: Border.all(
            color: Color(0xffDAA095),
            width: ScreenUtil().setWidth(1),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }
}
