

import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatelessWidget {
  final String imagePath ;
  final String name ;
  final String prize ;
  final int id ;
  SearchItem({this.imagePath, this.name, this.prize, this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        if (ConnectivityService.connectivityStatus ==
            ConnectivityHStatus.online) {

            Provider.of<ApiProvider>(context,listen: false).getProductDetailsSearch(id,context);

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
      child: ContainerCart(
        child: Container(
          width: ScreenUtil().setWidth(300),
          height: ScreenUtil().setHeight(80),
          child: Row(
            children: [
              imagePath!=''?CachedNetworkImage(
                  imageUrl:imagePath,
                  placeholder: (context, url) => LoaderGif1(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                  height: ScreenUtil().setHeight(50),
                  fit: BoxFit.contain
              ):Image.asset(
                'assets/images/3beauty.png',
                fit: BoxFit.contain,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 200,
                    ),
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: kTitleSign.copyWith(
                        fontSize: ScreenUtil().setSp(12),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                   prize + ' '+ currency,
                    style: kSubTitleSign.copyWith(
                      fontSize: ScreenUtil().setSp(10),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
