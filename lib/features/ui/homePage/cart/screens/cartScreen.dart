
import 'package:beauty/components/model/productsSQL.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/provider/db_provider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartItemWidget.dart';
import 'package:beauty/features/ui/signUI/screens/signIn.dart';
import 'package:beauty/services/sp_helper.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';

import 'package:beauty/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


import 'Checkout.dart';

class Cart extends StatelessWidget {
  double totalPrize = 0.0 ;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCart(title: 'العربة'),
        body: Consumer<DBProvider>(
          builder: (context, value, child) {
            List<ProductSql> allProduct =  value.allProducts ;
            if(allProduct==null){
          return
            SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                backgroundColor: Theme.of(context)
                    .accentColor
                    .withOpacity(0.2),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    kPinkLight),
              ),
            );
            }else if(allProduct.isEmpty ){
              return
                Center(
                  child: Text(
                    'لا يوجد طلبات بالعربة ',
                    style:
                    kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                  ),
                );
            }
            else{
              return  ListView.builder(
                itemCount: allProduct.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => CartItemWidget(
                   productSql: allProduct[index],
                ),
              );
            }

          },
        ),
        bottomNavigationBar: Visibility(
          visible: Provider.of<DBProvider>(context).allProducts.isNotEmpty,
          child: bottomNavigationBarCart(
            onTap: () async{
              bool isLogin =await SPHelper.spHelper.getIsLogin()??false;
              if(!isLogin){
                Fluttertoast.showToast(
                    msg: 'يجب عليك تسجيل الدخول',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    textColor: Color(0xffDAA095),
                    fontSize: 16.0
                );
                kNavigatorPush(context, SignIn());
              }else{
                Provider.of<ApiProvider>(context,listen: false).getAllAddress();
                Provider.of<AuthProvider>(context,listen: false).showProfile();
                kNavigatorPush(context, CheckOut());
              }

            },
            widget: Row(
              children: [
                Text(
                  'Cart price',
                  style: kBtnText,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(100),
                ),
                Text(
                  'Check Out',
                  style: kBtnText,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(40),
                ),
                Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
