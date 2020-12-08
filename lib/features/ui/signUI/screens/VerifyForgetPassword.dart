import 'dart:async';
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/resetPassword.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class VerifyForgetPassword extends StatefulWidget {
  @override
  _VerifyForgetPasswordState createState() => _VerifyForgetPasswordState();
}

class _VerifyForgetPasswordState extends State<VerifyForgetPassword>
    with SingleTickerProviderStateMixin {
  TextEditingController controllerPin;
  GlobalKey formKeySignUp = GlobalKey<FormState>();
  bool hasError = false;
  Timer _timer;
  int _start = 120;
  String doneText;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    controllerPin = TextEditingController();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
//hello
    controllerPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    AuthProvider authProviderFalse = Provider.of<AuthProvider>(context,listen: false);

    return  ModalProgressHUD(
      inAsyncCall:Provider.of<UiProvider>(context).spinner,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(

            backgroundColor: Colors.white,
            appBar: appBarAuth(context),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Text(
                      'كود التحقق',
                      style: kTitleSign,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      'لقد أرسلنا للتو بريدك الإلكتروني كود التحقق ، يرجى إدخال أدناه للتحقق',
                      style: kSubTitleSign,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    Center(
                      child: PinCodeTextField(
                        autofocus: true,
                        controller: controllerPin,
                        highlight: true,
                        highlightColor: kBorder,
                        defaultBorderColor: kBorder,
                        hasTextBorderColor: kBorder,
                        maxLength: 4,
                        hasError: hasError,
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                            // print("DO $text");
                          });
                        },
                        onDone: (text) {
                          doneText = text;
                          authProviderFalse.saveVerifyForgetPassword(int.parse(text));
                          // print("DONE CONTROLLER ${controllerPin.text}");
                        },
                        pinBoxWidth: ScreenUtil().setWidth(50),
                        pinBoxHeight: ScreenUtil().setHeight(60),
                        hasUnderline: false,
                        wrapAlignment: WrapAlignment.center,
                        pinBoxDecoration:
                        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: kPinCode,
                        pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 150),
//                    highlightAnimation: true,
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                        pinBoxRadius: 10,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Resend on ${_start ~/ 60}:${_start % 60}',
                      textAlign: TextAlign.center,
                      style: kSubTitleSign.copyWith(color: kPinkDark),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(45),
                    ),
                    Button(
                        text: 'أرسل',
                        onTap: () {
                          authProviderFalse.submitVerifyForgetPassword(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
