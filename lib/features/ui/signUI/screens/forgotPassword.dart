import 'package:beauty/components/btn.dart';
import 'Verification.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';


class ForgetPassword extends StatelessWidget {
  GlobalKey formKeyForgetPassword = GlobalKey<FormState> ();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
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
              TitleSubTitle(
                title: 'Forgot Password',
                subTitle: 'Please type your email or phone number below and we can help you reset password',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              Form(
                key: formKeyForgetPassword,
                child: CustomTextFormField(
                  hintText: 'Email or Phone Number',
                  validator: authProvider.validateEmail,
                  onSaved:authProvider.saveEmailForget,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              Button(text: 'Send', onTap: (){
                //ToDo: check email is found in api
                authProvider.submit(formKeyForgetPassword);
                authProvider.submit(formKeyForgetPassword) ? kNavigatorPush(context, Verification()):null;
              }),
            ],
          ),
        ),
      ),
    );
  }
}
