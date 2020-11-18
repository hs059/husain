import 'package:beauty/components/model/myOrderModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/db_provider.dart';

import 'package:beauty/value/constant.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:provider/provider.dart';

class CartItemMyOrder extends StatelessWidget {
final Products  product ;
CartItemMyOrder({this.product});

  @override
  Widget build(BuildContext context) {
    DBProvider dbProviderFalse=  Provider.of<DBProvider>(context,listen: false);
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        boxShadow: sCardShadow,
        color: Colors.white,
      ),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, url) => LoaderGif1(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().setWidth(80),
                      ),
                  height: ScreenUtil().setHeight(80),
                  width: ScreenUtil().setWidth(80),
                  fit: BoxFit.contain
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(12),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12),
                  bottom: ScreenUtil().setHeight(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(170),
                    ),
                    child: Text(
                      product.name,
                      style: kReviews.copyWith(
                        // color: kGray2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(22),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price.toString() +' '+ currency,
                        style: kReviews,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      Text(
                        'الكمية : ${product.quantity.toString()}',
                        style: kReviews,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
