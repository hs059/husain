

import 'package:beauty/components/widgets/customTextField.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';

import 'package:beauty/value/colors.dart';

import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AccountInformations extends StatelessWidget {
  GlobalKey<FormState> formAccountInformations = GlobalKey<FormState>();
  String phone ='00';
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthProvider authProviderFalse = Provider.of<AuthProvider>(context,listen: false);
    UiProvider uiProvider = Provider.of<UiProvider>(context);


    return Directionality(
      textDirection: TextDirection.rtl,
      child: ModalProgressHUD(
        inAsyncCall:uiProvider.spinner,
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
                iconTheme: IconThemeData(color: Color(0xff121924)),
                backgroundColor: Colors.white,
                title: Text(
                  'معلومات الحساب',
                  style: kSubCategoryText.copyWith(
                    color: kBlack,
                  ),
                ),
                elevation: 0.0,
                actions: [
                  GestureDetector(
                    onTap:  () {
                      authProviderFalse.saveConfirmPassword('');
                      authProviderFalse.savePassword('');
                      authProviderFalse.setLoadEdit(false);
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
                                            // textEditingController: myController1,
                                            hintText: 'الاسم كامل',
                                            password: false,
                                            validator: authProvider.validateName,
                                            onSaved: authProvider.saveFullName,
                                            textInitialValue: authProvider.showProfileModel.data.displayName,
                                          ),
                                          // SizedBox(
                                          //   height: ScreenUtil().setHeight(15),
                                          // ),
                                          // CustomTextFormField(
                                          //   // textEditingController: myController2,
                                          //   hintText: 'الايميل',
                                          //   password: false,
                                          //   validator: authProvider.validateEmail,
                                          //   onSaved: authProvider.saveEmail,
                                          //   textInputType: TextInputType.emailAddress,
                                          //   textInitialValue: authProvider.showProfileModel.data.email,
                                          //
                                          // ),
                                          Visibility(
                                            visible: !authProvider.isLoginSocial,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                                                  ),
                                                  child: TextField(
                                                    onChanged: authProvider.savePassword,
                                                    cursorColor: Colors.grey,
                                                    decoration: InputDecoration(
                                                      hintText: 'كلمة السر القديمة',
                                                      hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: ScreenUtil().setSp(15)),
                                                      border: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(2),
                                                          )),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(2),
                                                          )),
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(0.5),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(width: 1.0, color: Color(0xffedf1f7)),
                                                  ),
                                                  child: TextField(
                                                    onChanged: authProvider.saveNewPassword,
                                                    cursorColor: Colors.grey,
                                                    decoration: InputDecoration(
                                                      hintText: 'كلمة المرور الجديدة',
                                                      hintStyle: TextStyle(color: Color(0xff8F9BB3), fontSize: ScreenUtil().setSp(15)),
                                                      border: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(2),
                                                          )),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(2),
                                                          )),
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.transparent,
                                                            width: ScreenUtil().setWidth(0.5),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(15),
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                border: Border.all(width: 1.0, color: kBorder),
                                              ),
                                              child:IntlPhoneField(
                                                // controller: myController5,
                                                validator: authProvider.validatePhone,
                                                onSaved:  (newValue) {
                                                  authProvider.saveMobile(newValue.completeNumber);
                                                },
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
                                                initialValue:authProvider.showProfileModel.data.mobileNumber ==null || authProvider.showProfileModel.data.mobileNumber.length<4?'7777777777' :authProvider.showProfileModel.data.mobileNumber.substring(4),
                                                onChanged: (phone) {
                                                  Provider.of<AuthProvider>(context,listen: false).saveMobile(phone.completeNumber);
                                                },
                                              ),
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
                                        child: Text('الغاء'),
                                      ),
                                      Builder(
                                        builder: (context) => GestureDetector(

                                          child: Text(
                                            'حفظ',
                                            style: TextStyle(
                                                color: kPinkLight,
                                              fontSize: 18
                                            ),
                                          ),
                                          onTap: () {
                                            authProvider.isLoginSocial || authProvider.password == ''?authProviderFalse.submitEditProfileSocial(context, formAccountInformations) :authProviderFalse.submitEditProfile(context, formAccountInformations);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            });
                      },

                    child: Container(
                      alignment: Alignment.center,

                      child: Text(
                        'تعديل  ',
                        style: kSeeAll.copyWith(
                          fontSize: 18.ssp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          body:authProvider.showProfileModel==null? Center(
            child: Text(
              'هناك خطأ بالتسجيل',
              style:
              kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
            ),
          ):Column(
            children: [
              Visibility(
                visible: authProvider.loadEdit,
                child:  Column(
                  children: [
                    SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context)
                            .accentColor
                            .withOpacity(0.2),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            kPinkLight),
                      ),
                    ),
                    Center(
                      child: Text(
                        'جاري تعديل بيانات المستخدم',
                        style: kSeeAll.copyWith(
                            fontFamily: 'Cairo-Regular', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              ContainerCart(
                // height: 60,
                child: Row(
                  children: [
                    Text(
                      'اسم'  ,
                      style: kSubTitleSign.copyWith(
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    Text(
                      authProvider.showProfileModel.data.displayName,
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
                      'ايميل'  ,
                      style: kSubTitleSign.copyWith(
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    Text(
                      authProvider.showProfileModel.data.email,
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
                      'كلمة السر'  ,
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
              GestureDetector(
                onTap: () => print(authProvider.isLoginSocial),
                child: ContainerCart(
                  // height: 60,
                  child: Row(
                    children: [
                      Text(
                        'رقم الموبايل'  ,
                        style: kSubTitleSign.copyWith(
                          fontSize: ScreenUtil().setSp(14),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      Text(
                        authProvider.showProfileModel.data.mobileNumber,
                        style: kProfile,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
