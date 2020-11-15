import 'package:beauty/components/model/showProfileModel.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/homePage/screens/home.dart';
import 'package:beauty/features/ui/signUI/screens/Verification.dart';
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
      verificationCode,
      fullName;


  saveEmail(String value) {
    this.email = value;
    notifyListeners();
  }
  saveMobile(String value) {
    this.mobile = value;
    notifyListeners();
  }

  savePassword(String value) {
    print('//////////////////////////// $value');
    this.password = value;
    notifyListeners();
  }


  saveNewPassword(String value) {
    print('/////////////saveNewPassword/////////////// $value');

    this.newPassword = value;
    notifyListeners();
  }
  saveConfirmPassword(String value) {
    print('/////////////saveConfirmPassword/////////////// $value');

    this.confirmPassword = value;
    notifyListeners();
  }
  saveEmailPassword(String value) {
    this.emailPassword = value;
    notifyListeners();
  }

  saveFullName(String value) {
    print('/////////////saveFullName/////////////// $value');

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

  validateConfirmPassword(String value) {
    print('password = $password');
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isAlphanumeric(value)) {
      return 'invalid Password ';
    } else if (password!=value) {
      return 'not matched';
    }
  }



  validateName(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    }  else if (value.length < 4) {
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
  bool isLogin ;

  getLogin()async{
    isLogin = await SPHelper.spHelper.getIsLogin();
    if(isLogin){
      showProfile() ;
    }
    notifyListeners() ;
  }
//////////////////////submit////////////////////////////////
   submitRegister(GlobalKey<FormState> globalKey, BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      registerUser(context);
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  registerUser(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    Map map = await ApiClient.apiClient.registerUser(
        this.fullName, this.mobile, this.password, this.email);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
  print(map);
    if (map['code']) {

      kNavigatorPush(
        context,
        Verification(),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kBlack,
          content: Text(
            map['message'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(18)),
          ),
        ),
      );
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
    print(map);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      isLogin = true ;
      await SPHelper.spHelper.setToken(map['data']['token']);
      await SPHelper.spHelper.setIsLogin(true);
      showProfile();
      kNavigatorPush(
        context,
        HomePage(),
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
    await  SPHelper.spHelper.setToken(map['data']['token']);
    await  SPHelper.spHelper.setUser(map['data']['user_id']);
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
    }else{
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kBlack,
          content: Text(
            'الايميل غير صالح',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18)),
          ),
        ),
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
    if(map['code']){
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
////////////////////////////////////////////////////////////////////////////////
  submitVerification(GlobalKey<FormState> globalKey,BuildContext context){
    if(globalKey.currentState.validate()){
      globalKey.currentState.save();
      verification(context);
    }
  }
verification(BuildContext context)async{
  Provider.of<UiProvider>(context, listen: false).toggleSpinner();
  int id =await SPHelper.spHelper.getUser();
  Map map =  await ApiClient.apiClient.verification(id.toString(), verificationCode);
  Provider.of<UiProvider>(context,listen: false).toggleSpinner();
  if(map['code']){
    Fluttertoast.showToast(
        msg: map['message'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: Color(0xffDAA095),
        fontSize: 16.0
    );
    kNavigatorPushAndRemoveUntil(context, HomePage());
  }else{
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kBlack,
        content: Text(
          map['message'],
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18)),
        ),
      ),
    );
  }
}
  signOut() async {
    isLogin = false ;
    SPHelper.spHelper.setIsLogin(false);
    SPHelper.spHelper.setToken('');
    SPHelper.spHelper.setToken('');
    showProfileModel = null ;
  }

  ShowProfileModel showProfileModel ;

  showProfile()async{
    if(isLogin){
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      notifyListeners();
    }else{

    }
  }
  submitEditProfile(BuildContext context,GlobalKey<FormState> globalKey){
    if(globalKey.currentState.validate()){
      globalKey.currentState.save();
      editProfile(context);
    }
  }
  editProfile(BuildContext context)async{
    String token = await SPHelper.spHelper.getToken();
    int idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    print('token = $token id = $id name = $fullName email = $email mobile = $mobile');
    Map map =await ApiClient.apiClient.editProfile(token, id, this.fullName, this.email, this.mobile);
    showProfileModel = await ApiRepository.apiRepository.showProfile();
    Navigator.pop(context);
    // if( !map['code']){
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       backgroundColor: kBlack,
    //       content: Text(
    //         map['message'],
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             color: Colors.white, fontSize: ScreenUtil().setSp(18)),
    //       ),
    //     ),
    //   );
    // }
    notifyListeners();
  }

}
