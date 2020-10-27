

import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/serchTextFormField.dart';
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/features/ui/homePage/Category/widgets/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: [
          SearchTextFormField(),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) =>  CategoryItem(),
              primary: false,
              shrinkWrap: true,
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 7,
              ),
            ),
          )
        ],
      ),
    );
  }
}
