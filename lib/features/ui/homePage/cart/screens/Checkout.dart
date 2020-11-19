import 'package:beauty/components/model/lineItems.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemCheckOut.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemWidget.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/date&time.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/value/constant.dart';

import 'cartScreen.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/db_provider.dart';
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
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);
    List<ProductSql> allProducts =  Provider.of<DBProvider>(context).allProducts;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
              apiProvider.addressSelected !=null? CartAddressWidget(
                address: apiProvider.addressSelected ==null?'aaaaaaaaaa':apiProvider.addressSelected.fullAddress,
                name: authProvider.showProfileModel==null?'aaaaaa':authProvider.showProfileModel.data.displayName,
                phone: apiProvider.addressSelected ==null? '55555':apiProvider.addressSelected.phone,
                typeAddress: apiProvider.addressSelected.type ==addressIcon[0]?1:apiProvider.addressSelected.type ==addressIcon[1]?2:apiProvider.addressSelected.type ==addressIcon[2]?3:1,
                changeBtn: true,
                onTap: () =>kNavigatorPush(context, ChangeDeliveryAddress()),
              ):ContainerCart(
                child: SizedBox(
                  width: ScreenUtil().setWidth(311),
                  height: ScreenUtil().setHeight(80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/adress1.png',fit: BoxFit.contain,),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Button(
                        text: 'أختر عنوان',
                        onTap: () =>kNavigatorPush(context, ChangeDeliveryAddress()),
                      ),
                    ],
                  ),
                ),
              ),
              DateAndTime(),
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
                              'اجمالي الفاتورة',
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
                                      'الطلبات',
                                      style: kGrayText33,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:  () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: SimpleDialog(
                                                contentPadding: EdgeInsets.all(15),
                                                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                                title: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.category),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'جميع الطلبات',
                                                    )
                                                  ],
                                                ),
                                                children: allProducts.map((e) => CartItemCheckOut(
                                                  productSql: e,
                                                ),).toList(),
                                              ),
                                            );
                                          });
                                    },

                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setHeight(15)),
                                      child:  Row(
                                        children: [
                                          Text(
                                            allProducts.length.toString(),
                                            style: kGrayText33,
                                          ),

                                          Text(
                                            '  طلب',
                                            style: kGrayText33,
                                          ),
                                          Icon(Icons.arrow_drop_down,color: Color(0xff8F9BB3))
                                        ],
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

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السعر الكلي',
                                  style: kSeeAll,
                                ),
                                Text(
                                  220.toString() + ' ' + currency,
                                  style: kSeeAll,
                                  textAlign: TextAlign.center,
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
                    Provider.of<ApiProvider>(context,listen: false).createOrder( 'hussein', 'aaa', 'pal', 'ccc',
                        [
                          LineItems(
                            productId: '29',
                            quantity: '3',
                          ).toJson(),
                          LineItems(
                            productId: '103',
                            quantity: '5',
                          ).toJson(),
                        ]
                    );
                    showDialog(
                      context: context,
                      builder: (context) => DialogConfirmOrder(
                        onTap: ()async{
                        kNavigatorPushReplacement(context, HomePage());
                        },
                      ),
                    );
                  }

                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}


