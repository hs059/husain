import 'package:beauty/components/btn.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/screens/Checkout.dart';
import 'package:beauty/features/ui/homePage/widgets/homeSliderWidget.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/features/ui/product/widgets/productSliderWidget.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () => null,
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
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductSliderWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: Column(
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
                        Text(
                          'See more of the same brand',
                          style: kSubProductTitle,
                        ),
                      ],
                    ),
                    Container(
                      width: ScreenUtil().setWidth(125),
                      child: Image.asset('assets/images/brand1.png'),
                    ),
                  ],
                ),
                MyDivider(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(250),
                          ),
                          child: Text(
                            'OZ Natural Hyalurinc Acid Serum - 30 ML',
                            style: kSubTitleProduct,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        Row(
                          children: [
                            SmoothStarRating(
                              rating: 3.0,
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
                            SizedBox(
                              width: ScreenUtil().setWidth(18),
                            ),
                            Text(
                              '66 reviews',
                              style: kReviews,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                MyDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SAR 96',
                        style: kReviews.copyWith(
                          color: kGray,
                          decoration: TextDecoration.lineThrough,
                        )),
                    Row(
                      children: [
                        Text(
                          'SAR 99.5',
                          style: kSubTitleProduct.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(25),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(52),
                          height: ScreenUtil().setHeight(20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kPink2,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '-42%',
                            style: kReviews.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffE63A38)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      builder: (context, scrollController) => Wrap(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(30),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20),
                                vertical: ScreenUtil().setHeight(30)),
                            height: ScreenUtil().setHeight(135),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Image.asset(
                                    'assets/gif/check.gif',
                                    fit: BoxFit.contain,
                                    height: ScreenUtil().setHeight(35),
                                    width: ScreenUtil().setWidth(35),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(25),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    Text(
                                      'Product has been added to the cart',
                                      style: kSubTitleProduct,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    Text(
                                      'Cart price:  637.00 S.R',
                                      style: kSubTitleSign,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: kBorder,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15),
                                    vertical: ScreenUtil().setHeight(5)),
                                child: Section(title: 'You may also like',),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Container(
                                  height: ScreenUtil().setHeight(250),
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(  horizontal: ScreenUtil().setWidth(5),
                                           ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 20,
                                    itemBuilder: (context, index) =>
                                        ProductItemGrid(
                                      imagePath: 'assets/images/3beauty.png',
                                      title: 'perfoume',
                                      rating: 4,
                                      prize: 122,
                                      fav: true,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(  horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setHeight(50)),
                            child: Row(
                              children: [
                                Expanded(
                                    child:
                                        Button(text: 'Checkout', onTap: (){
                                          kNavigatorPush(context, CheckOut());
                                        })),
                                SizedBox(width: ScreenUtil().setWidth(5)),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setHeight(45),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: kPinkLight, width: 1)),
                                    child: Text(
                                      'Continue shopping',
                                      style: kBtnText.copyWith(
                                        color: kPinkLight,
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
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
              Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'OZ Natural Hyalurinc Acid Serum ',
                        style: kSubTitleProduct,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: ScreenUtil().setWidth(250),
                        ),
                        child: Text(
                          '''OZ Natural Facial Serum, restores the healthy glow of your skin as it moisturizes the skin, fills fine lines and wrinkles, and stimulates the skin to produce more collagen to make it more elastic and full.
It comes with a unique formula of Hyaluronic Acid, Vitamin C and E, as well as a blend of green tea.
The perfect choice for smooth, supple skin full of vitality.
Suitable for aging skin''',
                          style: kReviews,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                    ],
                  ),
                ),
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
                padding:  EdgeInsets.symmetric(
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
                  'Add review... ',
                  style: kReviews.copyWith(
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
                trailing: Text(
                  'Show all',
                  style: kSeeAll.copyWith(
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                     EdgeInsets.symmetric(
                         horizontal: ScreenUtil().setWidth(15),
                         vertical: ScreenUtil().setHeight(5)
                    ),
                child: Section(),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                height: ScreenUtil().setHeight(250),
                alignment: Alignment.center,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: sCardShadow,
                        ),
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
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/3beauty.png'),
                                                fit: BoxFit.contain)),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          true
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: true ? kRed : Colors.black45,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          'title',
                                          style: k15Black,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SmoothStarRating(
                                              rating: 4,
                                              color: kStar,
                                              borderColor: kStar,
                                              isReadOnly: true,
                                              size: 15,
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              defaultIconData:
                                                  Icons.star_border,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '55',
                                                  style: kPrize,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setHeight(15),
                                    vertical: ScreenUtil().setWidth(5)),
                                child: SvgPicture.asset(
                                  'assets/svg/cardIcon.svg',
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setWidth(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
