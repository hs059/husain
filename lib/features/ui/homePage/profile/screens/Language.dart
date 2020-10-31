import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse = Provider.of<UiProvider>(context,listen: false);
    return Scaffold(
      appBar: appBarCart(title: 'Language'),
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(50),
        ),
        child: ContainerCart(
          child: Wrap(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: kPinkLight,
                    focusColor:kPinkLight ,
                    hoverColor: kPinkLight,
                    value: 'en',
                    groupValue: uiProvider.language,
                    onChanged: (value) {
                      uiProviderFalse.setLanguage(value);
                    },
                  ),
                  Text(
                    'English',
                    style: kTitleSign.copyWith(
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    activeColor: kPinkLight,
                    focusColor:kPinkLight ,
                    hoverColor: kPinkLight,
                    value: 'ar',
                    groupValue: uiProvider.language,
                    onChanged: (value) {
                      uiProviderFalse.setLanguage(value);
                    },
                  ),
                  Text(
                    'Arabic',
                    style: kTitleSign.copyWith(
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
