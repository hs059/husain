

import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProductSection.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Section extends StatelessWidget {
  final int num ;
  Section({this.num = 1});
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, value, child) {
        SectionModel section = num==1? value.latestProducts:num==2?value.customCategory:value.mostRated;
        return section!=null? Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(section.data.sectionTitle,style: kSectionText.copyWith(
                    fontSize: ScreenUtil().setSp(18),
                          fontFamily: 'Cairo-Regular'
                  ),),
                  GestureDetector(
                    onTap: () {

                        kNavigatorPush(context, ShowProductSection(title: section.data.sectionTitle,num: num,));

                    },
                    child:Text('رؤية الكل',style: kSeeAll.copyWith(
                      fontFamily: 'Cairo-Regular'
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              height: ScreenUtil().setHeight(300),
              padding:  EdgeInsets.only(right: ScreenUtil().setWidth(8)),
              alignment: Alignment.center,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                primary: false,
                shrinkWrap: true,
                itemCount:section.data.products.length ,
                itemBuilder: (context, index) {
                  Products product = section.data.products [index];
                  return  AnimationCart(
                    index:index ,
                    Grid: false,
                    count:section.data.products.length ,
                    duration: 700,
                    child: ProductItemList(
                      title: product.name,
                      fav: product.isFavourited,
                      imagePath: product.image,
                      prize:product.price,
                      rating: 4.5,
                      product: product,
                    ),
                  );
                },
              ),
            ),
          ],
        ): Container(
          height: ScreenUtil().setHeight(300),
          alignment: Alignment.center,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount:10 ,
            itemBuilder: (context, index) {
              return  Container(
                width: ScreenUtil().setWidth(200),
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                  child: LoaderGif2()
              );
            },

          ),
        )
        ;
      },
    );
  }
}
