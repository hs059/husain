import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/profile/screens/Language.dart';
import 'package:beauty/features/ui/homePage/profile/screens/aboutUs.dart';
import 'package:beauty/features/ui/homePage/profile/screens/accountInformations.dart';
import 'package:beauty/features/ui/homePage/profile/screens/helpCenter.dart';
import 'package:beauty/features/ui/homePage/profile/screens/myOrder.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/profile/widgets/listTileProfile.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                Container(
                  height: ScreenUtil().setHeight(95),
                  width: ScreenUtil().setWidth(95),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kBorder.withOpacity(0.8),

                  ),
                  child: SvgPicture.asset(
                    'assets/svg/person.svg',
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(
                  'Wonderful customer',
                  style: kName,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  'Wonderful customer@gmail.com',
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(13),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),

              ],
            )
          ],
        ),
        MyDivider(),
        ContainerCart(
          // height: 250,
          child: Column(
            children: [
              ListTileProfile(
                title:'Account Informations ' ,
                image: 'assets/svg/personBtn.svg',
                route: AccountInformations(),
              ),

              MyDivider(),
              ListTileProfile(
                title:'Favorite ' ,
                image: 'assets/svg/favBtn.svg',
                route: ShowProduct('Favorite'),
              ),
              MyDivider(),
              ListTileProfile(
                title:'My Order' ,
                image: 'assets/svg/shopBtn.svg',
                route: MyOrder(),
              ),

            ],
          ),
        ),
        ContainerCart(
          // height: 320,
          child: Column(
            children: [
              ListTileProfile(
                title:'Language' ,
                image: 'assets/svg/settingBtn.svg',
                route: Language(),
              ),

              MyDivider(),
              ListTileProfile(
                title:'Help Center' ,
                image: 'assets/svg/soundBtn.svg',
                route: HelpCenter(),
              ),

              MyDivider(),
              ListTileProfile(
                title:'About Us' ,
                image: 'assets/svg/aboutBtn.svg',
                route: AboutUs(),
              ),

              MyDivider(),

              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/shareBtn.svg',
                  fit: BoxFit.contain,
                ),
                title: Text(
                  'Share App ',
                  style: kProfile,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(25),
        ),
        ContainerCart(
          // height: 85,
          child: GestureDetector(
            onTap: () => kNavigatorPushAndRemoveUntil(context, SignIn()),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/logoutBtn.svg',
                fit: BoxFit.contain,
              ),
              title: Text(
                'Log Out ',
                style: kProfile,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(25),
        ),

      ],
    );
  }
}
