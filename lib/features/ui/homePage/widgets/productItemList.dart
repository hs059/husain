import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/product/productSubScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductItemList extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final String prize;
  final bool fav;
  final Products product ;
  final bool onCart;

  ProductItemList(
      {this.title,
      this.imagePath,
      this.rating,
      this.prize,
      this.fav,
      this.onCart = false,
        this.product, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: sCardShadow),
            width: ScreenUtil().setWidth(163),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: ScreenUtil().setHeight(101),
                  child: Stack(
                    children: [
                      //ToDO:Hero
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            print(product.id);
                            Provider.of<ApiProvider>(context,listen: false).getProductDetails(product.id);
                            kNavigatorPush(context, ProductSubScreen(productS: product,section: true,));
                          },
                          child: CachedNetworkImage(
                              imageUrl: imagePath,
                              placeholder: (context, url) => LoaderGif1(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                              height: ScreenUtil().setHeight(101),
                              fit: BoxFit.contain),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          //ToDo:Check Token
                          child: Icon(
                            fav ? Icons.favorite : Icons.favorite_border,
                            color: fav ? kRed : Colors.black45,
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
                                onTap: () {},
                                child: Container(
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setWidth(30),
                                  padding: EdgeInsets.all(onCart ? 5 : 0),
                                  decoration: BoxDecoration(
                                      color: onCart ? kPinkLight : Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: SvgPicture.asset(
                                    'assets/svg/cardIcon2.svg',
                                    color: onCart ? Colors.white : kPinkLight,
                                  ),
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