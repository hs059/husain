import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/value/colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Verification.dart';
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
      child: Directionality(
        textDirection: TextDirection.rtl,
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
                    title: 'إعادة تعيين كلمة المرور',
                    subTitle:
                        'يرجى كتابة بريدك الإلكتروني أدناه ويمكننا مساعدتك في إعادة تعيين كلمة المرور',
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  Form(
                    key: formKeyForgetPassword,
                    child: CustomTextFormField(
                      hintText: 'الايميل',
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
                        text: 'أرسل',
                        onTap: () {
                          authProvider.submitForgetPassword(
                              formKeyForgetPassword, context);
                        }),
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
