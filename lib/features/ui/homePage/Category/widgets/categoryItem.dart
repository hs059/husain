

import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/ui/homePage/Category/Screens/subCategory.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CategoryItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => kNavigatorPush(context, SubCategory()),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: ScreenUtil().setHeight(105),
            width: ScreenUtil().setWidth(105),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: sCardShadow,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: ScreenUtil().setHeight(50),
                    decoration:BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Lipsticks.png'), fit: BoxFit.contain),
                    )
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text('Lipsticks',style: kSectionText,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
