import 'package:beauty/components/model/allAddressModel.dart' as addressClass;
import 'package:beauty/components/model/lineItems.dart';
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemCheckOut.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemWidget.dart';
import 'package:beauty/features/ui/homePage/homePage.dart';
import 'package:beauty/services/location.dart';
import 'package:beauty/value/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cartScreen.dart';
import 'fatoorah.dart';
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/navigator.dart';

import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartAddressWidget.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/dialogConfirmOrder.dart';

import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:beauty/value/colors.dart';

import 'changeDeliveryAddress.dart';

class CheckOut extends StatelessWidget {
  var _controller = TextEditingController();
  double prizeCoupon =0.0;
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DBProvider dbProvider = Provider.of<DBProvider>(context);
    DBProvider dbProviderFalse =
        Provider.of<DBProvider>(context, listen: false);
    ApiProvider apiProviderFalse =
        Provider.of<ApiProvider>(context, listen: false);
    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);
    List<ProductSql> allProducts = Provider.of<DBProvider>(context).allProducts;
    List<addressClass.Data> deffult;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: appBarCart(title: 'إتمام الطلب'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                apiProvider.addressSelected != null
                    ? CartAddressWidget(
                        address: apiProvider.addressSelected.fullAddress,
                        name: authProvider.showProfileModel.data.displayName,
                        phone: apiProvider.addressSelected.phone,
                        typeAddress: apiProvider.addressSelected.type ==
                                addressIcon[0]
                            ? 1
                            : apiProvider.addressSelected.type == addressIcon[1]
                                ? 2
                                : apiProvider.addressSelected.type ==
                                        addressIcon[2]
                                    ? 3
                                    : 1,
                        changeBtn: true,
                        onTap: () =>
                            kNavigatorPush(context, ChangeDeliveryAddress()),
                      )
                    : Builder(
                        builder: (context) {
                          addressClass.AllAddressModel allAddress =
                              apiProvider.allAddressModel;
                          deffult = allAddress != null
                              ? allAddress.data
                                  .where((element) =>
                                      element.defualtAddress == "true")
                                  .toList()
                              : [];
                          if (deffult.isNotEmpty) {
                            return CartAddressWidget(
                              address: deffult.first.fullAddress,
                              name: authProvider
                                  .showProfileModel.data.displayName,
                              phone: deffult.first.phone,
                              typeAddress: deffult.first.type == addressIcon[0]
                                  ? 1
                                  : deffult.first.type == addressIcon[1]
                                      ? 2
                                      : deffult.first.type == addressIcon[2]
                                          ? 3
                                          : 1,
                              changeBtn: true,
                              onTap: () => kNavigatorPush(
                                  context, ChangeDeliveryAddress()),
                            );
                          } else {
                            return ContainerCart(
                              child: SizedBox(
                                width: ScreenUtil().setWidth(311),
                                height: ScreenUtil().setHeight(80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/adress1.png',
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Button(
                                      text: 'أختر عنوان',
                                      onTap: () => kNavigatorPush(
                                          context, ChangeDeliveryAddress()),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),

                // DateAndTime(),
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
                              GestureDetector(
                                child: Text(
                                  'اجمالي الفاتورة',
                                  style: kSectionText,
                                ),
                                onTap: () => print(deffult.first.iD),
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
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: SimpleDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                  titlePadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 20),
                                                  title: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.category),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'جميع الطلبات',
                                                      )
                                                    ],
                                                  ),
                                                  children: allProducts
                                                      .map(
                                                        (e) => CartItemCheckOut(
                                                          productSql: e,
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setHeight(15)),
                                        child: Row(
                                          children: [
                                            Text(
                                              allProducts.length.toString(),
                                              style: kGrayText33,
                                            ),
                                            Text(
                                              '  طلب',
                                              style: kGrayText33,
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: Color(0xff8F9BB3))
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'السعر الكلي',
                                    style: kSeeAll,
                                  ),
                                  Text(
                                    dbProvider.totalPrize.toStringAsFixed(2) +
                                        ' ' +
                                        currency,
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'أدخل كوبون الخصم',
                                style: kSectionText,
                              ),
                              if (apiProvider.loadCoupon) Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      kPinkLight),
                                ),
                              ) ,
                            ],
                          ),

                        ),
                        MyDivider(),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: apiProvider.setCoupon,
                                validator: authProvider.validateText,
                                controller: _controller,
                                obscureText: false,
                                cursorColor: Colors.grey,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffF5F8FD),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: ScreenUtil().setHeight(35),
                                          width: ScreenUtil().setWidth(35),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kPinkLight,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                                'assets/svg/coupon.svg',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hintText: 'ادخل كوبون الخصم',
                                  labelStyle: TextStyle(
                                      color: Color(0xff8F9BB3), fontSize: 15),
                                  hintStyle: TextStyle(
                                      color: Color(0xff8F9BB3), fontSize: 15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Color(0xffedf1f7))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: ScreenUtil().setWidth(2),
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),

                                      borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: ScreenUtil().setWidth(0.5),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Consumer<ApiProvider>(
                                builder: (context, value, child) {
                                          if(value.couponModel !=null){
                                            return  apiProvider.initialPrizeCoupon? Column(
                                              children: [
                                                apiProvider.couponModel.data !=null?
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'مقدار الخصم',
                                                          style: kSeeAll,
                                                        ),
                                                        Text(
                                                          apiProvider.couponModel.data.amount +
                                                              '%' ,
                                                          style: kSeeAll,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil().setHeight(10),
                                                    ),

                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'السعر بعد الخصم',
                                                          style: kSeeAll,
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            prizeCoupon =  dbProvider.totalPrize - (
                                                                dbProvider.totalPrize *double.parse(
                                                                    apiProvider.couponModel.data ==null?'0': apiProvider.couponModel.data.amount
                                                                )/100);

                                                            return Text(
                                                              prizeCoupon.toStringAsFixed(2) +
                                                                  ' ' +
                                                                  currency,
                                                              style: kSeeAll,
                                                              textAlign: TextAlign.center,
                                                            );
                                                          },

                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ):Container(),

                                                SizedBox(
                                                  height: ScreenUtil().setHeight(10),
                                                ),

                                              ],
                                            ) :Container();
                                          }else{
                                            return Container() ;
                                          }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [

                                  Button(text: 'فحص الكود',  onTap: () {
                                    Provider.of<ApiProvider>(context,listen: false).getCoupon();
                                    Provider.of<ApiProvider>(context,listen: false).setCoupon('');
                                    _controller.clear();
                                  },),

                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                            ],
                          ),
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
                            'طريقة الدفع',
                            style: kSectionText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Column(
                        children: [
                          RadioListTile(
                            activeColor: kPinkLight,
                            value: paymentList[0],
                            groupValue: uiProvider.paymentGroup,
                            onChanged: (value) {
                              uiProviderFalse.setPaymentGroup(value);
                            },
                            title: Text(
                              paymentList[0],
                              style: kSectionText,
                            ),
                          ),
                          RadioListTile(
                            activeColor: kPinkLight,
                            value: paymentList[1],
                            groupValue: uiProvider.paymentGroup,
                            onChanged: (value) {
                              uiProviderFalse.setPaymentGroup(value);
                            },
                            title: Text(
                              paymentList[1],
                              style: kSectionText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ContainerCart(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: Text(
                              'ملاحظة',
                              style: kSectionText,
                            ),
                            onTap: () {
                              print(uiProvider.paymentGroup);
                            },
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
                            hintText: 'أدخل ملاحظتك هنا ...'),
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
                    'تأكيد الطلب',
                    style: kBtnText,
                  ),
                  onTap: () async {
                    if (uiProvider.paymentGroup != null) {
                      if (apiProvider.addressSelected != null) {
                        Provider.of<ApiProvider>(context, listen: false)
                            .createOrder(
                          authProvider.showProfileModel.data.displayName,
                          apiProvider.addressSelected.fullAddress,
                          apiProvider.addressSelected.houseNumber,
                          apiProvider.addressSelected.apartment,
                          allProducts
                              .map((e) => LineItems(
                                    productId: e.idProduct.toString(),
                                    quantity: e.count.toString(),
                                  ).toJson())
                              .toList(),
                        );
                        uiProvider.paymentGroup == paymentList[0]
                            ? kNavigatorPush(context,
                                Fatoorah(prizeCoupon ==0.0 || prizeCoupon ==null ||apiProvider.initialPrizeCoupon ==false?
                                    dbProvider.totalPrize.toString():prizeCoupon.toString())
                        )
                            : showDialog(
                                context: context,
                                builder: (context) => DialogConfirmOrder(
                                  onTap: () async {
                                    dbProviderFalse.deleteAllProduct();
                                    kNavigatorPushAndRemoveUntil(
                                        context, HomePage());
                                  },
                                ),
                              );
                        apiProviderFalse.setInitialPrizeCoupon(false);
                      } else if (deffult.isNotEmpty) {
                        Provider.of<ApiProvider>(context, listen: false)
                            .createOrder(
                          authProvider.showProfileModel.data.displayName,
                          deffult.first.fullAddress,
                          deffult.first.houseNumber,
                          deffult.first.apartment,
                          allProducts
                              .map((e) => LineItems(
                                    productId: e.idProduct.toString(),
                                    quantity: e.count.toString(),
                                  ).toJson())
                              .toList(),
                        );
                        uiProvider.paymentGroup == paymentList[0]
                            ? kNavigatorPush(context,
                                Fatoorah(
                                    prizeCoupon ==0.0 || prizeCoupon ==null||apiProvider.initialPrizeCoupon ==false?
                                    dbProvider.totalPrize.toString():prizeCoupon.toString())
                        )
                            : showDialog(
                                context: context,
                                builder: (context) => DialogConfirmOrder(
                                  onTap: () async {
                                    dbProviderFalse.deleteAllProduct();
                                    kNavigatorPushAndRemoveUntil(
                                        context, HomePage());
                                  },
                                ),
                              );
                        apiProviderFalse.setInitialPrizeCoupon(false);
                      } else {
                        Fluttertoast.showToast(
                            msg: 'أضف عنوان التوصيل',
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                            timeInSecForIosWeb: 1,
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'اختر طريقة الدفع',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                          timeInSecForIosWeb: 1,
                          gravity: ToastGravity.TOP,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
