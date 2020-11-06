import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/ui/homePage/screens/home.dart';
import 'package:beauty/features/ui/signUI/screens/resetPassword.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {

  String email,
      password,
      mobile,
      newPassword,
      confirmPassword,
      emailPassword ,
      fullName;


  saveEmail(String value) {
    this.email = value;
    notifyListeners();
  }

  savePassword(String value) {
    this.password = value;
    notifyListeners();
  }


  saveNewPassword(String value) {
    this.newPassword = value;
    notifyListeners();
  }
  saveConfirmPassword(String value) {
    this.confirmPassword = value;
    notifyListeners();
  }
  saveEmailPassword(String value) {
    this.emailPassword = value;
    notifyListeners();
  }

  saveFullName(String value) {
    this.fullName = value;
    notifyListeners();
  }




  ///////////////////validate/////////////////////////////////////////
  validateEmail(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isEmail(value)) {
      return 'invalid Email ';
    }
  }

  validatePassword(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isAlphanumeric(value)) {
      return 'invalid Password ';
    }
  }



  validateName(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isAlphanumeric(value)) {
      return 'invalid name ';
    } else if (value.length < 4) {
      return 'name at least 4 Letters';
    }
  }

  String validatePhone(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isNumeric(value)) {
      return 'invalid number ';
    } else if (value.length != 9) {
      return 'phone number must be equal 9 numbers';
    }
  }

//////////////////////submit////////////////////////////////
  bool submitRegister(GlobalKey<FormState> globalKey, BuildContext context) {
    bool auth = false;
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();

      registerUser(context);
      auth = true;
      notifyListeners();
      return auth;
    } else {
      auth = false;
      notifyListeners();
      return auth;
    }
  }

  registerUser(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    Map map = await ApiClient.apiClient.registerUser(
        this.fullName, this.mobile, this.password, this.email);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    if (map['code']) {

      // kNavigatorPush(
      //   context,
      //   SignIn(),
      // );
    } else {
      print('message :' + map['message']);

    }
  }

//////////////////////////////////////////////////////////////////////////////////
  submitlogin(GlobalKey<FormState> globalKey, BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      loginUser(context);
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  loginUser(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    Map map =
    await ApiClient.apiClient.loginUser(this.email, this.password);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      SPHelper.spHelper.setToken(map['data']['token']);
      kNavigatorPush(
        context,
        Home(),
      );
    } else {
      print(map['message']);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kBlack,
          content: Text(
            'البريد الالكتروني أو كلمة المرور غير صحيحة',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(18)),
          ),
        ),
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  submitForgetPassword(GlobalKey<FormState> globalKey, BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      forgetPassword(context);
      notifyListeners();
    } else {
      notifyListeners();
      return;
    }
  }

  forgetPassword(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    Map map = await ApiClient.apiClient.forgetPassword(this.email);
    print(map);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      SPHelper.spHelper.setToken(map['data']['token']);
      SPHelper.spHelper.setUser(map['data']['user_id']);
      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          textColor: Color(0xffDAA095),
          fontSize: 16.0
      );
      kNavigatorPush(
        context,
        ResetPassword(),
      );
    }
  }

/////////////////////////////////////////////////////////////////////////////
  submitResetPassword(GlobalKey<FormState> globalKey,BuildContext context ){
    if(globalKey.currentState.validate()){
      globalKey.currentState.save();
      resetPassword(context);
      notifyListeners();
    }
  }

  resetPassword(BuildContext context) async {
    Provider.of<UiProvider>(context,listen: false).toggleSpinner();
    int id =await SPHelper.spHelper.getUser();
    String token =await SPHelper.spHelper.getToken();
    print(token);
    Map map = await ApiClient.apiClient.resetPassword(
        id, token, emailPassword, newPassword);
    print(map);
    Provider.of<UiProvider>(context,listen: false).toggleSpinner();
    if(map['code'] &&
        this.newPassword ==
        this.confirmPassword){
      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          textColor: Color(0xffDAA095),
          fontSize: 16.0
      );
      kNavigatorPushAndRemoveUntil(context, SignIn());
    }
  }





//ToDo:Verification

}
