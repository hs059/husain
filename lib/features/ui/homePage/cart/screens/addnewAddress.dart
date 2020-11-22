import 'package:beauty/services/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'changeDeliveryAddress.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';

import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  String name;

  String houseNum;

  String apartment;

  String phoneNum;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(21.324220, 39.114267);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarCart(title: 'إضافة عنوان جديد'),
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<UiProvider>(context).spinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenUtil().setHeight(58),
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffF5F8FD),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1.0, color: kBorder),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: uiProvider.addressDropDown,
                            isExpanded: true,
                            items: addressIcon
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(30)),
                                        child: SvgPicture.asset(
                                          'assets/svg/$e.svg',
                                          fit: BoxFit.contain,
                                          color: Color(0xff121924),
                                          width: ScreenUtil().setWidth(18),
                                          height: ScreenUtil().setHeight(18),
                                        ),
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList()
                            ,
                            onChanged: (value) {
                              uiProviderFalse.setAddressDropDown(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xffF5F8FD),
                          borderRadius: BorderRadius.circular(8.0),
                          border:
                              Border.all(width: 1.0, color: Color(0xffedf1f7)),
                        ),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            this.name = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'الاسم',
                            hintStyle: TextStyle(
                                color: Color(0xff8F9BB3), fontSize: 15),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffF5F8FD),
                              width: ScreenUtil().setWidth(2),
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffF5F8FD),
                              width: ScreenUtil().setWidth(2),
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffF5F8FD),
                              width: ScreenUtil().setWidth(0.5),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FD),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                  ),
                  child: ListTile(
                    title: Text(
                      Location.location.currentAddress ?? '',
                      style: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                    ),
                    trailing: GestureDetector(
                      onTap: () async {
                        await _getAddressFromLatLng();
                        print(_currentAddress);
                      },
                      child: SvgPicture.asset(
                        'assets/svg/locationBtn.svg',
                        height: ScreenUtil().setHeight(32),
                        width: ScreenUtil().setWidth(32),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FD),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      this.houseNum = value;
                      setState(() {});
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'رقم المبنى',
                      hintStyle:
                          TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(2),
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(2),
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(0.5),
                      )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FD),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      this.apartment = value;
                      setState(() {});
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'رقم الشقة',
                      hintStyle:
                          TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(2),
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(2),
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xffF5F8FD),
                        width: ScreenUtil().setWidth(0.5),
                      )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FD),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1.0, color: kBorder),
                  ),
                  child: IntlPhoneField(
                    validator: authProvider.validatePhone,
                    onSaved: (newValue) {
                      print(newValue.completeNumber);
                      authProvider.saveMobile(newValue.completeNumber);
                    },
                    autoValidate: false,
                    decoration: InputDecoration(
                      hintText: 'رقم الهاتف',
                      hintStyle:
                          TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBorder, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBorder, width: 1.0),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    showDropdownIcon: false,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      this.phoneNum = phone.completeNumber;
                    },
                  ),
                ),
                ListTile(
                  leading: CheckDefualtAddress(),
                  title: Text(
                    'عنوان التوصيل الافتراضي',
                    style: kSectionText,
                  ),
                ),
                Button(
                    text: 'حفظ',
                    onTap: () async {
                      print(
                          'addressDropDown = ${uiProvider.addressDropDown} phoneNum = $phoneNum _currentAddress = $_currentAddress  houseNum =$houseNum  apartment = $apartment isDefault = ${uiProvider.defualtAddress} ');
                      Provider.of<ApiProvider>(context, listen: false)
                          .addNewAddress(
                          uiProvider
                                  .addressDropDown,
                              phoneNum,
                              _currentAddress.toString(),
                              houseNum,
                              apartment,
                          uiProvider.defualtAddress,
                              context);
                      String token = await SPHelper.spHelper.getToken();
                      print(token);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckDefualtAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);
    UiProvider uiProvider = Provider.of<UiProvider>(
      context,
    );
    return InkWell(
      onTap: () {
        uiProviderFalse.toggleDefualtAddress();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kPinkLight, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: uiProvider.defualtAddress
              ? Icon(
                  Icons.circle,
                  size: 20.0,
                  color: kPinkLight,
                )
              : Icon(
                  Icons.circle,
                  size: 20.0,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

