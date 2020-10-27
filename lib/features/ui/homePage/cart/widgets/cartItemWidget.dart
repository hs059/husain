

import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return           Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        boxShadow: sCardShadow,
        color:Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Image.asset(
            'assets/images/product2.png',
            fit: BoxFit.contain,
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(80),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12),bottom: ScreenUtil().setHeight(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: ScreenUtil().setWidth(170),
                  ),
                  child: Text(
                    'OZ Natural Hyalurinc Acid Serum - 30 ML',
                    style: kReviews.copyWith(
                      // color: kGray2,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(22),
                ),

                Text(
                  '210.00 S.R',
                  style: kReviews,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/svg/delete.svg'),
                SizedBox(
                  height: ScreenUtil().setHeight(22),
                ),
                Container(
                  width: ScreenUtil().setWidth(98),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(30),
                        child: Icon(FontAwesomeIcons.minus,size: 20,color: kPinkLight,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: kBorder, width: 1),
                        ),
                      ),
                      Text(
                        '2 ',
                        style: kReviews,
                      ),
                      Container(
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(30),
                        child: Icon(FontAwesomeIcons.plus,size: 20,color: kPinkLight,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: kBorder, width: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
