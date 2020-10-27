import 'package:beauty/components/btn.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  GlobalKey<FormState> formKeyResetPassword = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: appBarAuth(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            TitleSubTitle(
              title: 'Reset Password',
              subTitle: '''And now, you can type your new password and confirm it below''',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
            Form(
              key: formKeyResetPassword,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'New Password',
                    password: true,
                    validator: authProvider.validatePassword,
                    onSaved: authProvider.saveNewPassword,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  CustomTextFormField(
                    hintText: 'Confirm New Password',
                    password: true,
                    validator: authProvider.validatePassword,
                    onSaved: authProvider.saveConfirmPassword,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(70),
            ),

            Button(text: 'Reset Password', onTap: () {
              authProvider.submit(formKeyResetPassword);

              if(authProvider.newPassword ==authProvider.confirmPassword){
                authProvider.submit(formKeyResetPassword)?  kNavigatorPushAndRemoveUntil(context, SignIn()):null;
              }else{

              }

            }),
          ],
        ),
      ),
    );
  }
}
