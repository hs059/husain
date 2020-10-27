


import 'package:beauty/components/btn.dart';
import 'package:beauty/features/ui/homePage/cart/screens/addnewAddress.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartAddressWidget.dart';
import 'package:beauty/value/navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeDeliveryAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCart(title: 'Check Out'),
      body: Container(
        child: Column(
          children: [
            CartAddressWidget(address:'147 Al Riyadh, Saudi Arabia', name:'Mahmoud Thari', phone:'+970592724106', typeAddress:1,),
            CartAddressWidget(address:'147 Al Riyadh, Saudi Arabia', name:'Mahmoud Thari', phone:'+970592724106', typeAddress:2,),
            CartAddressWidget(address:'147 Al Riyadh, Saudi Arabia', name:'Mahmoud Thari', phone:'+970592724106', typeAddress:3,),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Button(text: 'Add new Address',onTap: ()=>kNavigatorPush(context, AddNewAddress()),),
            ),
          ],

        ),
      ),

    );
  }
}
