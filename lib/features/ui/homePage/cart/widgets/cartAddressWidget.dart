import 'package:beauty/value/constant.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'containerCart.dart';

class CartAddressWidget extends StatelessWidget {
  final String address, name, phone;
  final int typeAddress;
  bool changeBtn;

  Function onTap;

  CartAddressWidget(
      {this.address,
      this.name,
      this.phone,
      this.typeAddress,
      this.changeBtn = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(20),
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15),

      ),
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(15),
          horizontal: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: sCardShadow,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                typeAddress == 1
                    ? '${addressIcon[0][0].toUpperCase()}${addressIcon[0].substring(1)}'
                    : typeAddress == 2
                        ?  '${addressIcon[1][0].toUpperCase()}${addressIcon[1].substring(1)}'
                        :  '${addressIcon[2][0].toUpperCase()}${addressIcon[2].substring(1)}',
                style: kSectionText,
              ),
              GestureDetector(
                onTap: changeBtn ?
                ()=> internetCheck((){
                      onTap();
                    })
                    : null,
                child: Text(
                  changeBtn ? 'تغيير' : '',
                  style: kSeeAll,
                ),
              )
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(311),
            height: ScreenUtil().setHeight(80),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/adress$typeAddress.png',
                  height: ScreenUtil().setHeight(80),

                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/map-marker.svg',
                          width: ScreenUtil().setWidth(16),
                          height: ScreenUtil().setHeight(16),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          address,
                          style: kTitleSign.copyWith(
                            fontSize: ScreenUtil().setSp(13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/person.svg',
                          width: ScreenUtil().setWidth(16),
                          height: ScreenUtil().setHeight(16),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          name,
                          style: kTitleSign.copyWith(
                            fontSize: ScreenUtil().setSp(13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/phone.svg',
                          width: ScreenUtil().setWidth(16),
                          height: ScreenUtil().setHeight(16),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          phone,
                          style: kTitleSign.copyWith(
                            fontSize: ScreenUtil().setSp(13),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
