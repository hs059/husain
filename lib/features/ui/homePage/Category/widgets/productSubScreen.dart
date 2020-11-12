import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/model/subProductModel.dart' as subProduct;
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';

import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/features/ui/product/widgets/addCartSheet.dart';
import 'package:beauty/features/ui/product/widgets/brandProduct.dart';
import 'package:beauty/features/ui/product/widgets/productDescription.dart';
import 'package:beauty/features/ui/product/widgets/productName.dart';
import 'package:beauty/features/ui/product/widgets/productPrize.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductSubScreen extends StatelessWidget {
  final subProduct.Data product ;
  ProductSubScreen({this.product,});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
              onTap: () => Share.share(
                  'check out my website https://3beauty.net/product/ميك-اب-فور-ايفر-كريم-الأساس-ألتر-hd-365/',
                  subject: 'Look what I made!'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.favorite_border,
                  color:product.isFavourited? kPinkLight:Colors.black,
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
              child:CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, url) => LoaderGif1(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  height: ScreenUtil().setHeight(50),
                  fit: BoxFit.contain
              ),
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Column(
                children: [
                  BrandProduct(),
                  MyDivider(),
                  ProductName(
                    name: product.name,
                    reviews: product.reviews.length,
                  ),
                  MyDivider(),
                  ProductPrize(prize: product.price,oldPrize: product.regularPrice,),
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Button(
                    text: 'Add to cart',
                    onTap: () {
                      showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context, scrollController) => AddCartSheet(prize: product.price,),
                      );
                    },
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text(
                'Description',
                style: kReviews.copyWith(
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              children: [
                ProductDescription(
                  name: product.name,
                  description: product.description,
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: kGray2,
              title: Text(
                'Categories',
                style: kReviews.copyWith(
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              children: [
                ListTile(
                  title: Text('Care'),
                  trailing: Container(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(150),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'skin care',
                        style: kGrayTextStyle,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Formulation'),
                  trailing: Container(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(150),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Serum',
                        style: kGrayTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Reviews',
                style: kReviews.copyWith(
                  fontSize: ScreenUtil().setSp(14),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            SmoothStarRating(
                              rating: 4.5,
                              color: kStar,
                              isReadOnly: true,
                              size: 15,
                              borderColor: kBorder,
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
                            Text(
                              ' Unknown ',
                              style: kGrayTextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(280),
                          ),
                          child: Text(
                              '''Wonderful gives a smooth texture to the skin 
I highly recommend it''',
                              style: kReviews.copyWith(
                                fontSize: ScreenUtil().setSp(14),
                              )),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(

                  title: Text(
                    'All reviews ',
                    style: kSeeAll.copyWith(
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () async{
                      bool isLogen =await SPHelper.spHelper.getIsLogin();
                      print(isLogen);
                      if(isLogen == false){
                        Fluttertoast.showToast(
                            msg: 'يجب عليك تسجيل الدخول',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            textColor: Color(0xffDAA095),
                            fontSize: 16.0
                        );
                        kNavigatorPush(context, SignIn());
                      }else{
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            content: Container(
                              child: Wrap(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TitleSubTitle(
                                        title: 'Rating and add reviews',
                                        subTitle:
                                        'our orders have nice reviews',
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(10),
                                      ),

                                      SmoothStarRating(
                                        rating: 2,
                                        color: kStar,
                                        borderColor: kStar,
                                        isReadOnly: false,
                                        size: 30,
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
                                      ContainerCart(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Review',
                                                  style: kSectionText,
                                                ),
                                              ],
                                            ),
                                            TextField(
                                              maxLines: null,
                                              onChanged: (String txt) {},
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF313A44),
                                              ),
                                              cursorColor: Colors.blue,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Add Review...'),
                                            ),

                                            // Note
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setWidth(50),
                                            vertical: ScreenUtil().setHeight(10)
                                        ),
                                        child: Button(text: 'Done',
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                        ),),

                                    ],
                                  ),
                                ],

                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Add rating',
                      style: kSeeAll.copyWith(
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15),
                      vertical: ScreenUtil().setHeight(5)),
                  child: Section(num: 2,),
                ),
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
