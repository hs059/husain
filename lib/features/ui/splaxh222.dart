
import 'package:beauty/components/animate_do.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
    ConnectivityService();
    if(ConnectivityService.connectivityStatus == ConnectivityHStatus.online){
      print('aaaaaaaaaaaaaaaa');
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
    }else{
      print('offline you have to connect to network');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityStatus>(stream: ConnectivityService.connectionStatusController.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          // return Center(child: RaisedButton(
          //   child: Text(snapshot.data.toString()),
          //   onPressed: () {
          //     Get.snackbar('haaaat','haaaat' ,snackPosition: SnackPosition.TOP);
          //     Get.defaultDialog(title: 'gaaa');
          //   },
          // ),);
          if(snapshot.data.toString() =='ConnectivityStatus.WiFi' ){
            return       JelloIn(
              duration : Duration(milliseconds: 1500),
              animate: true,
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/beauty0.svg',
                  height: ScreenUtil().setHeight(350),
                  fit: BoxFit.contain,
                ),
              ),
            );
          }else{
                return Center(child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/beauty0.svg',
                      height: ScreenUtil().setHeight(350),
                      fit: BoxFit.contain,
                    ),
                    Text('No internet'),

                  ],
                ));
          }
        }
        else{
            return Container();
        }

      }
      )




    );
  }
}
