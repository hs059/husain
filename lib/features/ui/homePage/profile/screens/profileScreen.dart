import 'dart:io';

import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/profile/screens/Language.dart';
import 'package:beauty/features/ui/homePage/profile/screens/aboutUs.dart';
import 'package:beauty/features/ui/homePage/profile/screens/accountInformations.dart';
import 'package:beauty/features/ui/homePage/profile/screens/helpCenter.dart';
import 'package:beauty/features/ui/homePage/profile/screens/myOrder.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/profile/widgets/listTileProfile.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'favourite.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthProvider authProviderFalse = Provider.of<AuthProvider>(
        context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              authProvider.isLogin
                  ? Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  GestureDetector(
                    child: Container(
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
                    onTap: () async {
                      print(await SPHelper.spHelper.getToken());
                      print(await SPHelper.spHelper.getUser());
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '3Beauty',
                    style: kName,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Text(
                    'https://3beauty.net',
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
                  : Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'يرجى منك ',
                        style: kSeeAll.copyWith(
                            fontFamily: 'Cairo-Regular', fontSize: 18),
                      ),
                      Button(
                          text: 'تسجيل الدخول',
                          onTap: () {
                            tabControllerConstant.animateTo(0);
                            kNavigatorPush(context, SignIn());
                          }
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                ],
              ),
            ],
          ),
          MyDivider(),
          Visibility(
            visible: authProvider.isLogin,
            child: ContainerCart(
              // height: 250,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {

                    },
                    child: GestureDetector(
                      onTap: () async {

                      },
                      child: ListTileProfile(
                        title: 'معلومات الحساب ',
                        image: 'assets/svg/personBtn.svg',
                        route: AccountInformations(),
                      ),
                    ),
                  ),
                  MyDivider(),
                  GestureDetector(
                    onTap: () =>
                        Provider.of<ApiProvider>(context, listen: false)
                            .getAllFav()
                    ,
                    child: ListTileProfile(
                      title: 'المفضلة',
                      image: 'assets/svg/favBtn.svg',
                      route: Favourite(),
                    ),
                  ),
                  MyDivider(),
                  GestureDetector(
                    onTap: () =>
                        Provider.of<ApiProvider>(context, listen: false)
                            .getAllOrder()
                    ,
                    child: ListTileProfile(
                      title: 'طلباتي',
                      image: 'assets/svg/shopBtn.svg',
                      route: MyOrder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ContainerCart(
            // height: 320,
            child: Column(
              children: [
                // ListTileProfile(
                //   title: 'Language',
                //   image: 'assets/svg/settingBtn.svg',
                //   route: Language(),
                // ),
                // MyDivider(),
                ListTileProfile(
                  title: 'الدعم و المساندة',
                  image: 'assets/svg/soundBtn.svg',
                  route: HelpCenter(),
                ),
                MyDivider(),
                ListTileProfile(
                  title: 'من نحن',
                  image: 'assets/svg/aboutBtn.svg',
                  route: AboutUs(),
                ),
                MyDivider(),
                ListTile(
                  onTap: () {
                    if (ConnectivityService.connectivityStatus ==
                        ConnectivityHStatus.online) {
                      Share.share(
                          Platform.isAndroid
                              ?
                          'https://play.google.com/store/apps/details?id=com.facebook.katana&hl=en_US&gl=US'
                              : 'https://apps.apple.com/us/app/facebook/id284882215',
                          subject: 'استمتع باروع التخفيضات');
                    } else {
                      Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
                        titleText: Text(
                          'لا يوجد اتصال بالانترنت',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        messageText: Text(
                          'يرجى فحص الاتصال بالشبكة',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                  leading: SvgPicture.asset(
                    'assets/svg/shareBtn.svg',
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'مشاركة التطبيق',
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
          Visibility(
            visible: authProvider.isLogin,

            child: ContainerCart(
              // height: 85,
              child: GestureDetector(
                onTap: () {
                  if (ConnectivityService.connectivityStatus ==
                      ConnectivityHStatus.online) {
                    Provider.of<DBProvider>(context, listen: false)
                        .deleteAllProduct();
                    authProviderFalse.signOut();
                    kNavigatorPush(context, SignIn());
                  } else {
                    Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
                      titleText: Text(
                        'لا يوجد اتصال بالانترنت',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      messageText: Text(
                        'يرجى فحص الاتصال بالشبكة',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/logoutBtn.svg',
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'تسجيل الخروج ',
                    style: kProfile,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
        ],
      ),
    );
  }
}
