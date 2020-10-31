import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// UiProvider uiProvider = Provider.of<UiProvider>(context);
// UiProvider uiProviderFalse = Provider.of<UiProvider>(context,listen: false);
SvgPicture svgPicture = SvgPicture.asset(
  'assets/svg/icon/categoryA.svg',
  fit: BoxFit.contain,
);

BoxDecoration boxDecorationImage = BoxDecoration(
  borderRadius: BorderRadius.circular(7),
  image: DecorationImage(
      image: AssetImage('assets/images/3beauty.png'), fit: BoxFit.cover),
);
SizedBox sizedBox = SizedBox(
  height: ScreenUtil().setHeight(20),
);

Widget a = Container(
  height: double.infinity,
  width: double.infinity,
  child: GridView.count(
    crossAxisCount: 2,
    primary: false,
    crossAxisSpacing: 10.0,
    childAspectRatio: 0.85,
    mainAxisSpacing: 10.0,
    shrinkWrap: true,
    children: [],
  ),
);

List<Icon> getStarsList(double rate, {double size = 18}) {
  var list = <Icon>[];
  list = List.generate(rate.floor(), (index) {
    return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
  });
  if (rate - rate.floor() > 0) {
    list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
  }
  list.addAll(
      List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
    return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
  }));
  return list;
}

Row row = Row(
  children: getStarsList(5),
);
SliverGridDelegateWithFixedCrossAxisCount gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 15.0,
childAspectRatio: 0.85,
mainAxisSpacing: 15.0,
);