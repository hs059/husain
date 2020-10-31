import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/serchTextFormField.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/features/ui/homePage/widgets/homeSliderWidget.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemList.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            HomeSliderWidget(),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Section(title: 'Latest products',),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              height: ScreenUtil().setHeight(205),
              alignment: Alignment.center,
              child: ListView(
                physics: const BouncingScrollPhysics(),

                scrollDirection: Axis.horizontal,
                children:[
                  ProductItemList(
                    title: 'perfume',
                    fav: false,
                    imagePath: 'assets/images/product1.png',
                    prize: 55.22,
                    rating: 4.5,
                    onCart: true,
                  ),
                  ... [0, 1, 2, 3, 4, 5, 6, 7]
                      .map(
                        (e) => ProductItemList(
                      title: 'perfume',
                      fav: true,
                      imagePath: 'assets/images/product2.png',
                      prize: 55.22,
                      rating: 4.5,

                    ),
                  )
                      .toList(),
                ]
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('latest international brands',style: kSectionText.copyWith(
                  fontSize: ScreenUtil().setSp(18),

                ),),
                GestureDetector(
                  onTap: () {
                    tabController.animateTo(3);
                  },
                  child:Text('SeeAll',style: kSeeAll,),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              height: ScreenUtil().setHeight(45),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>    InkWell(
                  onTap: () => kNavigatorPush(context, ShowProduct('Paradoxx')),
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: sCardShadow2,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: ScreenUtil().setWidth(125),
                    child: Image.asset('assets/images/brand1.png'),
                  ),
                ) ,
                //ToDO:this to model and class and section

              ),
            ),

            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            HomeSliderWidget(),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Section(title: 'Men perfumes for you',),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              height: ScreenUtil().setHeight(205),
              alignment: Alignment.center,
              child: ListView(
                physics: const BouncingScrollPhysics(),

                scrollDirection: Axis.horizontal,
                children: [0, 1, 2, 3, 4, 5, 6, 7]
                    .map(
                      (e) => ProductItemList(
                    title: 'perfume',
                    fav: true,
                    imagePath: 'assets/images/product2.png',
                    prize: 55.22,
                    rating: 4.5,

                  ),
                )
                    .toList(),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Section(),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              height: ScreenUtil().setHeight(205),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [0, 1, 2, 3, 4, 5, 6, 7]
                    .map(
                      (e) => ProductItemList(
                    title: 'perfume',
                    fav: true,
                    imagePath: 'assets/images/product2.png',
                    prize: 55.22,
                    rating: 4.5,

                  ),
                )
                    .toList(),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            HomeSliderWidget(),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}
