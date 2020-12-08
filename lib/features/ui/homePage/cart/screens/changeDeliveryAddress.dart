import 'package:beauty/components/model/allAddressModel.dart' as addressClass ;
import 'package:beauty/components/model/allAddressModel.dart';
import 'package:beauty/components/model/showProfileModel.dart';
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/authProvider.dart';
import 'package:beauty/features/repo/api_client.dart';
import 'package:beauty/features/ui/homePage/cart/screens/addnewAddress.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/bottomNavigationBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/cartAddressWidget.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Checkout.dart';

class ChangeDeliveryAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: appBarCart(title: 'العناوين'),
          body: Consumer<ApiProvider>(
            builder: (context, value, child) {
              // value.getAllAddress();
              AllAddressModel allAddress = value.allAddressModel;
              if (allAddress == null || allAddress.data.isEmpty) {
                        if(allAddress == null){
                          return Column(
                            children: [
                              Center(
                                child:Image.asset('assets/gif/wait.gif', fit: BoxFit.cover),
                              ),
                            ],
                          );
                        }else{
                          return Center(
                            child: Text(
                              'لم يتم التحديد بعد',
                              style:
                              kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
                            ),
                          );
                        }
              } else {
                return Container(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: allAddress.data.length,
                    itemBuilder: (context, index) {
                     addressClass.Data address = allAddress.data[index] ;
                     ShowProfileModel profile = Provider.of<AuthProvider>(context).showProfileModel;
                     return Dismissible(
                       background: Container(
                         alignment: AlignmentDirectional.centerEnd,
                         color: Colors.red,
                         child: Padding(
                           padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                           child: Icon(Icons.delete,
                             color: Colors.white,
                           ),
                         ),
                       ),
                       onDismissed: (direction) {
                         value.removeAddress(int.parse(address.iD));
                         },
                       key: UniqueKey(),
                       child: GestureDetector(
                         onTap: () {
                           value.setAddressSelected(address);
                         Navigator.pop(context);
                         },
                         child: CartAddressWidget(
                            address: address.fullAddress,
                            name: profile.data.displayName,
                            phone: address.phone,
                            typeAddress: address.type ==addressIcon[0]?1:address.type ==addressIcon[1]?2:address.type ==addressIcon[2]?3:1,),
                       ),
                     );
                    },
                  ),
                );
              }
            },
          ),
            // bottomNavigationBar:      Padding(
            //   padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            //   child: Button(text: 'Add new Address',
            //     onTap: () => kNavigatorPush(context, AddNewAddress()),),
            // ),
          bottomNavigationBar:  bottomNavigationBarCart(
        widget: Text(
        'اضافة عنوان جديد',
        style: kBtnText,
        ),
          onTap: (){
            kNavigatorPush(context, AddNewAddress());
          }
          ),
        ),
      ),
    );
  }
}

