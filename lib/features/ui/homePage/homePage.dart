import 'package:beauty/components/model/lineItems.dart';
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/db_client.dart';
import 'package:beauty/features/ui/homePage/profile/screens/profileScreen.dart';
import 'package:beauty/features/ui/homePage/screens/brands.dart';
import 'package:beauty/services/location.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
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
    tabControllerConstant = TabController(length: 4, vsync: this, initialIndex: 0);
    tabControllerConstant.addListener(() {
      bottomIndex = tabControllerConstant.index;
      setState(() {});
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  void dispose() {
    tabControllerConstant.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: onWillPop,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabControllerConstant,
            children: <Widget>[
              Home(),
              Category(),
              Cart(),
              // Brands(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            // height: ScreenUtil().setHeight(85),
            height: ScreenUtil().setHeight(70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
                color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 2, offset: Offset(-2, -2), color: Colors.grey[200])
            ]),
            child: TabBar(

                controller: tabControllerConstant,
                indicatorColor: Colors.transparent,
                tabs: tabIconA.map((e) {
                  return Tab(
                    child: SvgPicture.asset(
                      bottomIndex == tabIconA.indexOf(e)
                          ? e
                          : tabIconI[tabIconA.indexOf(e)],
                      // height: ScreenUtil().setHeight(18),
                      // width: ScreenUtil().setWidth(18),
                      height: ScreenUtil().setHeight(20),
                      width: ScreenUtil().setWidth(20),
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
