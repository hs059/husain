import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {

  String emailIn;
  String passwordIn;

  saveEmailIn(String value) {
    this.emailIn = value;
    notifyListeners();
  }

  savePasswordIn(String value) {
    this.passwordIn = value;
    notifyListeners();
  }

  String emailUp;
  String passwordUp;
  String conformPasswordUp;

  saveEmailUp(String value) {
    this.emailUp = value;
    notifyListeners();
  }

  savePasswordUp(String value) {
    this.passwordUp = value;
    notifyListeners();
  }
  saveConformPasswordUp(String value) {
    this.conformPasswordUp = value;
    notifyListeners();
  }

  String emailForget;

  saveEmailForget(String value) {
    this.emailForget = value;
    notifyListeners();
  }

  String newPassword;

  saveNewPassword(String value) {
    this.newPassword = value;
    notifyListeners();
  }
  String confirmPassword;

  saveConfirmPassword(String value) {
    this.confirmPassword = value;
    notifyListeners();
  }

  String fullName ;
  saveFullName(String value) {
    this.fullName = value;
    notifyListeners();
  }



  ////////////////////////////////////////////////////////////
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
    } else if (value.length<4) {
      return 'name at least 4 Letters';
    }
  }
  String validatePhone(String value) {
    if (value == null || value == '') {
      return ' this field is required ';
    } else if (!isNumeric(value)) {
      return 'invalid number ';
    } else if (value.length!=9) {
      return 'phone number must be equal 9 numbers';
    }
  }


//////////////////////////////////////////////////////
  bool submit(GlobalKey<FormState> globalKey) {
    bool auth =false ;
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      auth =true ;
      notifyListeners();
      return auth ;
    } else {
      auth =false;

      notifyListeners();
      return auth;
    }
  }
}
