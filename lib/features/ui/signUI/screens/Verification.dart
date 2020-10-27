import 'dart:async';

import 'package:beauty/components/btn.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/resetPassword.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification>
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

    controllerPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UiProvider uiProvider = Provider.of<UiProvider>(context);

    return Scaffold(
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
                'Verification',
                style: kTitleSign,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                'We have just sent your email an OTP, please enter below to verify',
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
                      print("DO $text");
                    });
                  },
                  onDone: (text) {
                    doneText = text;
                    print("DONE $text");
                    print("DONE CONTROLLER ${controllerPin.text}");
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
                  text: 'Send',
                  onTap: () {
                    if (controllerPin.text.length == 4) {
                      print("DONE CONTROLLER $doneText");
                      kNavigatorPush(context, ResetPassword());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
