import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/onboardingUI/widgets/detailsOnboarding.dart';
import 'package:beauty/features/ui/onboardingUI/widgets/indicatorOnboarding.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';

import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context,);
    return WillPopScope(
      onWillPop:onWillPop ,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Container(
                height: ScreenUtil().setHeight(530),
                width: double.infinity,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    DetailsOnboarding(
                      image: 'assets/svg/on_boading1.svg',
                      title: 'تصفح الكثير من المنتجات',
                      subTitle:
                          'يوفر لك متجر ثري بيوتي خدمة تصفح معظم منتجات المكياج والعطور',
                    ),
                    DetailsOnboarding(
                      image: 'assets/svg/on_boading2.svg',
                      title: 'طرق دفع مختلفة ',
                      subTitle:
                          ' يوفر لك متجر ثري بيوتي خدمة الدفع الالكتروني عبر العديد من الطرق الحديثة والآمنة',
                    ),
                    DetailsOnboarding(
                      image: 'assets/svg/on_boading3.svg',
                      title: 'خدمة توصيل الطلبات',
                      subTitle:
                          'تمتع بخدمة الشحن لكافة مناطق المملكة باسعار واوقات منافسة',
                    ),
                  ],
                ),
              ),
              Button(
                text:  _currentPage != _numPages - 1 ? 'التالي' : 'إنطلاق',
                onTap: () {
                  if(_currentPage != _numPages - 1){
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }else{
                    kNavigatorPushReplacement(context,HomePage());
                    SPHelper.spHelper.isSeenOnBoardingSet(true);
                  }
                },
                padding: EdgeInsets.zero,
              ),
              SizedBox(height: ScreenUtil().setHeight(55)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IndicatorOnboarding(
                    currentPage: _currentPage,
                    numPages: _numPages,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.animateToPage(_numPages - 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        _currentPage != _numPages - 1 ? 'تخطي' : '',
                        style: TextStyle(
                          color: kPinkDark,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg:'Tap again to leave');
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}


