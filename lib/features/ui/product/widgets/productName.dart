import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductName extends StatelessWidget {
  final String name ;
  final int reviews ;
  ProductName({this.name, this.reviews});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: ScreenUtil().setWidth(250),
              ),
              child: Text(
                name,
                style: kSubTitleProduct,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
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
                SizedBox(
                  width: ScreenUtil().setWidth(18),
                ),
                Text(
                  '$reviews reviews',
                  style: kReviews,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
// 'OZ Natural Hyalurinc Acid Serum - 30 ML',