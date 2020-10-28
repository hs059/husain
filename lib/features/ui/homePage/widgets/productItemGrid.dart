

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

class ProductItemGrid extends StatelessWidget {
  final  String title;
  final  String imagePath;
  final  double rating;
  final  double prize;
  final  bool fav ;

  ProductItemGrid({@required this.imagePath,@required this.title,@required this.rating,@required this.prize,@required this.fav,});
  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Container(

          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: sCardShadow,),
          height: ScreenUtil().setHeight(225),
          width: ScreenUtil().setWidth(165),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(127),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain)),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            fav ? Icons.favorite :Icons.favorite_border,
                            color:fav ?kRed: Colors.black45,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      prize.toString(),
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
                alignment: Alignment.bottomRight,
                child:
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15),
                      vertical: ScreenUtil().setWidth(5)
                  ),

                  child: GestureDetector(
                    //Todo:push with product ID
                    onTap: () => kNavigatorPush(context, ProductScreen()),
                    child: Container(
                      height:  ScreenUtil().setHeight(30),
                      width:  ScreenUtil().setWidth(30),
                      child: SvgPicture.asset(
                        'assets/svg/cardIcon.svg',
                        height:  ScreenUtil().setHeight(30),
                        width:  ScreenUtil().setWidth(30),
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
