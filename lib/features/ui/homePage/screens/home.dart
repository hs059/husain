
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/features/ui/homePage/widgets/brandSection.dart';
import 'package:beauty/features/ui/homePage/widgets/homeSliderWidget.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: kBorder,
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(
              brightness: Brightness.light,

              backgroundColor: Colors.white,
              title: Text(
                'الرئيسية',
                style: kSubCategoryText.copyWith(
                  color: kBlack,
                ),
              ),
              elevation: 0.0,
              centerTitle: true,
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: ListView(
            physics: ClampingScrollPhysics(),
            primary: false,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
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
              HomeSliderWidget(num: 1),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Section(
                num: 1,
              ),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              BrandSection(),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              HomeSliderWidget(num: 2),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Section(
                num: 2,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              HomeSliderWidget(num: 3),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
