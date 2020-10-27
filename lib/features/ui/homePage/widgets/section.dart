

import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  //ToDO:Delete defult name
  final String title ;
  Section({ this.title = 'latest international brands'
    });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: kSectionText,),
        GestureDetector(
          onTap: () => kNavigatorPush(context, ShowProduct(title)),
          child:Text('SeeAll',style: kSeeAll,),
        )
      ],
    );
  }
}
