import 'package:beauty/components/model/productModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/features/ui/homePage/widgets/searchItem.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    Provider.of<ApiProvider>(context, listen: false).nullSearch();
    Provider.of<UiProvider>(context, listen: false).setLoading(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    UiProvider uiProviderFalse =
        Provider.of<UiProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ModalProgressHUD(
        inAsyncCall: uiProvider.spinner,
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
                  title: TextField(
                    autofocus: true,
                    onChanged: (value) async {
                      uiProviderFalse.setLoading(true);
                      await Provider.of<ApiProvider>(context, listen: false)
                          .getProductSearch(value);
                      uiProviderFalse.setLoading(false);
                    },
                    controller: _controller,
                    cursorColor: kPinkLight,
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.all(20.0),
                      suffix: IconButton(
                          onPressed: () => _controller.clear(),
                          icon: Icon(
                            Icons.close,
                            size: 28,
                          )),
                      hintText: 'بحث',
                      hintStyle:
                          TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: kGrayLight,
                        width: ScreenUtil().setWidth(2),
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: kPinkDark,
                        width: ScreenUtil().setWidth(2),
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: kGrayLight,
                        width: ScreenUtil().setWidth(0.5),
                      )),
                    ),
                  ),
                  elevation: 0.0,
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight),
            ),
            body: Consumer<ApiProvider>(
              builder: (context, value, child) {
                if (value.productSearch == null) {
                  return !uiProvider.loading
                      ? Center(
                          child: Text(
                            'ابحث عن كل ما هو رائع لك',
                            style: kSeeAll.copyWith(
                                fontFamily: 'Cairo-Regular', fontSize: 18),
                          ),
                        )
                      : Column(
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
                                'جاري البحث',
                                style: kSeeAll.copyWith(
                                    fontFamily: 'Cairo-Regular', fontSize: 18),
                              ),
                            ),
                          ],
                        );
                } else if(value.productSearch.data.isEmpty){
                  return  Center(
                    child: Text(
                      'ابحث عن منتج اخر ',
                      style: kSeeAll.copyWith(
                          fontFamily: 'Cairo-Regular', fontSize: 18),
                    ),
                  );
                }else{
                  if (uiProvider.loading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 3,
                          child: LinearProgressIndicator(
                            backgroundColor:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(kPinkLight),
                          ),
                        ),
                        Center(
                          child: Text(
                            'جاري البحث',
                            style: kSeeAll.copyWith(
                                fontFamily: 'Cairo-Regular', fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(5),
                          right: ScreenUtil().setWidth(5),
                        ),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: apiProvider.productSearch.data.length,
                          itemBuilder: (context, index) => AnimationCart(
                              Grid: false,
                              index: index,
                              count: apiProvider.productSearch.data.length,
                              duration: 500,
                              child: SearchItem(
                                name:
                                    apiProvider.productSearch.data[index].name,
                                prize:
                                    apiProvider.productSearch.data[index].price,
                                imagePath:
                                    apiProvider.productSearch.data[index].image,
                                id: apiProvider.productSearch.data[index].id,
                              )),
                        ));
                  }
                }
              },
            )),
      ),
    );
  }
}
