
import 'package:beauty/components/model/categoryModel.dart' as categoryModel;
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/Category/Screens/subCategory.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {

 final categoryModel.Data category ;
 CategoryItem({this.category});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setWidth(100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: sCardShadow,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: category.image,
                  placeholder: (context, url) => LoaderGif1(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                  height: ScreenUtil().setHeight(50),
                    fit: BoxFit.contain
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(category.name,style: kSectionText,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
