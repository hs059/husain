


import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';

import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShowProduct extends StatelessWidget {
  final  String title ;
  ShowProduct({
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider =    Provider.of<ApiProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title: title),
        body: Padding(
          padding:  EdgeInsets.only(
            top: ScreenUtil().setHeight(5),
            left: ScreenUtil().setWidth(10),
            right: ScreenUtil().setWidth(10),),
          child: Consumer<ApiProvider>(
            builder: (context, value, child) {
              ProductModel product = value.productByBrand ;
              if(product!=null){
                if(product.data.isEmpty){
                  return Center(
                    child: Text(
                      'سيتم اضافتها قريبا',
                      style:
                      kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                    ),
                  );
                }else{
                  return   Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: product.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child:  ProductItemGrid(
                              imagePath: 'assets/images/3beauty.png',
                              title: product.data[index].name,
                              rating: 4,
                              prize: product.data[index].price,
                              fav: product.data[index].isFavourited,
                          product:product.data[index] ,),
                        );
                      },
                    ),
                  );
                }
              }else{
                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.80,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10

                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return LoaderGif2();
                  },
                );
              }

            },
          ),
        ),
      ),
    );
  }
}
