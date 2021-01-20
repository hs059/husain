import 'dart:io';

import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customDialog.dart';
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
import 'package:beauty/value/shadow.dart';
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
    AuthProvider authProviderFalse =
        Provider.of<AuthProvider>(context, listen: false);

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
                                boxShadow: sCardShadow2,
                                borderRadius: BorderRadius.circular(100),
                                color: kPinkLight.withOpacity(0.8),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.white,
                                      kPinkLight,
                                      kPinkDark,
                                      kBorder
                                    ])),
                            child: SvgPicture.asset(
                              'assets/svg/beauty0.svg',
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            print(await SPHelper.spHelper.getToken());
                            print(await SPHelper.spHelper.getUser());
                          },
                        ),
                        authProvider.showProfileModel == null
                            ? Center(
                                child: Text(
                                'هناك خطأ بالتسجيل\n يرجى تسجيل الخروج',
                                style: kSeeAll.copyWith(
                                    fontFamily: 'Cairo-Regular', fontSize: 18),
                              ))
                            : Column(
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Text(
                                    authProvider.showProfileModel.data
                                            .displayName ??
                                        '3beauty',
                                    style: kName,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  Text(
                                    authProvider.showProfileModel.data.email ??
                                        '3beauty',
                                    style: kSubTitleSign.copyWith(
                                      fontSize: ScreenUtil().setSp(13),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(25),
                                  ),
                                ],
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
                                }),
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
            visible: authProvider.isLogin && authProvider.showProfileModel != null,
            child: ContainerCart(
              // height: 250,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: GestureDetector(
                      child: ListTileProfile(
                        onTap: () async {
                          authProviderFalse.setLoadEdit(false);
                        },
                        title: 'معلومات الحساب ',
                        image: 'assets/svg/personBtn.svg',
                        route: AccountInformations(),
                      ),
                    ),
                  ),
                  MyDivider(),
                  ListTileProfile(
                      title: 'المفضلة',
                      image: 'assets/svg/favBtn.svg',
                      route: Favourite(),
                      onTap: () {
                        Provider.of<ApiProvider>(context, listen: false)
                            .getAllFav();
                      }),
                  MyDivider(),
                  ListTileProfile(
                    title: 'طلباتي',
                    image: 'assets/svg/shopBtn.svg',
                    route: MyOrder(),
                    onTap: () {
                      Provider.of<ApiProvider>(context, listen: false)
                          .getAllOrder();
                    },
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
                  onTap: () => print(''),
                  title: 'الدعم و المساندة',
                  image: 'assets/svg/soundBtn.svg',
                  route: HelpCenter(),
                ),
                MyDivider(),
                ListTileProfile(
                  onTap: () => print('aa'),
                  title: 'من نحن',
                  image: 'assets/svg/aboutBtn.svg',
                  route: AboutUs(),
                ),
                MyDivider(),
                ListTile(
                  onTap: () {

                      Share.share(
                          Platform.isAndroid
                              ? 'https://play.google.com/store/apps/details?id=com.a7seen.3beauty'
                              : 'https://apps.apple.com/us/app/3beauty/id1545471952',
                          subject: 'استمتع باروع التخفيضات');

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

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "هل تريد تسجيل الخروج",
                            descriptions:
                                "نتمنى لكم ان تكونو مسرورين بما نقدمه من منتجات و عروض و نسعد بزيارتكم",
                            text: "خروج",
                            onTap: () {
                              Provider.of<DBProvider>(context, listen: false)
                                  .deleteAllProduct();
                              authProviderFalse.signOut();
                              kNavigatorPush(context, SignIn());
                            },
                          );
                        });

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
