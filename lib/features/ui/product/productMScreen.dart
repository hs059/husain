import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart' as subProduct;
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/components/model/sectionModel.dart' as sectionP ;
import 'package:beauty/features/ui/product/productRecomended.dart';
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
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductMScreen extends StatelessWidget {






  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Consumer<ApiProvider>(
          builder: (context, value, child) {
            if(value.productM == null){
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    height: ScreenUtil().setHeight(330),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child:LoaderGif1(),
                  ),
                  MyDivider(),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                    child: Column(
                      children: [
                        BrandProduct(),
                        MyDivider(),
                        LoaderGif1(),
                        MyDivider(),
                        LoaderGif1(),
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        LoaderGif1(),
                      ],
                    ),
                  ),
                  LoaderGif1(),
                  LoaderGif1(),
                  LoaderGif1(),
                  MyDivider(),
                  LoaderGif2(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                ],
              );
            }else{
              if(value.productM.data == null){
                return Center(child: Text('waitaaaaaaaaaaaaaaa'));
              }else{
                String name = value.productM.data.name??'';
                String id = value.productM.data.id??'125';
                String permalink= value.productM.data.permalink??'';
                String price = value.productM.data.price??'';
                String regularPrice = value.productM.data.regularPrice??'';
                String salePrice = value.productM.data.salePrice??'';
                String description = value.productM.data.description??'';
                String sizePerUnit  = value.productM.data.sizePerUnit??'';
                bool isFavourited  = value.productM.data.isFavourited??false;
                String image = value.productM.data.images[0].imageUrl;
                List<Reviews > reviews =value.productM.data.reviews??[];
                return  Scaffold(
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
                            permalink,
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
                            color: isFavourited ? kPinkLight:Colors.black,
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
                        child: image!= ''?CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (context, url) => LoaderGif1(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image),
                            height: ScreenUtil().setHeight(50),
                            fit: BoxFit.contain
                        ):Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                      ),
                      MyDivider(),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        child: Column(
                          children: [
                            BrandProduct(),
                            MyDivider(),
                            ProductName(
                              name: name,
                              reviews:reviews.length,
                            ),
                            MyDivider(),
                            ProductPrize(prize: price,oldPrize: regularPrice,),
                            SizedBox(
                              height: ScreenUtil().setHeight(24),
                            ),
                            Button(
                              text: 'إضافة إلى العربة',
                              onTap: () {
                                int count = 0 ;
                                ProductSql productSql =
                                ProductSql(image: image, count: count++, name: name, price: price,idProduct: int.parse(id));
                                Provider.of<DBProvider>(context, listen: false)
                                    .insertNewProduct(productSql);
                                showMaterialModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context, scrollController) => AddCartSheet(prize:price,),
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
                            name:name,
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
                            title: Text('الصنف الرئيسي'),
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
                            title: Text('الصنف الفرعي'),
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
                          'التعليقات',
                          style: kReviews.copyWith(
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                        children: [
                          reviews.isNotEmpty? Padding(
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
                          ):Center(
                            child: Text(
                              '',
                              style:
                              kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                            ),
                          ),
                          ListTile(
                            title: Visibility(
                              visible:  reviews.isNotEmpty,
                              child: GestureDetector(
                                onTap: () => print(reviews.length),
                                child: Text(
                                  'جميع التعليقات',
                                  style: kSeeAll.copyWith(
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () async{
                                bool    isLogen =Provider.of<AuthProvider>(context,listen: false).isLogin;

                                print(isLogen);
                                if(isLogen == false){
                                  Fluttertoast.showToast(
                                      msg: 'يجب عليك تسجيل الدخول',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
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
                                                  title: 'قيم و أضف تعليقك',
                                                  subTitle:
                                                  'يسرنا الاخذ بتقييمك و تعليقك',
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
                                                  child: Directionality(
                                                    textDirection: TextDirection.rtl,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'التعليق',
                                                              style: kSectionText,
                                                            ),
                                                          ],
                                                        ),
                                                        Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: TextField(
                                                            maxLines: null,
                                                            onChanged: (String txt) {},
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color(0xFF313A44),
                                                            ),
                                                            cursorColor: Colors.blue,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText: 'أضف تعليق ...'),
                                                          ),
                                                        ),

                                                        // Note
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: ScreenUtil().setWidth(50),
                                                      vertical: ScreenUtil().setHeight(10)
                                                  ),
                                                  child: Button(text: 'تم',
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
                                'أضف تعليقك و تقييمك',
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
                            child: ProductRecommended(id:int.parse(id),),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),

    );
  }
}
