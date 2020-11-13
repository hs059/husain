
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ProductPrize extends StatelessWidget {
  final String prize ;
  final String oldPrize ;
  ProductPrize({this.prize, this.oldPrize,});
  String currency ='رس' ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( oldPrize +' '+ currency,
            style: kReviews.copyWith(
              color: kGray,
              decoration: TextDecoration.lineThrough,
            )),
        Row(
          children: [
            Text(
              prize +' '+ currency,
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
                '-${((100*(double.parse(oldPrize)-double.parse(prize)))/double.parse(oldPrize)).toStringAsFixed(2)}%',
                style: kReviews.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE63A38)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
// git add .
// git commit -m 'neaww'
// git push origin master