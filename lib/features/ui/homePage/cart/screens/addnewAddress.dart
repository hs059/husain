import 'package:beauty/components/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/uiProvider.dart';

import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse = Provider.of<UiProvider>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarCart(title: 'Add new Address'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenUtil().setHeight(64),
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
                        items: <DropdownMenuItem>[
                     ...  addressIcon.map((e) => DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(30)
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/$e.svg',
                                fit: BoxFit.contain,color: Color(0xff121924),
                                width: ScreenUtil().setWidth(18),
                                height: ScreenUtil().setHeight(18),
                              ),
                            ),
                            value: e,
                          ),).toList()

                        ],
                        onChanged: (value)  {
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
                    decoration: BoxDecoration(
                      color: Color(0xffF5F8FD),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1.0, color: kBorder),
                    ),
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
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
                      },
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
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  suffixIcon: SvgPicture.asset(
                    'assets/svg/locationBtn.svg',
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil().setWidth(32),
                    fit: BoxFit.contain,
                  ),
                  hintText: 'Your Address',
                  hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
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
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'House number and street ',
                  hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
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
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'Apartment, suite, unit, etc. (my choice) ',
                  hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
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
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
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
                },
              ),
            ),

            GestureDetector(
              onTap: () {
                uiProviderFalse.toggleGroupValueNewAddress();
                print('uiProvider.toggle');
              },
              child: RadioListTile(
                activeColor: kPinkLight,
                value:'Default',
                groupValue: uiProvider.toggle?'Default':'0',
                onChanged: (value) {
                  uiProviderFalse.toggleGroupValueNewAddress();

                },
                title: Text(
                  'Default Delivery Address',
                  style: kSectionText,
                ),
              ),
            ),

            Button(text: 'Save', onTap: null),
          ],
        ),
      ),
    );
  }
}
