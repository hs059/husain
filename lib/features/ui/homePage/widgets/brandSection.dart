import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("أحدث الماركات العالمية", style: kSectionText.copyWith(
              fontSize: ScreenUtil().setSp(18),
              fontFamily: 'Cairo-Regular',
            ),),
            GestureDetector(
              onTap: () {
                tabControllerConstant.animateTo(3);
              },
              child: Text('رؤية الكل',style: kSeeAll.copyWith(
                  fontFamily: 'Cairo-Regular'
              ),),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        // FutureBuilder<BrandModel>(
        //   future: Provider.of<ApiProvider>(context).getBrand(),
        //   builder: (context, snapshot) {
        //     BrandModel brand = snapshot.data;
        //     return snapshot.hasData?Container(
        //       height: ScreenUtil().setHeight(45),
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         primary: false,
        //         itemCount: brand.data.products.length,
        //         scrollDirection: Axis.horizontal,
        //         physics: const BouncingScrollPhysics(),
        //         itemBuilder: (context, index) =>
        //             InkWell(
        //               // onTap: () =>
        //               //     kNavigatorPush(context, ShowProduct('Paradoxx'),
        //               //     ),
        //               child: Container(
        //                 margin: EdgeInsets.all(4),
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   boxShadow: sCardShadow2,
        //                   borderRadius: BorderRadius.circular(6),
        //                 ),
        //                 width: ScreenUtil().setWidth(125),
        //                 child: CachedNetworkImage(
        //                     imageUrl: brand.data.products[index].imageUrl,
        //                     placeholder: (context, url) => LoaderGif1(),
        //                     errorWidget: (context, url, error) =>
        //                         Icon(Icons.error),
        //                     height: ScreenUtil().setHeight(50),
        //                     fit: BoxFit.contain
        //                 ),
        //               ),
        //             ),
        //         //ToDO:this to model and class and section
        //
        //       ),
        //     ):
        //     Container(
        //       height: ScreenUtil().setHeight(45),
        //
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         primary: false,
        //         itemCount: brand.data.products.length,
        //         scrollDirection: Axis.horizontal,
        //         physics: const BouncingScrollPhysics(),
        //         itemBuilder: (context, index) =>
        //             Container(
        //                 width: ScreenUtil().setWidth(100),
        //                 padding: EdgeInsets.symmetric(horizontal: 10),
        //                 child: LoaderGif1()
        //             ),
        //         //ToDO:this to model and class and section
        //
        //       ),
        //     );
        //   },
        // ),
        Consumer<ApiProvider>(
          builder: (context, value, child) {
            BrandModel brand = value.brand;
            return brand != null?Container(
              height: ScreenUtil().setHeight(45),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: brand.data.brands.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    InkWell(
                      // onTap: () =>
                      //     kNavigatorPush(context, ShowProduct('Paradoxx'),
                      //     ),
                      child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: sCardShadow2,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          width: ScreenUtil().setWidth(125),
                          child: CachedNetworkImage(
                              imageUrl: brand.data.brands[index].image,
                              placeholder: (context, url) => LoaderGif1(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: ScreenUtil().setHeight(50),
                              fit: BoxFit.contain
                          ),
                      ),
                    ),
                //ToDO:this to model and class and section

              ),
            ):
            Container(
              height: ScreenUtil().setHeight(45),

              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    Container(
                        width: ScreenUtil().setWidth(100),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: LoaderGif1()
                    ),
                //ToDO:this to model and class and section

              ),
            );
          },
        ),
      ],
    );
  }
}
