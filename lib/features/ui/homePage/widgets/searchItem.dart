

import 'package:beauty/components/model/productM.dart';
import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
        ProductM  productM =   await Provider.of<ApiProvider>(context,listen: false).getProductDetailsSearch(id,context);
             ProductModel productModel = await  Provider.of<ApiProvider>(context,listen: false).getProductByCategory(id);
        kNavigatorPush(context, ProductMScreen());
      },
      child: ContainerCart(
        child: Container(
          width: ScreenUtil().setWidth(300),
          height: ScreenUtil().setHeight(65),
          child: Row(
            children: [
              GestureDetector(
             
                child:imagePath!=''?CachedNetworkImage(
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
              ),
                SizedBox(
                  width: 15,
                ),
              Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: GestureDetector(
                          onTap: () => print(id),
                          child: Text(
                            name,
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Text(
                       prize + ' '+ currency,
                        style: kSubTitleSign.copyWith(
                          fontSize: ScreenUtil().setSp(12),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
