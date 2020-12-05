import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:beauty/components/model/productM.dart' as productClass;

class BrandProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, value, child) {
        if(value.productM !=null){
          List<productClass.Brand> brand = value.productM.data.brand ;
          if(brand.isNotEmpty){
            String image ;
           value.brand.data.brands.map((element) {
             if(element.id ==brand.first.termId ){
               image  = element.image ;

             }
           }).toList();

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '100% original',
                          style: kDiscount,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        //ToDo:ShowProduct brand
                        GestureDetector(
                          onTap: () {
                            value.getProductByBrand(brand.first.termId);
                            kNavigatorPush(context, ShowProduct(title: brand.first.name,));
                          },
                          child: Text(
                            'See more of the same brand',
                            style: kSubProductTitle,
                          ),
                        ),
                      ],
                    ),
                    CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) => LoaderGif1(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,
                              height: ScreenUtil().setHeight(80),
                              width: ScreenUtil().setWidth(80),
                            ),
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().setWidth(80),
                        fit: BoxFit.contain
                    ),
                  ],
                ),
                MyDivider(),
              ],
            );
          }else{
            return Container();
          }

        }else{
          return   Container();
        }

      },
    );
  }
}
