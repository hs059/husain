import 'package:beauty/components/model/brandModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/profile/screens/showProduct.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class Brands extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProviderFalse =    Provider.of<ApiProvider>(context,listen: false);
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
            child: AppBar(iconTheme: IconThemeData(color: Color(0xff121924)),
              backgroundColor: Colors.white,
              title: Text(
                "أحدث الماركات العالمية", style: kSectionText.copyWith(
                fontSize: ScreenUtil().setSp(18),
                fontFamily: 'Cairo-Regular',
              ),),
              elevation: 0.0,
            ),

          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: Consumer<ApiProvider>(
          builder: (context, value, child) {
            BrandModel brand = value.brand;
            return brand != null ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: brand.data.brands.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  ListTile(
                    onTap: () {
                      apiProviderFalse.getProductByBrand(brand.data.brands[index].id);
                      kNavigatorPush(context, ShowProduct(title: brand.data.brands[index].name,));

                    },
                    leading: CachedNetworkImage(
                        imageUrl: brand.data.brands[index].image,
                        placeholder: (context, url) => LoaderGif1(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        height: ScreenUtil().setHeight(50),
                        fit: BoxFit.contain
                    ),
                    title: Text(
                      brand.data.brands[index].name,
                      style: kReviews.copyWith(
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                  ),
            ) : ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: 7,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  SizedBox(
                    height: 80,
                    child: LoaderGif1(),
                  ),
            );
          },
        ),
      ),
    );
  }
}
