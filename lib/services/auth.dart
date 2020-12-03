import 'package:beauty/services/sp_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Auth {
  Auth._();
  static final Auth auth = Auth._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();

  Future<bool> loginUsingGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      String accessToken = googleSignInAuthentication.accessToken;
      String idToken = googleSignInAuthentication.idToken;
      SPHelper.spHelper.setToken(idToken.toString());
      AuthCredential authCredential =  GoogleAuthProvider.credential(
          idToken: idToken, accessToken: accessToken);
      UserCredential authResult =
      await firebaseAuth.signInWithCredential(authCredential);
      String userId =  authResult.user.uid;
      String name = authResult.user.displayName;
      SPHelper.spHelper.setUser(userId.toString());
    SPHelper.spHelper.setIsLogin(true);
      if (authResult.user == null) {
        return false;
      } else {
        return true;
      }

    } catch (e) {
      print(e);
    }
  }
//   void signInTwitter() async {
//     var twitterLogin = new TwitterLogin(
//       consumerKey: 'bsrsIrms09tBGoMGq4WkI1oUE',
//       consumerSecret: 'HGh7K6V7xNteVGDnHQWA9KA2ggkgOfJ8qlChfVxFg6ohoCwb33',
//     );
//
//     final TwitterLoginResult result = await twitterLogin.authorize();
//
//     switch (result.status) {
//       case TwitterLoginStatus.loggedIn:
//         var session = result.session;
//         print('successful sign in: ${session.username}');
// //        _sendTokenAndSecretToServer(session.token, session.secret);
//         break;
//       case TwitterLoginStatus.cancelledByUser:
// //        _showCancelMessage();
//         print('cancelled by user');
//         break;
//       case TwitterLoginStatus.error:
//         print(result.errorMessage);
//         break;
//     }
//   }

  // Future<UserCredential> signInWithTwitter222() async {
  //   // Create a TwitterLogin instance
  //   final TwitterLogin twitterLogin = new TwitterLogin(
  //     consumerKey: '<your consumer key>',
  //     consumerSecret:' <your consumer secret>',
  //   );
  //
  //   // Trigger the sign-in flow
  //   final TwitterLoginResult loginResult = await twitterLogin.authorize();
  //
  //   // Get the Logged In session
  //   final TwitterSession twitterSession = loginResult.session;
  //
  //   // Create a credential from the access token
  //   final AuthCredential twitterAuthCredential =
  //   TwitterAuthProvider.credential(accessToken: twitterSession.token, secret: twitterSession.secret);
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }

   Future<bool> loginUsingFacebook() async {
//    2407536649-ZFNGnaMhK7tCHBYL4rQ2SGT9nkuTbnL8g3aJCxq acc token
//    Niz5D73o0BaUMZU4GHHGCTSpJmIoxmoPIITPeuOH46SMO acc token secret
    try {
      final result = await facebookLogin.logIn(['email']);
      final token = result.accessToken.token;
      print('token ......$token');
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
      print(graphResponse.body);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final credential = FacebookAuthProvider.credential( token);
        firebaseAuth.signInWithCredential(credential);
        return true ;
      }
    } catch (e) {
      Get.snackbar('رسالة تحذير', 'هناك خطأ بالتسجيل باستخدام فيس بوك');
    }
  }



   Future<bool> signInWithFacebook() async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      AccessToken accessToken = await FacebookAuth.instance
          .login(permissions: ["email", "public_profile", "user_friends"]);
      Logger().d(accessToken.token);
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      String name = userData['name'];
      String email = userData['email'] ;
      String id = userData['id'] ;
      Logger().d(userData['name']);
      Logger().d(userData['email']);
      Logger().d(userData['id']);

      bool done = userData.isNotEmpty;
      return done ;
    } catch (e, s) {
      if (e is FacebookAuthException) {
        print(e.message);
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("You have a previous login operation in progress");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("login cancelled");
            break;
          case FacebookAuthErrorCode.FAILED:
            print("login failed");
            Get.snackbar('رسالة تحذير', 'هناك خطأ بالتسجيل باستخدام فيس بوك');

            break;
        }
      }
    }
  }


  signOut() async {
    SPHelper.spHelper.setIsLogin(false);
    SPHelper.spHelper.setUser('');
    SPHelper.spHelper.setToken('');
    firebaseAuth.signOut();
  }

}
