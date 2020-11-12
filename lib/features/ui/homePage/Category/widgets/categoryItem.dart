
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
 final String image ;
 final String name ;
 final int id ;
 CategoryItem({this.image, this.name, this.id});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()async {
      await Provider.of<ApiProvider>(context, listen: false)
            .getSubCategory(id,context);
        kNavigatorPush(context, SubCategory(id: id,
          countSub:Provider.of<ApiProvider>(context,listen: false ).subCategory.date.length,
        title: name,
        ),
        );
      },


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
                CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => LoaderGif1(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: ScreenUtil().setHeight(50),
                    fit: BoxFit.contain
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(name,style: kSectionText,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
