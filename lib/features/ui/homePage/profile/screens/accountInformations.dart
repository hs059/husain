
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AccountInformations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            iconTheme: IconThemeData(color: Color(0xff121924)),
            backgroundColor: Colors.white,
            title: Text(
              'Account Informations',
              style: kSubCategoryText.copyWith(
                color: kBlack,
              ),
            ),
            elevation: 0.0,
            actions: [
              GestureDetector(
                onTap: () => null,
                child: Padding(
                  padding: const EdgeInsets.all(17),
                  child: Text(
                    'edit',
                    style: kSeeAll.copyWith(
                      fontSize: ScreenUtil().setSp(18),

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          ContainerCart(
            // height: 60,
            child: Row(
              children: [
                Text(
                  'USER NAME'  ,
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text(
                  'Wonderful customer',
                  style: kProfile,
                ),
              ],
            ),
          ),
          ContainerCart(
            // height: 60,
            child: Row(
              children: [

                Text(
                  'Email'  ,
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text(
                  'Wonderful customer@gmail.com',
                  style: kProfile,
                ),
              ],
            ),
          ),
          ContainerCart(
            // height: 60,
            child: Row(
              children: [

                Text(
                  'Password'  ,
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text(
                  '*************',
                  style: kProfile,
                ),
              ],
            ),
          ),
          ContainerCart(
            // height: 60,
            child: Row(
              children: [

                Text(
                  'Phone Number'  ,
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text(
                  '+970592724106',
                  style: kProfile,
                ),
              ],
            ),
          ),
          ContainerCart(
            // height: 60,
            child: Row(
              children: [

                Text(
                  'Date of Birth'  ,
                  style: kSubTitleSign.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text(
                  'Jun 25, 1998',
                  style: kProfile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
