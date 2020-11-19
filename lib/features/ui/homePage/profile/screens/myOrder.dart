import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/model/myOrderModel.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/profile/widgets/cartItemMyOrder.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse =
    Provider.of<UiProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title: 'My Order'),


        body: Consumer<ApiProvider>(
          builder: (context, value, child) {
            MyOrderModel myOrders = value.myOrderModel;

            if (myOrders == null || myOrders.data.isEmpty) {

              if(myOrders ==null){
                return Column(
                  children: [
                    SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context)
                            .accentColor
                            .withOpacity(0.2),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            kPinkLight),
                      ),
                    ),

                  ],
                );
              }  else{
                return Center(
                  child: Text(
                    'لا يوجد طلبات ',
                    style: kSeeAll.copyWith(
                        fontFamily: 'Cairo-Regular', fontSize: 18),
                  ),
                );
              }
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: myOrders.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Data myOrder = myOrders.data[index];
                  return ContainerCart(

                    // height: 320,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'رقم الطلب',
                            style: kGrayText33,
                          ),
                          trailing: Text(
                            myOrder.id.toString(),
                            style: kSeeAll.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            MyDivider(),
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
                                            textDirection: TextDirection.rtl,
                                            child: SimpleDialog(
                                              contentPadding: EdgeInsets.all(
                                                  15),
                                              titlePadding: EdgeInsets
                                                  .symmetric(
                                                  horizontal: 15, vertical: 20),
                                              title: Row(
                                                children: <Widget>[
                                                  Icon(Icons.category),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'جميع الطلبات',
                                                  )
                                                ],
                                              ),
                                              children: myOrder.products.map((
                                                  e) =>
                                                  CartItemMyOrder(
                                                    product: e,
                                                  ),).toList(),
                                            ),
                                          );
                                        });
                                  },

                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setHeight(15)),
                                    child: Row(
                                      children: [
                                        Text(
                                          myOrder.products.length.toString(),
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

                          ],
                        ),

                        MyDivider(),
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
                        MyDivider(),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الحالة',
                                style: kGrayText33,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(34),
                                width: ScreenUtil().setWidth(102),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0095FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    myOrder.status.toString(),
                                    style: kBtnText,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },

              );
            }
          },
        ),

        bottomNavigationBar: bottomNavigationBarCart(
          onTap: () {
            Navigator.pop(context);
            tabControllerConstant.animateTo(0);
          },
          widget: Text(
            'اذهب للتسوق',
            style: kBtnText,
          ),
        ),
      ),
    );
  }
}
