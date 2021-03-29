import 'dart:convert';
import 'dart:math';

import 'package:beauty/services/sp_helper.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class Auth {
  Auth._();
  static final Auth auth = Auth._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    await GoogleSignIn().signOut();

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    Logger().d(  userCredential.user.email);
    Logger().d(  userCredential.user.displayName);
    Logger().d(  userCredential.user.uid);
    Logger().d( userCredential.user.phoneNumber);
    Logger().d( userCredential.user.photoURL);

    return  userCredential;
  }
Future<Map> signInWithFacebook() async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      await FacebookAuth.instance.logOut() ;
      AccessToken accessToken = await FacebookAuth.instance
          .login(permissions: ["email", "public_profile"]);
      Logger().d(accessToken.token);
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      Logger().d(userData);
      String name = userData['name'];
      String email = userData['email'] ;
      String id = userData['id'] ;
      Logger().d(userData['name']);
      Logger().d(userData['email']);
      Logger().d(userData['id']);

      bool done = userData.isNotEmpty;
      return userData ;
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


  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    Logger().d(  userCredential.user.email);
    Logger().d(  userCredential.user.displayName);
    Logger().d(  userCredential.user.uid);
    Logger().d( userCredential.user.phoneNumber);
    Logger().d( userCredential.user.photoURL);
    return userCredential;
  }



  signOut() async {
    SPHelper.spHelper.setIsLogin(false);
    SPHelper.spHelper.setUser('');
    SPHelper.spHelper.setToken('');
    firebaseAuth.signOut();
  }

}
