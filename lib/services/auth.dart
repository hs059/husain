//
//
//
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// Future<bool> loginUsingGoogle() async {
//   try {
//     sharedPreferences = await initSp();
//     GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleSignInAuthentication =
//     await googleSignInAccount.authentication;
//     String accessToken = googleSignInAuthentication.accessToken;
//     String idToken = googleSignInAuthentication.idToken;
//     AuthCredential authCredential =  GoogleAuthProvider.getCredential(
//         idToken: idToken, accessToken: accessToken);
//     AuthResult authResult =
//     await firebaseAuth.signInWithCredential(authCredential);
//     String userId =  authResult.user.uid;
//     sharedPreferences.setString('userId', userId);
//     sharedPreferences.setBool('isLogin', true);
//     if (authResult.user == null) {
//       return false;
//     } else {
//       return true;
//     }
//
//   } catch (e) {
//     print(e);
//   }
// }
// class Auth {
//   Auth._();
//   static final Auth auth = Auth._();
//   GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<bool> loginUsingGoogle() async {
//     try {
//       GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//       GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       String accessToken = googleSignInAuthentication.accessToken;
//       String idToken = googleSignInAuthentication.idToken;
//       AuthCredential authCredential =  GoogleAuthProvider.getCredential(
//           idToken: idToken, accessToken: accessToken);
//       AuthResult authResult =
//       await firebaseAuth.signInWithCredential(authCredential);
//       String userId =  authResult.user.uid;
//
//       if (authResult.user == null) {
//         return false;
//       } else {
//         return true;
//       }
//
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }