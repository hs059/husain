import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/ui/homePage/cart/screens/Checkout.dart';
import 'package:beauty/features/ui/homePage/widgets/section.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddCartSheet extends StatelessWidget {
  final String prize;

  AddCartSheet({this.prize});

  String currency = 'رس';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(30)),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/gif/check.gif',
                    fit: BoxFit.contain,
                    height: ScreenUtil().setHeight(35),
                    width: ScreenUtil().setWidth(35),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(25),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Text(
                      'تمت إضافة المنتج إلى عربة التسوق',
                      style: kSubTitleProduct,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'سعر العربة: ' + prize + ' ' + currency,
                      style: kSubTitleSign,
                      textAlign: TextAlign.start,
                    ),

                  ],
                ),
              ],
            ),
          ),
          MyDivider(),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                    vertical: ScreenUtil().setHeight(5)),
                child: Section(
                  num: 1,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(50)),
            child: Row(
              children: [
                Expanded(
                    child: Button(
                        text: 'إتمام الطلب',
                        onTap: () async{
                          bool isLogin =await SPHelper.spHelper.getIsLogin()??false;
                          if(!isLogin){
                            Fluttertoast.showToast(
                                msg: 'يجب عليك تسجيل الدخول',
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Color(0xffDAA095).withOpacity(0.8),
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            kNavigatorPush(context, SignIn());
                          }else{
                            Provider.of<ApiProvider>(context,listen: false).getAllAddress();
                            Provider.of<AuthProvider>(context,listen: false).showProfile();
                            kNavigatorPush(context, CheckOut());
                          }

                        })),
                SizedBox(width: ScreenUtil().setWidth(5)),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                      child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(45),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: kPinkLight, width: 1)),
                        child: Text(
                      'إكمال الشراء',
                      style: kBtnText.copyWith(
                        color: kPinkLight,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
