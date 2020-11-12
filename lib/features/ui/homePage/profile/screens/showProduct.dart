


import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';

import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowProduct extends StatelessWidget {
  final  String title ;
  ShowProduct(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCart(title: title),
      body: Padding(
        padding:  EdgeInsets.only(
          top: ScreenUtil().setHeight(5),
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10),),
        child: Container(
              height: double.infinity,
              width: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.80,
                  ),
            itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(

                      child:  ProductItemGrid(
                          imagePath: 'assets/images/3beauty.png',
                          title: 'perfoume',
                          rating: 4,
                          prize: '122',
                          fav: false),
                    );
                  },
          ),
        ),
      ),
    );
  }
}
