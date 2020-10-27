import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Brands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCart(title: 'Brands'),
        body:ListView.separated(
          physics: const BouncingScrollPhysics(),

          separatorBuilder: (context, index) => MyDivider(),
          itemCount: 20,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => ListTile(
            onTap: () => kNavigatorPush(context, ShowProduct('VOREED')),
            leading: Image.asset('assets/images/brand1.png'),
            title: Text(
              'VOREED',
              style: kReviews.copyWith(
                fontSize: ScreenUtil().setSp(16),
              ),
            ),
          ),
        )
        // Column(
        //   children: [
        //
        //     ListTile(
        //       leading: Image.asset('assets/images/brand1.png'),
        //       title: Text('VOREED',style: kReviews.copyWith(
        //         fontSize: ScreenUtil().setSp(16),
        //       ),),
        //     ),
        //     MyDivider(),
        //   ],
        // ),
        );
  }
  Widget widget = ListView.separated(
    separatorBuilder: (context, index) => MyDivider(),
    itemCount: 20,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => ListTile(
      leading: Image.asset('assets/images/brand1.png'),
      title: Text(
        'VOREED',
        style: kReviews.copyWith(
          fontSize: ScreenUtil().setSp(16),
        ),
      ),
    ),
  );
}
