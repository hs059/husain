

import 'package:beauty/components/model/categoryModel.dart';
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/components/widgets/serchTextFormField.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/Category/Screens/subCategory.dart';
import 'package:beauty/features/ui/homePage/Category/widgets/categoryItem.dart';
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'SubCategoryLoad.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(60),
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    kNavigatorPush(context, Search());
                  },
                  child: Column(
                    children:[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(8.0),
                          border:
                          Border.all(width: 1.0, color: Color(0xffedf1f7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: kGrayText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search in 3beauty',
                                style: kSearchHint,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Expanded(
                child: Consumer<ApiProvider>(
                  builder: (context, value, child) {
                    CategoryModel category =  value.category;
                   return value.category ==null?GridView.builder(
                     itemBuilder: (context, index) => LoaderGif1(),
                     physics: const BouncingScrollPhysics(),
                     primary: false,
                     shrinkWrap: true,
                     itemCount: 9,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       childAspectRatio: 1,
                       mainAxisSpacing:5,
                       crossAxisSpacing: 5,
                     ),
                   ):
                     GridView.builder(
                      itemBuilder: (context, index) {

                       return  GestureDetector(
                         onTap: ()async {

                           if (ConnectivityService.connectivityStatus ==
                               ConnectivityHStatus.online) {
                             // kNavigatorPush(context, SubCategoryWait(categor:category.data[index],));
                             // SubCategoryModel subCategoryModel =    await Provider.of<ApiProvider>(context, listen: false)
                             //     .getSubCategory(category.data[index].id,context);
                             // kNavigatorPushReplacement(context, SubCategory(
                             //   subCategoryModel: subCategoryModel,
                             //   categor:category.data[index] ,
                             // ),
                             // );
                             Provider.of<ApiProvider>(context, listen: false)
                                 .getSubCategory(category.data[index].id,context);
                            kNavigatorPush(context,  subCategory222(category.data[index]));
                           }else{
                             Get.defaultDialog(title: 'رسالة تحذير',middleText: 'لايوجد اتصال بالانترنت',);
                           }

                         },
                         child: AnimationCart(
                            Grid: true,
                            index: index,
                            count:category.data.length ,
                            duration: 1500,
                            child: CategoryItem(
                              category: category.data[index],
                            ),
                          ),
                       );
                      },
                      physics: const BouncingScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: category.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 2,
                      ),
                    );
                  },

                ),
              )
            ],
          ),
        ),
    );
  }
}
