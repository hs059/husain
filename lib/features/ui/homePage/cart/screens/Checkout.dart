import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/navigator.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';

import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartAddressWidget.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/dialogConfirmOrder.dart';

import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:beauty/value/colors.dart';

import 'changeDeliveryAddress.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: appBarCart(title: 'Check Out'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID',
                    style: kSectionText,
                  ),
                  Text(
                    'ID5439',
                    style: kSeeAll,
                  )
                ],
              ),
            ),
            CartAddressWidget(
              address: '147 Al Riyadh, Saudi Arabia',
              name: 'Wonderful customer',
              phone: '+970592724106',
              typeAddress: 1,
              changeBtn: true,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeDeliveryAddress(),
                  )),
            ),
            ContainerCart(
              // height: 210,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        'Delivery Time Settings',
                        style: kSectionText,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Card(
                    color: Color(0xffF5F8FD),
                    child: ListTile(
                      onTap: () =>
                          Provider.of<UiProvider>(context, listen: false)
                              .selectDate(context),
                      title: Text(
                        '${uiProvider.selectedDate.year}/${uiProvider.selectedDate.month}/${uiProvider.selectedDate.day}',
                        style: kGrayText33,
                      ),
                      trailing: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Card(
                    color: Color(0xffF5F8FD),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: uiProvider.timeCheckOut,
                            onChange: uiProviderFalse.setTimeCheckOut,
                          ),
                        );
                      },
                      title: Text(
                        uiProvider.timeCheckOut.format(context),
                        style: kGrayText33,
                      ),
                      trailing: Icon(Icons.access_time_outlined),
                    ),
                  ),
                  // SizedBox(
                  //   height: ScreenUtil().setHeight(10),
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       DatePicker.showDateTimePicker(context,
                  //           showTitleActions: true,
                  //           minTime: DateTime(2020, 3, 5),
                  //           maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                  //         print('change $date');
                  //       }, onConfirm: (date) {
                  //         print('confirm $date');
                  //         print('${date.year}-${date.month}-${date.day}');
                  //         print('${date.hour}:${date.minute}');
                  //         uiProviderFalse.setDateSlot(
                  //             '${date.year}-${date.month}-${date.day}');
                  //         uiProviderFalse
                  //             .setTimeSlot('${date.hour}:${date.minute}');
                  //       }, currentTime: DateTime.now(), locale: LocaleType.ar);
                  //     },
                  //     child: Text(
                  //       "Set Time & Date",
                  //       style: kSeeAll,
                  //     )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setHeight(15), vertical: 5),
              child: Container(
                width: ScreenUtil().setWidth(343),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(15),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: sCardShadow,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10),
                        horizontal: ScreenUtil().setWidth(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Order Bill',
                            style: kSectionText,
                          ),
                        ],
                      ),
                    ),
                    MyDivider(),
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                Expanded(
                                  child: Text(
                                    'Order List',
                                    style: kGrayText33,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setHeight(15)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: '12 Items',
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            '12 Items',
                                            style: kGrayText33,
                                          ),
                                          value: '12 Items',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            '15 Items',
                                            style: kGrayText33,
                                          ),
                                          value: '15 Items',
                                        ),
                                      ],
                                      onChanged: (String value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                              ),
                              child: MyDivider(),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Text(
                            'Total Price',
                            style: kGrayText33,
                          ),
                          trailing: Text(
                            '637.00 S.R',
                            style: kGrayText33,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                          ),
                          child: MyDivider(),
                        ),
                        ListTile(
                          leading: Text(
                            'Order Bill',
                            style: kGrayText33,
                          ),
                          trailing: Text(
                            '\$10.05',
                            style: kGrayText33,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                          ),
                          child: MyDivider(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Bill',
                                style: kSeeAll,
                              ),
                              Text(
                                '\$66.73',
                                style: kSeeAll,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ContainerCart(
              // height: 260,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: kSectionText,
                      ),
                      GestureDetector(
                        onTap: null,
                        child: Text(
                          'Add new Method',
                          style: kSeeAll,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: RadioListTile(
                      activeColor: kPinkLight,
                      value: paymentList[0],
                      groupValue: uiProvider.paymentGroup,
                      onChanged: (value) {
                        uiProviderFalse.setPaymentGroup(value);
                      },
                      title: Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextFormField(
                          hintText: '**** ****  *368',
                          password: true,
                          type: SvgPicture.asset(
                            'assets/svg/cashCart.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: RadioListTile(
                      activeColor: kPinkLight,
                      value: paymentList[1],
                      groupValue: uiProvider.paymentGroup,
                      onChanged: (value) {
                        uiProviderFalse.setPaymentGroup(value);
                      },
                      title: Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextFormField(
                          password: true,
                          hintText: '**** ****  *368',
                          type: Container(
                            height: ScreenUtil().setHeight(50),
                            width: ScreenUtil().setWidth(60),
                            child: SvgPicture.asset(
                              'assets/svg/visa.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: RadioListTile(
                      activeColor: kPinkLight,
                      value: paymentList[2],
                      groupValue: uiProvider.paymentGroup,
                      onChanged: (value) {},
                      title: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          'Cash to Driver',
                          style: kSectionText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerCart(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Note',
                        style: kSectionText,
                      ),
                    ],
                  ),
                  TextField(
                    maxLines: null,
                    onChanged: (String txt) {},
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF313A44),
                    ),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something you want here...'),
                  ),

                  // Note
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            bottomNavigationBarCart(
              widget: Text(
                'Confirm Order',
                style: kBtnText,
              ),
              onTap: () async{
                bool isLogin =await SPHelper.spHelper.getIsLogin()??false;
                if(!isLogin){
                  Fluttertoast.showToast(
                      msg: 'يجب عليك تسجيل الدخول',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      textColor: Color(0xffDAA095),
                      fontSize: 16.0
                  );
                  kNavigatorPush(context, SignIn());
                }else{
                  showDialog(
                    context: context,
                    builder: (context) => DialogConfirmOrder(),
                  );
                }

              },

            ),
            // SizedBox(
            //   height: MediaQuery.of(context).viewInsets.bottom,
            // )
            //
          ],
        ),
      ),

      // bottomNavigationBar: bottomNavigationBarCart(
      //   onTap: () {
      //     kNavigatorPush(context, SignIn());
      //
      //   },
      //   widget: Text(
      //     'Confirm Order',
      //     style: kBtnText,
      //   ),
      // ),
    );
  }
}

// showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//
//     content: Container(
//       child: Wrap(
//         children: [
//           TitleSubTitle(
//             title: 'Order Success',
//             subTitle:
//                 'Your order is being processed by the system, you can see the progress at',
//           ),
//           SizedBox(
//             height: ScreenUtil().setHeight(10),
//           ),
//           SvgPicture.asset(
//             'assets/svg/endOrder.svg',
//             fit: BoxFit.contain,
//           )
//         ],
//       ),
//     ),
//   ),
// );
