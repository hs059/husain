import 'package:beauty/components/animate_do.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/services/dl_service.dart';

import 'package:beauty/services/location.dart';
import 'package:beauty/services/notification_firebase.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'homePage/homePage.dart';

class Splash extends StatefulWidget {
  final Widget screen;

  Splash(this.screen);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  // final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  @override
  void initState() {
    super.initState();

    Provider.of<ApiProvider>(context, listen: false).getOnbourding();
    // _dynamicLinkService.retrieveDynamicLink(context);
    Provider.of<AuthProvider>(context, listen: false).getLogin();
    Provider.of<AuthProvider>(context, listen: false).getLoginSocial();
    Provider.of<ApiProvider>(context, listen: false).getSlider();
    Provider.of<ApiProvider>(context, listen: false).getSection();
    Provider.of<ApiProvider>(context, listen: false).getBrand();
    Location.location.getCurrentLocation();
    Provider.of<ApiProvider>(context, listen: false).getCategory();
    Provider.of<ApiProvider>(context, listen: false).getPrivacyPolicy();
    Provider.of<ApiProvider>(context, listen: false).getAllOrder();
    Provider.of<DBProvider>(context, listen: false).setAllProducts();
    Provider.of<ApiProvider>(context, listen: false).getAllAddress();
    Provider.of<ApiProvider>(context, listen: false).getAllFav();


    var delay = Duration(seconds: 4);
    Future.delayed(delay, () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return widget.screen;
        },
      ));
    });

    NotificationFirebaseHelper(context).registerOnFirebase();
    NotificationFirebaseHelper(context).getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JelloIn(
        duration: Duration(milliseconds: 1500),
        animate: true,
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/beauty0.svg',
            height: ScreenUtil().setHeight(350),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
