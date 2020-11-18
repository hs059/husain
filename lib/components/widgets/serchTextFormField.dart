
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class SearchText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => kNavigatorPush(context, Search()),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration:   BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
            ),
            child: ListTile(
              leading:  Icon( Icons.search,color: kGrayText,),
              title: Text('Search in 3beauty',style:kSearchHint ,),
            ),
          ),
        ],
      ),
    );
  }
}
