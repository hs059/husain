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
import 'package:beauty/services/sp_helper.dart';
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
    tabControllerConstant = TabController(length: 5, vsync: this, initialIndex: 0);
    tabControllerConstant.addListener(() {
      bottomIndex = tabControllerConstant.index;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
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
              child: TabBar(onTap: (value) {
                if(value == 4){
                  Provider.of<AuthProvider>(context,listen: false).showProfile();
                }
              },
                  controller: tabControllerConstant,
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
      ),
    );
  }


}
