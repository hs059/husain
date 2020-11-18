import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart' as subProduct;
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/services/connectivity.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/features/ui/product/productSubScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductItemGrid extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final String prize;
  final bool fav;

  final subProduct.Data product;

  ProductItemGrid({@required this.imagePath
    , @required this.title, @required this.rating, @required this.prize, @required this.fav, this.product,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: sCardShadow,),
          height: ScreenUtil().setHeight(400),
          width: ScreenUtil().setWidth(165),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (ConnectivityService.connectivityStatus ==
                                ConnectivityHStatus.online) {
                              kNavigatorPush(
                                  context,
                                  ProductSubScreen(
                                    product: product,
                                    section: false,
                                  ));
                            }else{
                              Get.defaultDialog(title: 'رسالة تحذير',middleText: 'لايوجد اتصال بالانترنت',);
                            }


                          },
                          child: Center(
                            child: Container(
                              height: ScreenUtil().setHeight(127),
                              width: ScreenUtil().setWidth(162),
                              child: imagePath != '' ? CachedNetworkImage(
                                  imageUrl: imagePath,
                                  placeholder: (context, url) => LoaderGif1(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/3beauty.png',
                                        fit: BoxFit.contain,),
                                  height: ScreenUtil().setHeight(50),
                                  fit: BoxFit.contain
                              ) : Image.asset(
                                'assets/images/3beauty.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            fav ? Icons.favorite : Icons.favorite_border,
                            color: fav ? kRed : Colors.black45,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Text(
                              title,
                              style: k15Black,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SmoothStarRating(
                                  rating: rating,
                                  color: kStar,
                                  borderColor: kStar,
                                  isReadOnly: true,
                                  size: 15,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.star_half,
                                  defaultIconData: Icons.star_border,
                                  starCount: 5,
                                  allowHalfRating: true,
                                  spacing: 1.0,
                                  onRated: (value) {
                                    print("rating value -> $value");
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(2),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      prize.toString() + ' ' + currency,
                                      style: kPrize,
                                      textAlign: TextAlign.center,
                                    ),

                                  ],
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child:
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15),
                      vertical: ScreenUtil().setWidth(5)
                  ),

                  child: GestureDetector(
                    //Todo: ID
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      child: SvgPicture.asset(
                        'assets/svg/cardIcon.svg',
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(30),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
    ;
  }
}
