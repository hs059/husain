import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/profile/screens/profileScreen.dart';
import 'package:beauty/features/ui/homePage/screens/brands.dart';
import 'Category/Screens/category.dart';
import 'package:beauty/features/ui/homePage/screens/home.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart/screens/cartScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int bottomIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      bottomIndex = tabController.index;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              Home(),
              Category(),
              Cart(),
              Brands(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            height: ScreenUtil().setHeight(83),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 2, offset: Offset(-2, -2), color: Colors.grey[200])
            ]),
            //ToDo:svg icon
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                tabs: tabIconA.map((e) {
                  return Tab(
                    child: SvgPicture.asset(
                      bottomIndex == tabIconA.indexOf(e)
                          ? e
                          : tabIconI[tabIconA.indexOf(e)],
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().setWidth(45),
                    ),
                  );
                }).toList()
             ),
          ),
        ),
      ),
    );
  }


}
