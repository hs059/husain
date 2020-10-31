import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'containerCart.dart';


class CartAddressWidget extends StatelessWidget {
  final String address,name,phone;
  final int typeAddress;
  bool changeBtn  ;
  Function onTap ;

  CartAddressWidget({ this.address, this.name, this.phone, this.typeAddress, this.changeBtn = false ,this.onTap});
  @override
  Widget build(BuildContext context) {
    return ContainerCart(
      // height: 152,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                typeAddress==1? 'Home':typeAddress==2?'Work':'Company',
                style: kSectionText,
              ),
              GestureDetector(
                onTap: changeBtn?onTap:null,
                child: Text(
                  changeBtn? 'Change':'',
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
                Image.asset('assets/images/adress$typeAddress.png',fit: BoxFit.contain,),
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
                          '147 Al Riyadh, Saudi Arabia',
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
                          'Wonderful customer',
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
                          '970592724106',
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
