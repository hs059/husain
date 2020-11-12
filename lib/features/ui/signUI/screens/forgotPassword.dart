import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/value/colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Verification.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/signUI/widgets/appBarAuth.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  GlobalKey formKeyForgetPassword = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);

    return ModalProgressHUD(
      inAsyncCall:Provider.of<UiProvider>(context).spinner,
      child: Scaffold(
        key: scaffoldKey,
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
                  subTitle:
                      'Please type your email or phone number below and we can help you reset password',
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(60),
                ),
                Form(
                  key: formKeyForgetPassword,
                  child: CustomTextFormField(
                    hintText: 'Email',
                    validator: authProvider.validateEmail,
                    onSaved: authProvider.saveEmail,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                ),
                Builder(
                  builder: (context) =>
                  Button(
                      text: 'Send',
                      onTap: () {
                        //ToDo: check email is found in api
                        authProvider.submitForgetPassword(
                            formKeyForgetPassword, context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
