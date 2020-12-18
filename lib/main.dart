
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/string.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'features/provider/apiProvider.dart';
import 'features/provider/authProvider.dart';
import 'features/provider/db_provider.dart';
import 'features/provider/uiProvider.dart';

import 'features/ui/homePage/cart/screens/addnewAddress.dart';
import 'features/ui/homePage/homePage.dart';
import 'features/ui/onboardingUI/screens/onboarding.dart';


import 'package:firebase_core/firebase_core.dart';

import 'features/ui/splash.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityService();
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
      ExactAssetPicture(SvgPicture.svgStringDecoder, endOrder), null);
  runApp(Husain());
}
class Husain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UiProvider>(
          create: (context) => UiProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<DBProvider>(
          create: (context) => DBProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    );
  }
}
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  bool isSeen;

  Widget screen;

  setVariables() async{
    Logger().d('asasasasasasas');
    isSeen = await SPHelper.spHelper.isSeenOnBoardingGet();
    Logger().d(isSeen);
    isSeen = isSeen ==null?false:isSeen;
    screen = isSeen ? HomePage() : Onboarding();
  }
@override
  void initState() {
    // TODO: implement initState
  super.initState();
  setVariables();

}
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: true);
    return FutureBuilder<FirebaseApp>(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: Text('error'),);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          ScreenUtil.init(context,
              designSize: Size(375, 812), allowFontScaling: true);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
            systemNavigationBarColor: kBlack,
            systemNavigationBarDividerColor: Colors.grey,
            systemNavigationBarIconBrightness: Brightness.dark,
          ));

          return MyApp(screen);
        }
        return  Center(
          child: SvgPicture.asset(
            'assets/svg/beauty0.svg',
            height: ScreenUtil().setHeight(350),
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
class MyApp extends StatelessWidget {
  Widget screen;

  MyApp(this.screen);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: true);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo-Regular',
      ),
      home: Builder(builder: (context) {
        ScreenUtil.init(context,
            designSize: Size(375, 812), allowFontScaling: true);
        return Splash(screen);
      }),

    );
  }
}
