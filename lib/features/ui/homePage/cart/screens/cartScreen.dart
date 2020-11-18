
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemWidget.dart';

import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';


import 'Checkout.dart';

class Cart extends StatelessWidget {
  double totalPrize = 0.0 ;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCart(title: 'Cart'),
        body: Consumer<DBProvider>(
          builder: (context, value, child) {
            // value.setAllProducts();
            List<ProductSql> allProduct =  value.allProducts ;
            if(allProduct==null || allProduct.isEmpty ){
          return
                  Center(
                    child: Text(
                    'لا يوجد طلبات بالعربة ',
                    style:
                    kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
            ),
              );
            }else{
              return  ListView.builder(
                itemCount: allProduct.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => CartItemWidget(
                   productSql: allProduct[index],
                ),
              );
            }

          },
        ),
        bottomNavigationBar: Visibility(
          visible: Provider.of<DBProvider>(context).allProducts.isNotEmpty,
          child: bottomNavigationBarCart(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOut(),
                  ));
            },
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
        ),
      ),
    );
  }
}
