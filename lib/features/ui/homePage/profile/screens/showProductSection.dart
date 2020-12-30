

import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';

import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';

import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:beauty/components/model/sectionModel.dart';

import 'package:flutter_screenutil/screenutil.dart';
class ShowProductSection extends StatelessWidget {
  final  String title ;
  final  int num  ;
  ShowProductSection({
    this.title,
    this.num
  });
  @override
  Widget build(BuildContext context) {
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
              SectionModel section = num==1? value.latestProducts:num==2?value.customCategory:value.mostRated;
              if(section!=null){
                if(section.data.products.isEmpty){
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
                        childAspectRatio: 0.60,
                      ),
                      itemCount: section.data.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child:  ProductItemList(
                            imagePath: section.data.products[index].image ,
                            title: section.data.products[index].name,
                            rating: 4,
                            prize: section.data.products[index].price,
                            fav: section.data.products[index].isFavourited,
                            product:section.data.products[index] ,),
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
