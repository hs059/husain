import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/components/model/productModel.dart' as productModelClass;
import 'package:beauty/features/ui/homePage/widgets/productItemFav.dart';

import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title: 'المفضلة'),
        body: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(5),
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
            ),
            child: Consumer<ApiProvider>(
                builder: (context, value, child) {
                  productModelClass.ProductModel productsFav =value.productFav ;

                  if (productsFav !=null) {
                    if(productsFav.data.isEmpty){
                      return Center(
                        child: Text(
                          'لم يتم التحديد بعد',
                          style: kSeeAll.copyWith(
                              fontFamily: 'Cairo-Regular', fontSize: 18),
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
                          itemCount: productsFav.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child:  ProductItemFav(
                                imagePath: productsFav.data[index].image ,
                                title: productsFav.data[index].name,
                                rating: 4,
                                prize: productsFav.data[index].price,
                                fav: productsFav.data[index].isFavourited,
                                product:productsFav.data[index],
                              index: index,),
                            );
                          },
                        ),
                      );
                    }
                  }else{
                    return   Column(
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
                        GridView.builder(
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
                        )
                      ],
                    );
                  }
                },
            )),
      ),
    );
  }
}
