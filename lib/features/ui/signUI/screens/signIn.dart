import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/signUI/screens/forgotPassword.dart';
import 'package:beauty/features/ui/signUI/screens/signUp.dart';
import 'package:beauty/services/auth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:io';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  GlobalKey formKeySignIn = GlobalKey<FormState>();

  Animation animation1, animation2, animation3, animationImage;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationImage = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutQuart));

    animation1 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    animation2 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));
    animation3 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> onWillPopLogin() {
    Provider.of<DBProvider>(context, listen: false).setAllProducts();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthProvider authProviderFalse =
        Provider.of<AuthProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: onWillPopLogin,
          child: ModalProgressHUD(
            inAsyncCall: Provider.of<UiProvider>(context).spinner,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(45),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(117),
                        child: SvgPicture.asset(
                          'assets/svg/beauty0.svg',
                          height: animationImage.value *
                              ScreenUtil().setHeight(117),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation1.value * width, 0.0, 0.0),
                        child: Text(
                          'مرحباَ بك ',
                          style: kTitleSign,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation1.value * width, 0.0, 0.0),
                        child: Text(
                          'سجل دخول لتتم عمليات الشراء',
                          style: kSubTitleOnboarding.copyWith(
                              fontSize: ScreenUtil().setSp(16)),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Form(
                        key: formKeySignIn,
                        child: Column(
                          children: <Widget>[
                            Transform(
                              transform: Matrix4.translationValues(
                                  animation2.value * width, 0.0, 0.0),
                              child: CustomTextFormField(
                                hintText: 'الإيميل',
                                validator: authProvider.validateEmail,
                                onSaved: authProvider.saveEmail,
                                textInputType: TextInputType.emailAddress,
                                password: false,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  animation2.value * width, 0.0, 0.0),
                              child: CustomTextFormField(
                                iconData: uiProvider.iconData,
                                hintText: 'كلمة السر',
                                password: uiProvider.toggleEye,
                                validator: authProvider.validatePassword,
                                onSaved: authProvider.savePassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      FadeTransition(
                        opacity: controller,
                        child: GestureDetector(
                          onTap: () =>
                              kNavigatorPush(context, ForgetPassword()),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'نسيت كلمة السر',
                              style: kSubTitleSign.copyWith(
                                color: kPinkLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation3.value * width, 0.0, 0.0),
                        child: Button(
                            text: 'تسجيل الدخول',
                            onTap: () {
                              authProvider.submitlogin(formKeySignIn, context);
                              Provider.of<ApiProvider>(context, listen: false)
                                  .getAllFav();
                              // Provider.of<ApiProvider>(context, listen: false)
                              //     .getAllOrder();

                              tabControllerConstant.animateTo(0);
                            }),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      FadeTransition(
                        opacity: controller,
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Color(0xffEDF1F7),
                              thickness: 1,
                            )),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('أو'),
                            ),
                            Expanded(
                                child: Divider(
                              color: Color(0xffEDF1F7),
                              thickness: 1,
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                animation1.value * width, 0.0, 0.0),
                            child: RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0)
                                  .animate(controller),
                              child: GestureDetector(
                                onTap: () async {
                                  // bool result = await Auth.auth.signInWithFacebook();
                                  // result?kNavigatorPush(context,HomePage()):print('do not connect');
                                  authProviderFalse.signInWithFacebook(context);
                                  Provider.of<ApiProvider>(context,
                                          listen: false)
                                      .getAllFav();
                                  // Provider.of<ApiProvider>(context,
                                  //         listen: false)
                                  //     .getAllOrder();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(46),
                                  child: SvgPicture.asset(
                                    'assets/svg/btn.facebook.svg',
                                    height: ScreenUtil().setHeight(46),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: Platform.isIOS,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(30),
                                ),
                                Transform(
                                  transform: Matrix4.translationValues(
                                      animation2.value * width, 0.0, 0.0),
                                  child: RotationTransition(
                                    turns: Tween(begin: 0.0, end: 1.0)
                                        .animate(controller),
                                    child: GestureDetector(
                                      onTap: () async {
                                        authProviderFalse
                                            .signInWithApple(context);
                                        Provider.of<ApiProvider>(context,
                                                listen: false)
                                            .getAllFav();
                                        // Provider.of<ApiProvider>(context,
                                        //         listen: false)
                                        //     .getAllOrder();
                                      },
                                      child: Container(
                                        // padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.center,
                                        height: ScreenUtil().setHeight(46),
                                        width: ScreenUtil().setWidth(46),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(0xffedf1f7)),
                                          color: kBorder,
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.apple,
                                          size: 34,
                                        ),
                                        // child: SvgPicture.asset(
                                        //   'assets/svg/apple.svg',
                                        //   height: ScreenUtil().setHeight(46),
                                        //   width: ScreenUtil().setWidth(46),
                                        //
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ////////google SignIn///////
                          Visibility(
                            visible: Platform.isAndroid,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(30),
                                ),
                                Transform(
                                  transform: Matrix4.translationValues(
                                      animation3.value * width, 0.0, 0.0),
                                  child: RotationTransition(
                                    turns: Tween(begin: 0.0, end: 1.0)
                                        .animate(controller),
                                    child: GestureDetector(
                                      onTap: () async {
                                        authProviderFalse.loginUsingGoogle(context);
                                        Provider.of<ApiProvider>(context,
                                                listen: false)
                                            .getAllFav();
                                        // Provider.of<ApiProvider>(context,
                                        //         listen: false)
                                        //     .getAllOrder();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: ScreenUtil().setHeight(46),
                                        child: SvgPicture.asset(
                                          'assets/svg/btn.google.svg',
                                          height: ScreenUtil().setHeight(46),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      FadeTransition(
                        opacity: controller,
                        child: Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'لا تمتلك حساب ؟ ',
                                    style: kSubTitleSign),
                                TextSpan(
                                  text: '   سجل اشتراك  ',
                                  style: TextStyle(
                                    color: kPinkLight,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      kNavigatorPush(context, SignUp());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
