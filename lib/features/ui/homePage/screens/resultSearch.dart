






import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: kBorder,
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(iconTheme: IconThemeData(color: Color(0xff121924)),
            backgroundColor: Colors.white,
            title: Text(
              'Skin Care',
              style: kSubCategoryText.copyWith(
                color: kBlack,
              ),
            ),
            elevation: 0.0,
          ),

        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Padding(
        padding:  EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15),),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              childAspectRatio: 0.85,
              mainAxisSpacing: 15.0,
            ),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(

                child:  ProductItemGrid(
                    imagePath: 'assets/images/3beauty.png',
                    title: 'perfoume',
                    rating: 4,
                    prize: '122',
                    fav: false,),
              );
            },
          ),
        ),
      ),
    );
  }
}
