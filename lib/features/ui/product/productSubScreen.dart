import 'package:beauty/components/model/productCart.dart';
import 'package:beauty/components/model/productModel.dart' as subProduct;
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationIcon.dart';
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/components/model/productM.dart' as productClass;

import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/components/model/sectionModel.dart' as sectionP;
import 'package:beauty/features/ui/product/productRecomended.dart';
import 'package:beauty/features/ui/product/widgets/addCartSheet.dart';
import 'package:beauty/features/ui/product/widgets/brandProduct.dart';
import 'package:beauty/features/ui/product/widgets/productDescription.dart';
import 'package:beauty/features/ui/product/widgets/productName.dart';
import 'package:beauty/features/ui/product/widgets/productPrize.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/services/dl_service.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:beauty/components/model/productM.dart' as productClass;

class ProductSubScreen extends StatelessWidget {
  final subProduct.Data product;

  final sectionP.Products productS;

  final bool section;

  ProductSubScreen({
    this.product,
    this.productS,
    this.section = false,
  });

  String name;
  String permalink;
  String price;
  String regularPrice;
  String salePrice;
  String description;
  String sizePerUnit;
  bool isFavourited;
  String image;

  List<subProduct.Reviews> reviews;
  List<sectionP.Reviews> reviewsS;
  List<Map> rev;

  int id;

  int count;

  Function toggleFav;

  @override
  Widget build(BuildContext context) {
    if (section) {
      name = productS.name;
      permalink = productS.permalink;
      regularPrice = productS.regularPrice;
      salePrice = productS.salePrice;
      price = productS.price ?? '0';
      description = productS.description;
      image = productS.image;
      isFavourited = productS.isFavourited;
      reviewsS = productS.reviews;
      rev = reviewsS.map((e) => e.toJson()).toList();
      id = productS.id;
      count = productS.count;
    } else {
      name = product.name;
      permalink = product.permalink;
      regularPrice = product.regularPrice;
      salePrice = product.salePrice;
      price = product.price ?? '0';
      description = product.description;
      image = product.image;
      isFavourited = product.isFavourited;
      reviews = product.reviews;
      rev = reviews.map((e) => e.toJson()).toList();
      id = product.id;
    }
    getproduct() {
      return ProductSql(
        idProduct: id,
        price: price,
        image: image,
        name: name,
      );
    }

    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    ApiProvider apiProviderFalse =
        Provider.of<ApiProvider>(context, listen: false);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Color(0xff121924),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                final DynamicLinkService _dynamicLinkService = DynamicLinkService();
                _dynamicLinkService.createDynamicLink(id.toString());
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (authProvider.isLogin) {
                  section
                      ? apiProviderFalse.toggleFavUIS(productS)
                      : apiProviderFalse.toggleFavUI(product);
                } else {
                  Fluttertoast.showToast(
                      msg: 'يجب عليك تسجيل الدخول',
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  kNavigatorPush(context, SignIn());
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                //ToDo:Check Token
                child: authProvider.isLogin
                    ? Icon(
                        isFavourited ? Icons.favorite : Icons.favorite_border,
                        color: isFavourited ? kRed : Colors.black45,
                        size: 30,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.black45,
                        size: 30,
                      ),
              ),
            ),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: ScreenUtil().setHeight(330),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: image != '' &&
                      !(rejectImg
                              .where((element) => element == image)
                              .toList()
                              .length ==
                          1)
                  ? Hero(
                      tag: '$image',
                      child: CachedNetworkImage(
                          imageUrl: (rejectImg
                                      .where((element) => element == image)
                                      .toList()
                                      .length ==
                                  1)
                              ? ''
                              : image,
                          placeholder: (context, url) => LoaderGif1(),
                          errorWidget: (context, url, error) => Image.asset(
                                'assets/images/3beauty.png',
                                fit: BoxFit.contain,
                              ),
                          height: ScreenUtil().setHeight(50),
                          fit: BoxFit.contain),
                    )
                  : Image.asset(
                      'assets/images/3beauty.png',
                      fit: BoxFit.contain,
                    ),
            ),
            MyDivider(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Column(
                children: [
                  BrandProduct(),
                  ProductName(
                    name: name,
                    reviews: section
                        ? productS.reviews.length
                        : product.reviews.length,
                  ),
                  MyDivider(),
                  ProductPrize(
                    prize: price == null || price == '' ? '0' : price,
                    oldPrize: regularPrice == null || regularPrice == ''
                        ? '0'
                        : regularPrice,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Button(
                    text: 'إضافة إلى السلة',
                    onTap: () {
                      Provider.of<DBProvider>(context, listen: false)
                          .insertNewProduct(getproduct());
                      showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => AddCartSheet(
                          prize: price,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text(
                'الوصف',
                style: kReviews.copyWith(
                  fontSize: ScreenUtil().setSp(16),
                  fontFamily: 'Cairo-Regular',
                ),
              ),
              children: [
                ProductDescription(
                  name: name,
                  description: description,
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: kGray2,
              title: Text(
                'الأصناف',
                style: kReviews.copyWith(
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              children: [
                ListTile(
                  onTap: () => print(id),
                  title: Text('الصنف الرئيسي'),
                  trailing: Container(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(150),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Consumer<ApiProvider>(
                        builder: (context, value, child) {
                          if (value.productM != null) {
                            if (value.productM.data.category.isNotEmpty) {
                              String categoryName = value
                                  .productM.data.category.first.parent.name;
                              return Text(
                                categoryName,
                                style: kGrayTextStyle,
                              );
                            } else {
                              return Text(
                                'سيتم تصنيفه قريبا',
                                style: kGrayTextStyle,
                              );
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ExpansionTile(
            //   title: Text(
            //     'التعليقات',
            //     style: kReviews.copyWith(
            //       fontSize: ScreenUtil().setSp(14),
            //     ),
            //   ),
            //   children: [
            //     Consumer<ApiProvider>(
            //       builder: (context, value, child) {
            //         productClass.ProductM productM = value.productM;
            //         if (productM != null) {
            //           List<productClass.Reviews> reviews =
            //               productM.data.reviews;
            //           if (productM.data.reviews.isNotEmpty) {
            //             return apiProvider.revBool?SizedBox(
            //               height: 3,
            //               child: LinearProgressIndicator(
            //                 backgroundColor:
            //                 Theme.of(context).accentColor.withOpacity(0.2),
            //                 valueColor:
            //                 new AlwaysStoppedAnimation<Color>(kPinkLight),
            //               ),
            //             ) :ListView.builder(
            //               shrinkWrap: true,
            //               primary: false,
            //               itemCount: reviews.length,
            //               scrollDirection: Axis.vertical,
            //               physics: const BouncingScrollPhysics(),
            //               itemBuilder: (context, index) {
            //                 productClass.Reviews review = reviews[index];
            //                 return Padding(
            //                   padding: EdgeInsets.symmetric(
            //                     horizontal: ScreenUtil().setWidth(15),
            //                   ),
            //                   child: Align(
            //                     alignment: Alignment.topLeft,
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             SmoothStarRating(
            //                               rating:5,
            //                               color: kStar,
            //                               isReadOnly: true,
            //                               size: 15,
            //                               borderColor: kBorder,
            //                               filledIconData: Icons.star,
            //                               halfFilledIconData: Icons.star_half,
            //                               defaultIconData: Icons.star_border,
            //                               starCount: 5,
            //                               allowHalfRating: true,
            //                               spacing: 1.0,
            //                               onRated: (value) {
            //                                 print("rating value -> $value");
            //                               },
            //                             ),
            //                             Text(
            //                               review.user.userName,
            //                               style: kGrayTextStyle,
            //                               textAlign: TextAlign.start,
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(
            //                           height: ScreenUtil().setHeight(10),
            //                         ),
            //                         Container(
            //                           constraints: BoxConstraints(
            //                             maxWidth: ScreenUtil().setWidth(280),
            //                           ),
            //                           child: Text(review.comment,
            //                               style: kReviews.copyWith(
            //                                 fontSize: ScreenUtil().setSp(14),
            //                               )),
            //                         ),
            //                         SizedBox(
            //                           height: ScreenUtil().setHeight(40),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //             );
            //           } else{
            //             return Center(
            //                 child: Text('لا يوجد تعليقات أضف تعليقك ...',
            //                     style: TextStyle(
            //                         fontFamily: 'Cairo-Regular',
            //                         fontSize: 18,
            //                         color: kGray)));
            //           }
            //         } else {
            //           return SizedBox(
            //             height: 3,
            //             child: LinearProgressIndicator(
            //               backgroundColor:
            //                   Theme.of(context).accentColor.withOpacity(0.2),
            //               valueColor:
            //                   new AlwaysStoppedAnimation<Color>(kPinkLight),
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //     ListTile(
            //       trailing: GestureDetector(
            //         onTap: () async {
            //           bool isLogen =
            //               Provider.of<AuthProvider>(context, listen: false)
            //                   .isLogin;
            //
            //           if (isLogen == false) {
            //             Fluttertoast.showToast(
            //                 msg: 'يجب عليك تسجيل الدخول',
            //                 toastLength: Toast.LENGTH_SHORT,
            //                 backgroundColor: Color(0xffDAA095).withOpacity(0.8),
            //                 timeInSecForIosWeb: 1,
            //                 textColor: Colors.white,
            //                 fontSize: 16.0);
            //             kNavigatorPush(context, SignIn());
            //           } else {
            //             showDialog(
            //               context: context,
            //               builder: (context) => AlertDialog(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(10.0))),
            //                 content: Container(
            //                   child: Wrap(
            //                     children: [
            //                       Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           TitleSubTitle(
            //                             title: 'قيم و أضف تعليقك',
            //                             subTitle:
            //                                 'يسرنا الاخذ بتقييمك و تعليقك',
            //                           ),
            //                           SizedBox(
            //                             height: ScreenUtil().setHeight(10),
            //                           ),
            //                           SmoothStarRating(
            //                             rating: 4,
            //                             color: kStar,
            //                             borderColor: kStar,
            //                             isReadOnly: false,
            //                             size: 30,
            //                             filledIconData: Icons.star,
            //                             halfFilledIconData: Icons.star_half,
            //                             defaultIconData: Icons.star_border,
            //                             starCount: 5,
            //                             allowHalfRating: false,
            //                             spacing: 1.0,
            //                             onRated: apiProvider.saveRating,
            //                           ),
            //                           ContainerCart(
            //                             child: Directionality(
            //                               textDirection: TextDirection.rtl,
            //                               child: Column(
            //                                 children: [
            //                                   Row(
            //                                     children: [
            //                                       Text(
            //                                         'التعليق',
            //                                         style: kSectionText,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Directionality(
            //                                     textDirection:
            //                                         TextDirection.rtl,
            //                                     child: TextField(
            //                                       maxLines: null,
            //                                       onChanged:
            //                                           apiProvider.saveComment,
            //                                       style: TextStyle(
            //                                         fontSize: 16,
            //                                         color: Color(0xFF313A44),
            //                                       ),
            //                                       cursorColor: Colors.blue,
            //                                       decoration: InputDecoration(
            //                                           border: InputBorder.none,
            //                                           hintText:
            //                                               'أضف تعليق ...'),
            //                                     ),
            //                                   ),
            //
            //                                   // Note
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal:
            //                                     ScreenUtil().setWidth(50),
            //                                 vertical:
            //                                     ScreenUtil().setHeight(10)),
            //                             child: Button(
            //                               text: 'أضف التعليق',
            //                               onTap: () async {
            //                                 apiProviderFalse.addRev(id);
            //                                 Navigator.pop(context);
            //                               },
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }
            //         },
            //         child: Text(
            //           'أضف تعليقك',
            //           style: kSeeAll.copyWith(
            //             fontSize: ScreenUtil().setSp(16),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: ScreenUtil().setHeight(10),
            //     ),
            //   ],
            // ),
            Column(
              children: [
                ProductRecommended(id: id),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
