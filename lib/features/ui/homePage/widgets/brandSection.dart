import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiProvider apiProviderFalse =    Provider.of<ApiProvider>(context,listen: false);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("أحدث الماركات العالمية", style: kSectionText.copyWith(
                fontSize: ScreenUtil().setSp(18),
                fontFamily: 'Cairo-Regular',
              ),),
              GestureDetector(
                onTap: () {
                  if (ConnectivityService.connectivityStatus ==
                      ConnectivityHStatus.online) {
                    tabControllerConstant.animateTo(3);
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
                child: Text('رؤية الكل',style: kSeeAll.copyWith(
                    fontFamily: 'Cairo-Regular'
                ),),
              )
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        Padding(
          padding:  EdgeInsets.only(right: ScreenUtil().setWidth(15)),

          child: Consumer<ApiProvider>(
            builder: (context, value, child) {
              BrandModel brand = value.brand;
              return brand != null?Container(
                height: ScreenUtil().setHeight(50),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: brand.data.brands.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: () {
                          if (ConnectivityService.connectivityStatus ==
                              ConnectivityHStatus.online) {
                            apiProviderFalse.getProductByBrand(brand.data.brands[index].id);
                            kNavigatorPush(context, ShowProduct(title: brand.data.brands[index].name,));
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
                        child: Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: sCardShadow2,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            width: ScreenUtil().setWidth(125),
                            child: CachedNetworkImage(
                                imageUrl: brand.data.brands[index].image,
                                placeholder: (context, url) => LoaderGif1(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                height: ScreenUtil().setHeight(50),
                                fit: BoxFit.contain
                            ),
                        ),
                      ),
                  //ToDO:this to model and class and section

                ),
              ):
              Container(
                height: ScreenUtil().setHeight(45),

                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      Container(
                          width: ScreenUtil().setWidth(100),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: LoaderGif1()
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
