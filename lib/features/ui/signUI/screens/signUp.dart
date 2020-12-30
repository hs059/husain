
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
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

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthProvider authProviderFalse = Provider.of<AuthProvider>(context,listen: false);
    UiProvider uiProvider = Provider.of<UiProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarAuth(context),
        body: ModalProgressHUD(
          inAsyncCall:uiProvider.spinner,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: SingleChildScrollView(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'إنشاء حساب جديد',
                    style: kTitleSign,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'الرجاء كتابة المعلومات الخاصة بك أدناه',
                    style: kSubTitleSign,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Form(
                    key: formKeySignUp,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'الاسم كامل ',
                          password: false,
                          validator: authProvider.validateName,
                          onSaved: authProvider.saveFullName,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        CustomTextFormField(
                          hintText: 'الايميل',
                          password: false,
                          validator: authProvider.validateEmail,
                          onSaved: authProvider.saveEmail,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        CustomTextFormField(
                          hintText: 'كلمة السر',
                          password: true,
                          validator: authProvider.validatePassword,
                          onSaved: authProvider.savePassword,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        CustomTextFormField(
                          hintText: 'تأكيد كلمة السر',
                          password: true,
                          validator: authProvider.validateConfirmPassword,
                          onSaved: authProvider.saveConfirmPassword,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(width: 1.0, color: kBorder),
                            ),
                            child: IntlPhoneField(
                              validator: authProvider.validatePhone,
                              autoValidate: false,

                              decoration: InputDecoration(
                                hintText: 'رقم الموبايل',
                                hintStyle:
                                TextStyle(color: Color(0xff8F9BB3), fontSize: ScreenUtil().setSp(15)),
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
                                authProviderFalse.saveMobile(phone.completeNumber);
                            },
                              onSaved:(phone) {
                                authProviderFalse.saveMobile(phone.completeNumber);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Builder(
                    builder: (context) =>  Button(
                        text: 'تسجيل ',
                        onTap: () {
                          Provider.of<AuthProvider>(context,listen: false).submitRegister(formKeySignUp, context);
                          // saveForm();
                        }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'لديك حساب؟', style: kSubTitleSign),
                          TextSpan(
                            text: '   تسجيل الدخول',
                            style: TextStyle(
                              color: kPinkLight,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
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
      ),
    );
  }
}
