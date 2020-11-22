import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/model/sectionModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/product/productSubScreen.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductItemList extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final String prize;
  final bool fav;
  final Products product;

  ProductItemList({
    this.title,
    this.imagePath,
    this.rating,
    this.prize,
    this.fav,
    this.product,
  });

  ProductSql getproduct() {
    return ProductSql(
      idProduct: product.id,
      price: product.price,
      image: product.image,
      name: product.name,
      count: product.count,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =    Provider.of<AuthProvider>(context);
    ApiProvider apiProviderFalse =    Provider.of<ApiProvider>(context,listen: false);
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
                            if (ConnectivityService.connectivityStatus ==
                                ConnectivityHStatus.online) {
                              kNavigatorPush(
                                  context,
                                  ProductSubScreen(
                                    productS: product,
                                    section: true,
                                  ));
                            } else {
                              Get.defaultDialog(
                                title: 'رسالة تحذير',
                                middleText: 'لايوجد اتصال بالانترنت',
                              );
                            }
                          },
                          child: CachedNetworkImage(
                              imageUrl: imagePath,
                              placeholder: (context, url) => LoaderGif1(),
                              errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/3beauty.png',
                                    fit: BoxFit.contain,
                                  ),
                              height: ScreenUtil().setHeight(101),
                              fit: BoxFit.contain),
                        ),
                      ),
                      authProvider.isLogin?  Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            apiProviderFalse.toggleFavUIS(product);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            //ToDo:Check Token
                            child: Icon(
                              product.isFavourited ? Icons.favorite : Icons.favorite_border,
                              color: product.isFavourited ? kRed : Colors.black45,
                              size: 30,
                            ),
                          ),
                        ),
                      ):Container(),
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
                          GestureDetector(

                            child: Text(
                              title,
                              style: k15Black,
                            ),
                            onTap: () => print(product.id),
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
                                  Provider.of<DBProvider>(context,
                                          listen: false)
                                      .insertNewProduct(getproduct());
                                  Fluttertoast.showToast(
                                      backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                                      msg: 'تمت اضافة المنتج الى العربة',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                },
                                child: Builder(
                                  builder: (context) {
                                    print(product.id);

                                    bool onCart =
                                        Provider.of<DBProvider>(context)
                                            .getOnCart(
                                                product.id, getproduct());

                                    return Container(
                                      height: ScreenUtil().setHeight(30),
                                      width: ScreenUtil().setWidth(30),
                                      padding: EdgeInsets.all(onCart ? 5 : 0),
                                      decoration: BoxDecoration(
                                          color: onCart
                                              ? kPinkLight
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: SvgPicture.asset(
                                        'assets/svg/cardIcon2.svg',
                                        color:
                                            onCart ? Colors.white : kPinkLight,
                                      ),
                                    );
                                  },
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
