import 'package:beauty/services/connectivity.dart';
import 'package:beauty/services/location.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beauty/value/string.dart';
import 'package:get/get.dart';


class UiProvider extends ChangeNotifier {
  IconData iconData = FontAwesomeIcons.eyeSlash;
  bool toggleEye = true;
  bool edit = false ;
  fmToggleEye() {
    toggleEye = !toggleEye;
    iconData = toggleEye ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      this.selectedDate = picked;
      notifyListeners();
    }
    notifyListeners();
  }
  String groupValue  = sort[0];
    setGroupValue(String value){
      this.groupValue = value ;
      notifyListeners();
    }
  String groupValueNewAddress  = 'default';
  setGroupValueNewAddress(String value){
      this.groupValueNewAddress = value ;
      notifyListeners();
    }
    bool toggle = false ;
  toggleGroupValueNewAddress(){
    this.toggle = !toggle ;
    notifyListeners();
  }
  String riyadhGroup ;
  setRiyadhGroup(String value){
    this.riyadhGroup = value ;
    notifyListeners();
  }
  String language ='en';
  setLanguage(String value){
    this.language = value ;
    notifyListeners();
  }
  String addressDropDown = addressIcon[0] ;
  setAddressDropDown(String value){
    this.addressDropDown = value;
    notifyListeners();
  }
  String timeSlot=' - - ' ;
  setTimeSlot(String value){
    timeSlot = value ;
    notifyListeners();
  }
  String dateSlot=' - - ' ;
  setDateSlot(String value){
    dateSlot = value ;
    notifyListeners();
  }


  bool spinner = false;
  toggleSpinner() {

      spinner = !spinner;
      notifyListeners();

  }


  TimeOfDay timeCheckOut = TimeOfDay.now();

  setTimeCheckOut(TimeOfDay timeOfDay){
    this.timeCheckOut  = timeOfDay ;
    notifyListeners();
  }

  DateTime date ;
  setTimePicker(DateTime value ){
    this.date  = value ;
    notifyListeners();
  }



  bool loading = false ;
  setLoading(bool value){
    this.loading = value ;
    notifyListeners() ;
  }
  bool defualtAddress = false;

  toggleDefualtAddress(){
    this.defualtAddress = !this.defualtAddress ;
    notifyListeners() ;
  }

String  address = Location.location.currentAddress??'' ;
  setNewAddress(String value){
    this.address = value ;
    notifyListeners();
  }
}