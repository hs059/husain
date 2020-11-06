import 'package:beauty/components/btn.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarAuth(context),
      body: ModalProgressHUD(
        inAsyncCall:uiProvider.spinner,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Sign Up',
                  style: kTitleSign,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Text(
                  'Please type your information below',
                  style: kSubTitleSign,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Form(
                  key: formKeySignUp,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: 'Full Name',
                        password: false,
                        validator: authProvider.validateName,
                        onSaved: authProvider.saveFullName,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      CustomTextFormField(
                        hintText: 'Email',
                        password: false,
                        validator: authProvider.validateEmail,
                        onSaved: authProvider.saveEmail,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      CustomTextFormField(
                        hintText: 'Password',
                        password: uiProvider.toggleEye,
                        iconData: uiProvider.iconData,
                        validator: authProvider.validatePassword,
                        onSaved: authProvider.savePassword,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      CustomTextFormField(
                        hintText: 'Confirm Password',
                        password: uiProvider.toggleEye,
                        iconData: uiProvider.iconData,
                        validator: authProvider.validatePassword,
                        onSaved: authProvider.saveConfirmPassword,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1.0, color: kBorder),
                        ),
                        child: IntlPhoneField(
                          validator: authProvider.validatePhone,
                          autoValidate: false,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle:
                                TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kBorder, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kBorder, width: 1.0),
                            ),
                          ),
                          initialCountryCode: 'SA',
                          showDropdownIcon: false,
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                ),
                Button(
                    text: 'Sign Up',
                    onTap: () {
                      authProvider.submitRegister(formKeySignUp, context);
                    }),
                SizedBox(
                  height: ScreenUtil().setHeight(90),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'You have an account? ', style: kSubTitleSign),
                        TextSpan(
                          text: '   Sign In',
                          style: TextStyle(
                            color: kPinkLight,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              kNavigatorPushAndRemoveUntil(context, SignIn());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
