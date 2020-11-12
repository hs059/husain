import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/serchTextFormField.dart';
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/subProductModel.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/widgets/brandSection.dart';
import 'package:beauty/features/ui/homePage/widgets/homeSliderWidget.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()async {
         SubProductModel subProductModel = await   Provider.of<ApiProvider>(context,listen: false).getSubProduct(83);
         print(subProductModel.data.length);
          },
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),

            primary: false,
            children: [
              Container(
                height: ScreenUtil().setHeight(44),
                child: SearchTextFormField(),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              HomeSliderWidget(num:1),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Section(num: 1,),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              BrandSection(),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              HomeSliderWidget(num:2),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Section(num: 2,),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Section(num: 3,),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              HomeSliderWidget(num:3),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
