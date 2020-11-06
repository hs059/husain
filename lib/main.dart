import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/string.dart';
import 'package:flutter/services.dart';

import 'package:beauty/features/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'features/provider/uiProvider.dart';


import 'features/ui/homePage/homePage.dart';
import 'features/ui/onboardingUI/screens/onboarding.dart';
import 'features/ui/product/productScreen.dart';

import 'features/ui/signUI/screens/Verification.dart';
import 'features/ui/signUI/screens/resetPassword.dart';
import 'features/ui/signUI/screens/signIn.dart';
import 'features/ui/signUI/screens/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/svg/on_boading1.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/svg/on_boading2.svg'),
      null);

  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/svg/on_boading3.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, endOrder),
      null);


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  bool isSeen = await SPHelper.spHelper.isSeenOnBoardingGet()??false ;
  print(isSeen);
  Widget screen = isSeen?HomePage():Onboarding() ;

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
 Widget screen ;
 MyApp(this.screen);
   @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UiProvider>(
          create: (context) => UiProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Builder(builder: (context) {
          ScreenUtil.init(context,
              designSize: Size(375, 812), allowFontScaling: true);
          return screen;
        }),

      ),
    );
  }
}
