import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/forgotPassword.dart';
import 'package:beauty/features/ui/signUI/screens/signUp.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall:Provider.of<UiProvider>(context).spinner,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 117,
                    child: SvgPicture.asset(
                      'assets/svg/beauty0.svg',
                      height: animationImage.value * 117,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation1.value * width, 0.0, 0.0),
                    child: Text(
                      'Welcome back',
                      style: kTitleSign,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation1.value * width, 0.0, 0.0),
                    child: Text(
                      'Sign in to continue',
                      style: kSubTitleOnboarding.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(35),
                  ),
                  Form(
                    key: formKeySignIn,
                    child: Column(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.translationValues(
                              animation2.value * width, 0.0, 0.0),
                          child: CustomTextFormField(
                            hintText: 'Email',
                            validator: authProvider.validateEmail,
                            onSaved: authProvider.saveEmail,
                            textInputType: TextInputType.emailAddress,
                            password: false,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animation2.value * width, 0.0, 0.0),
                          child: CustomTextFormField(
                            iconData: uiProvider.iconData,
                            hintText: 'Password',
                            password: uiProvider.toggleEye,
                            validator: authProvider.validatePassword,
                            onSaved: authProvider.savePassword,

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  FadeTransition(
                    opacity: controller,
                    child: GestureDetector(
                      onTap: () => kNavigatorPush(context, ForgetPassword()),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password',
                          style: kSubTitleSign.copyWith(
                            color: kPinkLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(35),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation3.value * width, 0.0, 0.0),
                    child: Button(
                        text: 'Sign In',
                        onTap: () {
                          authProvider.submitlogin(formKeySignIn, context);

                        }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
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
                          child: Text('Or'),
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
                    height: ScreenUtil().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(
                            animation1.value * width, 0.0, 0.0),
                        child: RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: 1.0).animate(controller),
                          child: GestureDetector(
                            onTap: () {


                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().setHeight(46),
                              child: SvgPicture.asset(
                                'assets/svg/btn.facebook.svg',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(30),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation2.value * width, 0.0, 0.0),
                        child: RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: 1.0).animate(controller),
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().setHeight(46),
                            child: SvgPicture.asset(
                              'assets/svg/btn.twitter.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(30),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation3.value * width, 0.0, 0.0),
                        child: RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: 1.0).animate(controller),
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().setHeight(46),
                            child: SvgPicture.asset(
                              'assets/svg/btn.google.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  FadeTransition(
                    opacity: controller,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Don\'t have an account? ',
                                style: kSubTitleSign),
                            TextSpan(
                              text: '   Sign Up',
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
    );
  }
}