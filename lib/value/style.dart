
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';


TextStyle  kPrize = GoogleFonts.cairo(
  fontSize: ScreenUtil().setSp(13),
  color: Color(0xff707070),
  fontWeight: FontWeight.bold,
);
TextStyle  kBannerTitle = GoogleFonts.cairo(
  // fontFamily: 'Cairo-SemiBold',
  fontSize: ScreenUtil().setSp(18),
  color: kPinkDark,
  fontWeight: FontWeight.bold,
);
TextStyle  kBannerSubTitle = GoogleFonts.cairo(
    // fontFamily: 'Cairo-SemiBold',
    fontSize: ScreenUtil().setSp(12),
    color: kBlack,
    fontWeight: FontWeight.bold,
    height: 1
);


TextStyle  kTitleOnboarding = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(24),
      color: Color(0xff242424),
);

TextStyle  kSubTitleOnboarding = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(14),
      color: Color(0xff242424),
);
TextStyle  k15Black = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(15),
      color: Color(0xff242424),
);

TextStyle  kSubProductTitle = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(12),
      color: Color(0xff707070),
  fontWeight: FontWeight.bold,
);



TextStyle  kTitleSign = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(30),
      color: kBlack2,
);

TextStyle  kSubTitleSign = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(15),
      color: Color(0xff8F9BB3),
);

TextStyle  kBtnText = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(16),
      color: Colors.white,
);
TextStyle  kDiscount = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(16),
      color: Color(0xff69B64C),
  fontWeight: FontWeight.bold
);
TextStyle  kSectionText = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(16),
      color: kBlack2,
);
TextStyle  kSubTitleProduct = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(16),
      color: kBlack,
  fontWeight: FontWeight.bold
);
TextStyle  kReviews = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(12),
      color: kBlack,
);
TextStyle  kSearchHint = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(14),
      color: kGrayText,
);
TextStyle  kSeeAll = TextStyle(
  fontFamily: 'SFUIText-Regular',
      fontSize: ScreenUtil().setSp(14),
      color: kPinkLight,
);
TextStyle  kSubCategoryText = TextStyle(
  fontFamily: 'SFUIText-Medium',
      fontSize: ScreenUtil().setSp(18),
      color: Colors.black,
);

TextStyle  kPinCode = TextStyle(
  fontFamily: 'FontsFree-Net-SFProText-Bold',
      fontSize: ScreenUtil().setSp(26),
      color: kPinkLight,
);
TextStyle  kName = TextStyle(
  fontFamily: 'FontsFree-Net-SFProText-Bold',
      fontSize: ScreenUtil().setSp(17),
      color: kBlack,
);
TextStyle  kGrayTextStyle = kReviews.copyWith(
    fontSize: ScreenUtil().setSp(15),
    color: Color(0xff979797));

TextStyle  kGrayText33 =kSeeAll.copyWith(
color: Color(0xff8F9BB3),
);


TextStyle  kProfile = kSeeAll.copyWith(
color: kBlack,

);