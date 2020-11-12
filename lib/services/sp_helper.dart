import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  setToken(String value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('Token', value);
  }

  Future<String> getToken() async {
    sharedPreferences = await initSharedPrefrences();
    String x = sharedPreferences.getString('Token');
    return x;
  }

  setUser(int value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setInt('userId', value);
  }

  Future<int> getUser() async {
    sharedPreferences = await initSharedPrefrences();
    int x = sharedPreferences.getInt('userId');
    return x;
  }

  setIsLogin(bool value)async{
    sharedPreferences = await initSharedPrefrences() ;
    sharedPreferences.setBool('isLogin', value);
  }
  Future<bool> getIsLogin()async{
    sharedPreferences = await initSharedPrefrences();
  bool x=  sharedPreferences.getBool('isLogin');
  return x ;
  }
  isSeenOnBoardingSet(bool value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setBool('isSeen', value);
  }

  Future<bool> isSeenOnBoardingGet() async {
    sharedPreferences = await initSharedPrefrences();
    bool x = sharedPreferences.getBool('isSeen');
    return x;
  }
}
