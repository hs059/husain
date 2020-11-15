import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/serchTextFormField.dart';
import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/model/ProductModel.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/repo/api_repo.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/features/ui/homePage/widgets/brandSection.dart';
import 'package:beauty/features/ui/homePage/widgets/homeSliderWidget.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async {
        //     String token = await SPHelper.spHelper.getToken();
        //     int idUser = await SPHelper.spHelper.getUser();
        //     String id = idUser.toString();
        //     print('token : $token id : $id');
        //    await Provider.of<AuthProvider>(context,listen: false).showProfile();
        //   },
        // ),
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),

            primary: false,
            children: [
              Container(
                height: ScreenUtil().setHeight(44),
                child: GestureDetector(
                  onTap: ()  {
                    kNavigatorPush(context, Search());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration:   BoxDecoration(
                          color: Color(0xffF5F5F5),

                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon( Icons.search,color: kGrayText,),
                              SizedBox(width: 10,),
                              Text('Search in 3beauty',style:kSearchHint ,),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              // Section(num: 3,),

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
