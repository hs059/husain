  import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SnapChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBarCart(title: 'التقط الشاشة'),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Image.asset('assets/images/snapChat.jpg',fit: BoxFit.contain,
                    height: ScreenUtil().setHeight(240),
                    width: ScreenUtil().setWidth(240),
                  )),
              Text('التقط',        style: kSubCategoryText.copyWith(
                color: kBlack,
                fontWeight: FontWeight.w300,
                fontSize: 25
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
