import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/components/model/subProductModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/Category/widgets/sortBy.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class SubCategory extends StatefulWidget {
  final int id;
  final int countSub;
  final String title;

  SubCategory({this.id, this.countSub, this.title});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory>
    with SingleTickerProviderStateMixin {
  TabController tabControllerSub;

  int index = 0;
  String _character;
  SubProductModel subProductModel;
  @override
  void initState() {
    tabControllerSub =
        TabController(initialIndex: 0, vsync: this, length: widget.countSub);
    super.initState();
  }

  @override
  void dispose() {
    tabControllerSub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.title,
          style: kSubCategoryText,
        ),
        actions: [
          GestureDetector(
            onTap: () => null,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SortBy();
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ApiProvider>(
        builder: (context, value, child) {
          SubCategoryModel subCategory = value.subCategory;
          if (subCategory.date.isEmpty) {
            return Center(
              child: Text(
                'سيتم اضافتها قريبا',
                style:
                    kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(55),
                    child: TabBar(
                      onTap: (value) async{
                        index = value;

                       // await Provider.of<ApiProvider>(context,listen: false)
                       //      .getSubProduct(subCategory.date[value].id);

                      },
                      controller: tabControllerSub,
                      indicatorColor: kPinkDark,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorWeight: 4.0,
                      labelColor: kPinkDark,
                      unselectedLabelColor: kGray,
                      tabs: [
                        ...subCategory.date
                            .map(
                              (e) => Tab(
                                text: e.name,
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
//                   Consumer<ApiProvider>(
//                       builder:(context, value, child) {
//                         SubProductModel subProduct=value.subProduct ;
//                         print(subProduct.data.length);
//                                     if(subProduct.data.isEmpty){
//                                       return Center(
//                                         child: Text(
//                                           'سيتم اضافتها قريبا',
//                                           style:
//                                           kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
//                                         ),
//                                       );
//                                     }else{
//                                       return Expanded(
//                                         child: GridView.builder(
//                                           primary: false,
//                                           shrinkWrap: true,
//                                           itemCount: subProduct.data.length,
//                                           itemBuilder: (context, index) =>
//                                               ProductItemGrid(
//                                                   imagePath: subProduct
//                                                       .data[index].image,
//                                                   title: subProduct
//                                                       .data[index].name,
//                                                   rating: 4.2,
//                                                   prize: subProduct
//                                                       .data[index].price,
//                                                   fav: subProduct.data[index]
//                                                       .isFavourited),
//                                           gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 0,
//                                             childAspectRatio: 0.7,
// // mainAxisSpacing: 15.0,
//                                           ),
//                                         ),
//                                       );
//
//                                     }
//                       },
//                   ),
                  Container(
                    child: Expanded(
                      child: TabBarView(
                        controller: tabControllerSub,
                        children: [
                          ...subCategory.date
                              .map(
                                (e) => FutureBuilder<SubProductModel>(
                                  future: Provider.of<ApiProvider>(context)
                                      .getSubProduct(e.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      SubProductModel subProduct =
                                          snapshot.data;
                                      if (subProduct.data.isNotEmpty) {
                                        print(subCategory.date.length);
                                        return GridView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: subProduct.data.length,
                                          itemBuilder: (context, index) =>
                                              AnimationCart(
                                                Grid: true,
                                                index: index,
                                                count:subProduct.data.length ,
                                                duration: 1500,
                                                child: ProductItemGrid(
                                                    imagePath: subProduct
                                                        .data[index].image,
                                                    title: subProduct
                                                        .data[index].name,
                                                    rating: 4.2,
                                                    prize: subProduct
                                                        .data[index].price,
                                                    fav: subProduct.data[index]
                                                        .isFavourited,
                                                  product:subProduct
                                                      .data[index] ,

                                                ),
                                              ),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 0,
                                            childAspectRatio: 0.6,
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                            'سيتم اضافتها قريبا',
                                            style: kSeeAll.copyWith(
                                                fontFamily: 'Cairo-Regular',
                                                fontSize: 18),
                                          ),
                                        );
                                      }
                                    } else {
                                      return GridView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: 10,
                                        itemBuilder: (context, index) =>
                                            LoaderGif2(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.80,
                                                mainAxisSpacing: 10
// mainAxisSpacing: 15.0,
                                                ),
                                      );
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
