

import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/ui/product/productScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class ProductItemList extends StatelessWidget {
  final  String title;
  final  String imagePath;
  final  double rating;
  final  double prize;
  final  bool fav ;
  final bool onCart ;

  ProductItemList({this.title, this.imagePath, this.rating, this.prize, this.fav, this.onCart = false,});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow:sCardShadow
            ),
            height: ScreenUtil().setHeight(185),
            width: ScreenUtil().setWidth(163),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      //ToDO:Hero
                      Center(
                        child: GestureDetector(
                          onTap: () => kNavigatorPush(context, ProductScreen()),

                          child: Image.asset(imagePath,
                              fit: BoxFit.contain,
                            height: ScreenUtil().setHeight(101),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            fav ? Icons.favorite :Icons.favorite_border,
                            color:fav ?kRed: Colors.black45,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: k15Black,
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(9),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SmoothStarRating(
                                    rating: rating,
                                    color: kStar,
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
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Text(
                                    prize.toString(),
                                    style: kPrize,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                //Todo: ID
                                onTap: () {

                                },
                               child: Container(
                                  height:  ScreenUtil().setHeight(30),
                                  width:  ScreenUtil().setWidth(30),
                               padding:EdgeInsets.all(onCart?5:0),
                                    decoration: BoxDecoration(
                                      color:onCart? kPinkLight:Colors.white,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                  child:SvgPicture.asset(
                                    'assets/svg/cardIcon2.svg',

                                    color:onCart? Colors.white:kPinkLight,
                                  )
                                 ,
                                ),
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
          ),
        ),
      ],
    );
  }
}




