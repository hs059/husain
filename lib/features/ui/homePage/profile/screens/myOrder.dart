import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class MyOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title: 'My Order'),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),

          itemCount: 20,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => ContainerCart(
            // height: 320,
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Order Bill',
                    style: kGrayText33,
                  ),
                  trailing: Text(
                    '#OD2204s',
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
                        Text(
                          'Order List',
                          style: kGrayText33,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(150),
                        ),
                        Expanded(
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
                              onChanged: (String value) {

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                MyDivider(),
                ListTile(
                  leading: Text(
                    'Total Bill',
                    style: kGrayText33,
                  ),
                  trailing: Text(
                    '637.00 S.R',
                    style: kGrayText33,
                  ),
                ),
                MyDivider(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
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
                            'Shipping',
                            style: kBtnText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
        bottomNavigationBar: bottomNavigationBarCart(
          onTap: (){
            Navigator.pop(context);
            tabController.animateTo(0);
          },
          widget: Text(
            'Go to Shopping',
            style: kBtnText,
          ),
        ),
      ),
    );
  }
}
