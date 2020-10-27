
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemWidget.dart';

import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


import 'Checkout.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCart(title: 'Cart'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => CartItemWidget(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBarCart(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckOut(),
            )),
        widget: Row(
          children: [
            Text(
              'Cart price',
              style: kBtnText,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(100),
            ),
            Text(
              'Check Out',
              style: kBtnText,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(40),
            ),
            Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
