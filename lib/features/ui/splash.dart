import 'package:beauty/components/animate_do.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  final Widget screen;

  Splash(this.screen);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getLogin();
    Provider.of<ApiProvider>(context, listen: false).getSlider();
    Provider.of<ApiProvider>(context, listen: false).getSection();
    Provider.of<ApiProvider>(context, listen: false).getBrand();

    var delay = Duration(seconds: 4);
    Future.delayed(delay, () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return widget.screen;
        },
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JelloIn(
        duration : Duration(milliseconds: 1500),
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
