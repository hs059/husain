
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/product/productSubScreen.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/constant.dart';
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

class ProductRecommended extends StatelessWidget {
  final int id ;

  ProductRecommended({this.id,});


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =    Provider.of<AuthProvider>(context);
    ApiProvider apiProviderFalse =    Provider.of<ApiProvider>(context,listen: false);
    return     Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setHeight(5)),
      child:    Column(
        children: [
          FutureBuilder<ProductModel>(
            future: Provider.of<ApiProvider>(context).getProductByCategory(id),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                ProductModel productModel =    snapshot.data ;
                if(productModel.data.length>0){
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('شاهد أيضا',style: kSectionText.copyWith(
                              fontSize: ScreenUtil().setSp(18),
                              fontFamily: 'Cairo-Regular'
                          ),),

                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(300),
                        alignment: Alignment.center,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          itemCount:productModel.data.length ,
                          itemBuilder: (context, index) {
                            getproduct(){
                              return  ProductSql(
                                idProduct: productModel.data[index].id,
                                price: productModel.data[index].price,
                                image: productModel.data[index].image,
                                name:productModel.data[index].name,
                                count: 1,
                              );
                            }
                            return  GestureDetector(
                                child: AnimationCart(
                                index:index ,
                                Grid: false,
                                count:10 ,
                                duration: 800,
                                child: Row(
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
                                                          apiProviderFalse.getProductDetails( productModel.data[index].id);
                                                          kNavigatorPush(context, ProductSubScreen(product: productModel.data[index],section: false,));

                                                        }else{
                                                          Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
                                                            titleText:  Text(
                                                              'لا يوجد اتصال بالانترنت',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            messageText: Text(
                                                              'يرجى فحص الاتصال بالشبكة',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          );
                                                        }

                                                        },
                                                      child: Hero(
                                                        tag: '${productModel.data[index].image}',
                                                        child: CachedNetworkImage(
                                                            imageUrl: productModel.data[index].image,
                                                            placeholder: (context, url) => LoaderGif1(),
                                                            errorWidget: (context, url, error) =>
                                                                Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                                                            height: ScreenUtil().setHeight(101),
                                                            fit: BoxFit.contain),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if(authProvider.isLogin){
                                                          apiProviderFalse.toggleFavUI(productModel.data[index]);
                                                        }else{
                                                          Fluttertoast.showToast(
                                                              msg: 'يجب عليك تسجيل الدخول',
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                                                              timeInSecForIosWeb: 1,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                          kNavigatorPush(context, SignIn());
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8),
                                                        //ToDo:Check Token
                                                        child: authProvider.isLogin? Icon(
                                                          productModel.data[index].isFavourited ? Icons.favorite : Icons.favorite_border,
                                                          color: productModel.data[index].isFavourited  ? kRed : Colors.black45,
                                                          size: 30,
                                                        ):Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.black45,
                                                          size: 30,
                                                        ),
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (ConnectivityService.connectivityStatus ==
                                                              ConnectivityHStatus.online) {
                                                            apiProviderFalse.getProductDetails( productModel.data[index].id);
                                                            kNavigatorPush(context, ProductSubScreen(product: productModel.data[index],section: false,));

                                                          }else{
                                                            Get.snackbar('رسالة تحذير', 'لايوجد اتصال بالانترنت',
                                                              titleText:  Text(
                                                                'لا يوجد اتصال بالانترنت',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              messageText: Text(
                                                                'يرجى فحص الاتصال بالشبكة',
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            );
                                                          }

                                                        },
                                                        child: Text(
                                                          productModel.data[index].name,
                                                          style: k15Black,
                                                        ),
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
                                                                rating: 4.5,
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
                                                                productModel.data[index].price.toString()+' ' + currency,
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
                                                                bool onCart =
                                                                Provider.of<DBProvider>(context)
                                                                    .getOnCart(
                                                                    productModel.data[index].id, getproduct());
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
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
              }else{
                  return Container(
                    height: ScreenUtil().setHeight(300),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount:10 ,

                      itemBuilder: (context, index) {
                        return  Container(
                            width: ScreenUtil().setWidth(200),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: LoaderGif2()
                        );
                      },

                    ),
                  );
              }
              }else{
              return Container(
                height: ScreenUtil().setHeight(300),
                alignment: Alignment.center,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  shrinkWrap: true,
                  itemCount:10 ,

                  itemBuilder: (context, index) {
                    return  Container(
                        width: ScreenUtil().setWidth(200),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: LoaderGif2()
                    );
                  },

                ),
              ) ;
              }
            },
          ),
        ],
      ),
    );
  }
}
