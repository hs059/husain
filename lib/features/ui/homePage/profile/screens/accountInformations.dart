
import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class AccountInformations extends StatelessWidget {
  GlobalKey<FormState> formAccountInformations = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);

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
                  onTap:  () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                              title: Row(
                                children: <Widget>[
                                  Icon(Icons.person),
                                  SizedBox(width: 10),
                                  Text(
                                    'تعديل بيانات المستخدم',
                                  )
                                ],
                              ),
                              children: <Widget>[
                                Form(
                                  key: formAccountInformations,
                                  child: Directionality(
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          hintText: 'الاسم كامل',
                                          password: false,
                                          validator: authProvider.validateName,
                                          onSaved: authProvider.saveFullName,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        CustomTextFormField(
                                          hintText: 'الايميل',
                                          password: false,
                                          validator: authProvider.validateEmail,
                                          onSaved: authProvider.saveEmail,
                                          textInputType: TextInputType.emailAddress,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        CustomTextFormField(
                                          hintText: 'كلمة السر',
                                          password: true,
                                          validator: authProvider.validatePassword,
                                          onSaved: authProvider.savePassword,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        CustomTextFormField(
                                          hintText: 'تأكيد كلمة المرور',
                                          password: true,
                                          validator: authProvider.validateConfirmPassword,
                                          onSaved: authProvider.saveConfirmPassword,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(width: 1.0, color: kBorder),
                                          ),
                                          child: IntlPhoneField(
                                            validator: authProvider.validatePhone,
                                            autoValidate: false,
                                            decoration: InputDecoration(
                                              hintText: 'رقم الهاتف',
                                              hintStyle:
                                              TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kBorder, width: 1.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: kBorder, width: 1.0),
                                              ),
                                            ),
                                            initialCountryCode: 'SA',
                                            showDropdownIcon: false,
                                            onChanged: (phone) {
                                              print(phone.completeNumber);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('cancel'),
                                    ),
                                    Text(
                                      'save',
                                      style: TextStyle(color: Theme.of(context).accentColor),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          });
                    },

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
        body: authProvider.isLogin?
        Column(
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
        ): Center(
          child: Text(
            'يرجى منك تسجيل الدخول',
            style:
            kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
          ),
        ),
      ),
    );
  }
}
