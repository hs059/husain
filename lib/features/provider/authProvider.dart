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
import 'package:beauty/services/connectivity.dart';
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
    print(password);
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
      return 'هذه الخانة مطلوبه';
    } else if (!isEmail(value)) {
      return 'invalid Email ';
    }
  }

  validatePassword(String value) {
    if (value == null || value == '') {
      return 'هذه الخانة مطلوبه';
    } else if (!isAlphanumeric(value)) {
      return 'رمز مرور غير مقبول ';
    } else if (value.length < 6) {
      return 'كلمة السر على الأقل 6 ';
    }
  }

  validateConfirmPassword(String value) {
    if (value == null || value == '') {
      return ' هذه الخانة مطلوبه ';
    } else if (!isAlphanumeric(value)) {
      return 'رمز مرور غير مقبول ';
    } else if (password != value) {
      return 'not matched';
    }
  }

  String validateName(String value) {
    if (value == null || value == '') {
      return ' هذه الخانة مطلوبه';
    } else if (value.length < 4) {
      return 'اسم على الأقل 4 أحرف';
    }
  }

  String validatePhone(String value) {
    if (value == null || value == '') {
      return ' هذه الخانة مطلوبه';
    } else if (!isNumeric(value)) {
      return 'invalid number ';
    } else if (value.length != 9) {
      return 'يجب ان تحتوي هذه الخانة على 9 ارقام';
    }
  }
  String validateNumber(String value) {
    if (value == null || value == '') {
      return ' هذه الخانة مطلوبه';
    } else if (!isNumeric(value)) {
      return 'يرجى ادخال ارقام ';
    }
  }

  String validateText(String value) {
    if (value == null || value == '') {
      return ' هذه الخانة مطلوبه';
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
      await SPHelper.spHelper.setUser(map['data']['user_id'].toString());

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
            'ايميل المستخدم غير موجود',
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



  bool loadEdit = false ;
  setLoadEdit(bool value){
    this.loadEdit = value ;
    notifyListeners();
  }

  submitEditProfile(BuildContext context, GlobalKey<FormState> globalKey) {
    Logger().d('submitEditProfile');

    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      editProfile(context);
    }
  }

  editProfile(BuildContext context) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    setLoadEdit(true);
    Map map1 = await ApiClient.apiClient
        .editProfile(token, id, this.fullName, this.email, this.mobile);
   Map map2 = await ApiClient.apiClient
        .changePassword(token, id, password, newPassword);
    setLoadEdit(false);

    if (map1['code'] && map2['code']) {
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      // Navigator.pop(context);
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
    Logger().d('submitEditProfileSocial');
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      editProfileSocial(context);
    }
  }

  editProfileSocial(BuildContext context) async {
    String token = await SPHelper.spHelper.getToken();
    String idUser = await SPHelper.spHelper.getUser();
    String id = idUser.toString();
    setLoadEdit(true);
    Map map1 = await ApiClient.apiClient
        .editProfile(token, id, this.fullName, this.email, this.mobile);
    setLoadEdit(false);
    if (map1['code'] ) {
      showProfileModel = await ApiRepository.apiRepository.showProfile();
      // Navigator.pop(context);
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

  socialMediaLogin(String socialId, String displayName, String mobileNumber,
      String email, String type,BuildContext context) async {
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    SocialMedia socialMedia = await ApiRepository.apiRepository
        .socialMediaLogin(socialId, displayName, mobileNumber, email, type);
    Provider.of<UiProvider>(context, listen: false).toggleSpinner();

    SPHelper.spHelper.setToken(socialMedia.data.token);
    SPHelper.spHelper.setUser(socialMedia.data.id);
    SPHelper.spHelper.setIsLogin(true);
    SPHelper.spHelper.setIsLoginSocial(true);
    Logger().d(socialMedia.toJson());
    getLogin();
    getLoginSocial();
    kNavigatorPush(context, HomePage());
  }

  // signInWithTwitter(BuildContext context) async {

  //   if (ConnectivityService.connectivityStatus ==
  //       ConnectivityHStatus.online) {
  //     // UserCredential userCredential = await Auth.auth.signInWithTwitter();

  //     String socialId = userCredential.user.uid;
  //     String displayName = userCredential.user.displayName;
  //     String email = userCredential.user.email;
  //     String phoneNumber = userCredential.user.phoneNumber??'';
  //     String type = 'twitter';
  //     socialMediaLogin(socialId, displayName, phoneNumber, email, type,context);
  //   }else{
  //     Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
  //       titleText:  Text(
  //         'لا يوجد اتصال بالانترنت',
  //         style: TextStyle(
  //             fontWeight: FontWeight.bold
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //       messageText: Text(
  //         'يرجى فحص الاتصال بالشبكة',
  //         textAlign: TextAlign.center,
  //       ),
  //     );
  //   }


  // }

  loginUsingGoogle(BuildContext context) async {
    if (ConnectivityService.connectivityStatus ==
        ConnectivityHStatus.online) {
      UserCredential userCredential = await Auth.auth.signInWithGoogle();
      Logger().d(userCredential.user.email);
      Logger().d(userCredential.user.displayName);
      Logger().d(userCredential.user.uid);
      String socialId = userCredential.user.uid;
      String displayName = userCredential.user.displayName;
      String email = userCredential.user.email;
      String phoneNumber = userCredential.user.phoneNumber??'';
      String type = 'gmail';
      socialMediaLogin(socialId, displayName, '', email, type,context);
    }else{
      Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
        titleText:  Text(
          'لا يوجد اتصال بالانترنت',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          'يرجى فحص الاتصال بالشبكة',
          textAlign: TextAlign.center,
        ),
      );
    }


  }

  signInWithFacebook(BuildContext context) async {

    if (ConnectivityService.connectivityStatus ==
        ConnectivityHStatus.online) {
      Map userData = await Auth.auth.signInWithFacebook();
      Logger().d(userData);
      String socialId = userData['id'] ;
      String displayName = userData['name'];
      String email = userData['email'] ;
      String type = 'facebook';
      Logger().d(userData['name']);
      Logger().d(userData);
      Logger().d(userData['email']);
      Logger().d(userData['id']);
      socialMediaLogin(socialId, displayName, '', email, type,context);
    }else{
      Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
        titleText:  Text(
          'لا يوجد اتصال بالانترنت',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          'يرجى فحص الاتصال بالشبكة',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
