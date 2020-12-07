import 'package:beauty/components/model/showProfileModel.dart';
import 'package:beauty/components/model/socialMediaModel.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/features/ui/homePage/screens/home.dart';
import 'package:beauty/features/ui/signUI/screens/Verification.dart';
import 'package:beauty/features/ui/signUI/screens/VerifyForgetPassword.dart';
import 'package:beauty/features/ui/signUI/screens/resetPassword.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/auth.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  String email,
      password,
      mobile,
      newPassword,
      confirmPassword,
      emailPassword,
      verificationCode,
      fullName;

  saveEmail(String value) {
    this.email = value;
    notifyListeners();
  }

  saveVerificationCode(String value) {
    this.verificationCode = value;
    notifyListeners();
  }

  int verifyForgetPassword;

  saveVerifyForgetPassword(int value) {
    this.verifyForgetPassword = value;
    notifyListeners();
  }

  saveMobile(String value) {
    this.mobile = value;
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

  validateConfirmPassword(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isAlphanumeric(value)) {
      return 'invalid Password ';
    } else if (password != value) {
      return 'not matched';
    }
  }

  validateName(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
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

  bool isLogin;

  getLogin() async {
    isLogin = await SPHelper.spHelper.getIsLogin() ?? false;
    if (isLogin) {
      showProfile();
    }
    notifyListeners();
  }

  bool isLoginSocial ;
  getLoginSocial() async {
    isLoginSocial = await SPHelper.spHelper.getIsLoginSocial() ?? false;
    if (isLogin) {
      getLogin();
    }
    notifyListeners();
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
    Map map = await ApiClient.apiClient
        .registerUser(this.fullName, this.mobile, this.password, this.email);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      await SPHelper.spHelper.setUser(map['data']['id'].toString());
      kNavigatorPush(
        context,
        Verification(),
      );
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            map['message'],
            textAlign: TextAlign.right,
          ));
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
    Map map = await ApiClient.apiClient.loginUser(this.email, this.password);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      isLogin = true;
      await SPHelper.spHelper.setToken(map['data']['token']);
      await SPHelper.spHelper.setUser(map['data']['id'].toString());
      await SPHelper.spHelper.setIsLogin(true);
      showProfile();
      kNavigatorPush(
        context,
        HomePage(),
      );
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            map['message'],
            textAlign: TextAlign.right,
          ));
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
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      await SPHelper.spHelper.setUser(map['data']['user_id']);

      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
      kNavigatorPush(
        context,
        VerifyForgetPassword(),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kBlack,
          content: Text(
            'الايميل غير صالح',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(18)),
          ),
        ),
      );
    }
  }

/////////////////////////////////////////////////////////////////////////////
  submitResetPassword(GlobalKey<FormState> globalKey, BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      resetPassword(context);
      notifyListeners();
    }
  }

  resetPassword(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    String id = await SPHelper.spHelper.getUser();
    String token = await SPHelper.spHelper.getToken();
    Map map = await ApiClient.apiClient.resetPassword(id, token, newPassword);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
      kNavigatorPushAndRemoveUntil(context, SignIn());
    }
  }

  submitVerifyForgetPassword(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    String id = await SPHelper.spHelper.getUser();
    Map map = await ApiClient.apiClient
        .verifyForgetPassword(id, verifyForgetPassword);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      await SPHelper.spHelper.setToken(map['data']['token']);
      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
      kNavigatorPushAndRemoveUntil(context, ResetPassword());
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            map['message'],
            textAlign: TextAlign.right,
          ));
    }
  }

////////////////////////////////////////////////////////////////////////////////

  submitVerification(BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    String id = await SPHelper.spHelper.getUser();
    Map map =
        await ApiClient.apiClient.verification(id.toString(), verificationCode);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();
    if (map['code']) {
      isLogin = true;
      await SPHelper.spHelper.setToken(map['data']['token']);
      await SPHelper.spHelper.setIsLogin(true);
      Fluttertoast.showToast(
          msg: map['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
      kNavigatorPushAndRemoveUntil(context, HomePage());
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            map['message'],
            textAlign: TextAlign.right,
          ));
    }
  }

  signOut() async {
    isLogin = false;
    SPHelper.spHelper.setIsLogin(false);
    SPHelper.spHelper.setToken('');
    SPHelper.spHelper.setToken('');
    showProfileModel = null;
  }

  ShowProfileModel showProfileModel;

  showProfile() async {
    if (isLogin) {
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      notifyListeners();
    } else {}
  }

  submitEditProfile(BuildContext context, GlobalKey<FormState> globalKey) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      editProfile(context);
    }
  }

  editProfile(BuildContext context) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    Map map1 = await ApiClient.apiClient
        .editProfile(token, id, this.fullName, this.email, this.mobile);
    Map map2 = await ApiClient.apiClient
        .changePassword(token, id, password, newPassword);
    if (map1['code'] && map2['code']) {
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      Navigator.pop(context);
      Fluttertoast.showToast(
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          msg: 'تم تعديل بيناتك بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            'يرجى منك اتمام كل المعلومات بشكل صحيح',
            textAlign: TextAlign.right,
          ));
    }

    notifyListeners();
  }

  submitEditProfileSocial(BuildContext context, GlobalKey<FormState> globalKey) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      editProfileSocial(context);
    }
  }

  editProfileSocial(BuildContext context) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    Map map1 = await ApiClient.apiClient
        .editProfile(token, id, this.fullName, this.email, this.mobile);
    if (map1['code'] ) {
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'تم تعديل بيناتك بنجاح',
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Get.snackbar('', '',
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            'رسالة تحذير',
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            'يرجى منك اتمام كل المعلومات بشكل صحيح',
            textAlign: TextAlign.right,
          ));
    }

    notifyListeners();
  }

  socialMediaLogin(String socialId, String userName, String mobileNumber,
      String email, String type,BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    SocialMedia socialMedia = await ApiRepository.apiRepository
        .socialMediaLogin(socialId, userName, mobileNumber, email, type);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    SPHelper.spHelper.setToken(socialMedia.data.token);
    SPHelper.spHelper.setUser(socialMedia.data.id);
    SPHelper.spHelper.setIsLogin(true);
    SPHelper.spHelper.setIsLoginSocial(true);
    getLogin();
    getLoginSocial();
    kNavigatorPush(context, HomePage());
  }

  signInWithTwitter(BuildContext context) async {
    UserCredential userCredential = await Auth.auth.signInWithTwitter();
    Logger().d(userCredential.user.email);
    Logger().d(userCredential.user.displayName);
    Logger().d(userCredential.user.tenantId);
    String socialId = userCredential.user.uid;
    String userName = userCredential.user.displayName;
    String email = userCredential.user.email;
    String type = 'twitter';
    socialMediaLogin(socialId, userName, '', email, type,context);
  }

  loginUsingGoogle(BuildContext context) async {
    UserCredential userCredential = await Auth.auth.signInWithGoogle();
    Logger().d(userCredential.user.email);
    Logger().d(userCredential.user.displayName);
    Logger().d(userCredential.user.uid);
    String socialId = userCredential.user.uid;
    String userName = userCredential.user.displayName;
    String email = userCredential.user.email;
    String type = 'gmail';
    socialMediaLogin(socialId, userName, '', email, type,context);
  }

  signInWithFacebook(BuildContext context) async {
    Map userData = await Auth.auth.signInWithFacebook();
    Logger().d(userData);
    String socialId = userData['id'] ;
    String userName = userData['name'];
    String email = userData['email'] ;
    String type = 'facebook';
    Logger().d(userData['name']);
    Logger().d(userData);
    Logger().d(userData['email']);
    Logger().d(userData['id']);
    socialMediaLogin(socialId, userName, '99999999999', email, type,context);
  }
}
