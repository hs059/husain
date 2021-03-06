import 'package:beauty/components/model/categoryModel.dart' as cat;
import 'package:beauty/components/model/productModel.dart' as product;
import 'package:beauty/components/model/subCategoryModel.dart' as subCategory;
import 'package:beauty/components/model/subCategoryModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/animationCart.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/provider/uiProvider.dart';
import 'package:beauty/features/ui/homePage/Category/widgets/sortBy.dart';
import 'package:beauty/features/ui/homePage/screens/search.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import 'SubCategoryLoad.dart';

class subCategory222 extends StatelessWidget {
  final cat.Data categor;

  subCategory222(this.categor);

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProviderFalse =
        Provider.of<ApiProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () {
        apiProviderFalse.setTypeSelected(0);
        apiProviderFalse.setCharacter(sort[0]);
        return Future.value(true);
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Consumer<ApiProvider>(
              builder: (context, value, child) {
                SubCategoryModel subCategoryModel = value.subCategory;
                bool subCat = value.subCat;
                if (subCat == false) {
                  return SubCategoryWait(
                    categor: categor,
                  );
                } else {
                  return SubCategory(
                    categor: categor,
                    subCategoryModel: subCategoryModel,
                  );
                }
              },
            ),
          )),
    );
  }
}

class SubCategory extends StatelessWidget {
  final cat.Data categor;

  final subCategory.SubCategoryModel subCategoryModel;

  SubCategory({
    this.subCategoryModel,
    this.categor,
  });

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    return DefaultTabController(
        initialIndex: 0,
        length: subCategoryModel.date.length,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar( brightness: Brightness.light,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                categor.name,
                style: kSubCategoryText,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    kNavigatorPush(context, Search());
                    Provider.of<UiProvider>(context, listen: false)
                        .setLoading(false);

                  },
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
                    apiProvider.setIsSort(false);

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
                      color: apiProvider.typeSelected ==0? Colors.black:kPinkLight,
                    ),
                  ),
                ),
              ],
            ),
            body: Consumer<ApiProvider>(
              builder: (context, value, child) {
                subCategory.SubCategoryModel subCategor = value.subCategory;
                if (subCategor.date.isEmpty) {
                  return Center(
                    child: Text(
                      'سيتم اضافتها قريبا',
                      style: kSeeAll.copyWith(
                          fontFamily: 'Cairo-Regular', fontSize: 18),
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
                            indicatorColor: kPinkDark,
                            indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: true,
                            indicatorWeight: 4.0,
                            labelColor: kPinkDark,
                            unselectedLabelColor: kGray,
                            tabs: [
                              ...subCategor.date
                                  .map(
                                    (e) => Tab(
                                      text: e.name,
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: TabBarView(
                              children: subCategor.date
                                  .map(
                                    (e) => apiProvider.loadingSort
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 3,
                                                child:
                                                    LinearProgressIndicator(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.2),
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                          Color>(kPinkLight),
                                                ),
                                              ),
                                            ],
                                          )
                                        : FutureBuilder<product.ProductModel>(
                                            future:
                                                apiProvider.typeSelected == 0
                                                    ? apiProvider
                                                        .getSubProduct(e.id)
                                                    : apiProvider
                                                        .sortByCategory(
                                                        e.id,
                                                        sort[apiProvider
                                                            .typeSelected],
                                                      ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                product.ProductModel
                                                    subProduct =
                                                    snapshot.data;
                                                if (subProduct
                                                    .data.isNotEmpty) {
                                                  return GridView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount: subProduct
                                                        .data.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            AnimationCart(
                                                      Grid: true,
                                                      index: index,
                                                      count: subProduct
                                                          .data.length,
                                                      duration: 700,
                                                      child: ProductItemGrid(
                                                        imagePath: subProduct
                                                            .data[index]
                                                            .image,
                                                        title: subProduct
                                                            .data[index].name,
                                                        rating: 4.2,
                                                        prize: subProduct
                                                            .data[index]
                                                            .price,
                                                        fav: subProduct
                                                            .data[index]
                                                            .isFavourited,
                                                        product: subProduct
                                                            .data[index],
                                                      ),
                                                    ),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 0,
                                                      childAspectRatio: 0.57,
                                                    ),
                                                  );
                                                } else {
                                                  return Center(
                                                    child: Text(
                                                      'سيتم اضافتها قريبا',
                                                      style: kSeeAll.copyWith(
                                                          fontFamily:
                                                              'Cairo-Regular',
                                                          fontSize: 18),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                return GridView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemCount: 10,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          LoaderGif2(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing:
                                                              10,
                                                          childAspectRatio:
                                                              0.80,
                                                          mainAxisSpacing:
                                                              10),
                                                );
                                              }
                                            },
                                          ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}

// class SubCategory extends StatefulWidget {
//   final  cat.Data  categor ;
//   final  subCategory.SubCategoryModel subCategoryModel ;
//   SubCategory({this.subCategoryModel, this.categor, });
//
//   @override
//   _SubCategoryState createState() => _SubCategoryState();
// }
//
// class _SubCategoryState extends State<SubCategory>
//     with SingleTickerProviderStateMixin {
//   TabController tabControllerSub;
//   bool load ;
//   int index = 0;
//   product.ProductModel subProductModel;
//   @override
//   void initState() {
//
//     tabControllerSub =
//         TabController(initialIndex: 0, vsync: this, length: widget.subCategoryModel.date.length);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabControllerSub.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ApiProvider apiProvider =  Provider.of<ApiProvider>(context) ;
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//           title: Text(
//             widget.categor.name,
//             style: kSubCategoryText,
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () => kNavigatorPush(context, Search()),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Icon(
//                   Icons.search,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   context: context,
//                   builder: (context) {
//                     return SortBy();
//                   },
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Icon(
//                   Icons.filter_list,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: Consumer<ApiProvider>(
//           builder: (context, value, child) {
//             subCategory.SubCategoryModel subCategor = value.subCategory;
//             if (subCategor.date.isEmpty) {
//               return Center(
//                 child: Text(
//                   'سيتم اضافتها قريبا',
//                   style:
//                   kSeeAll.copyWith(fontFamily: 'Cairo-Regular', fontSize: 18),
//                 ),
//               );
//             } else {
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       height: ScreenUtil().setHeight(55),
//                       child: TabBar(
//                         onTap: (value) async{
//                           index = value;
//
//                         },
//                         controller: tabControllerSub,
//                         indicatorColor: kPinkDark,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         isScrollable: true,
//                         indicatorWeight: 4.0,
//                         labelColor: kPinkDark,
//                         unselectedLabelColor: kGray,
//                         tabs: [
//                           ...subCategor.date
//                               .map(
//                                 (e) => Tab(
//                               text: e.name,
//                             ),
//                           )
//                               .toList(),
//                         ],
//                       ),
//                     ),
//
//                     Container(
//                       child: Expanded(
//                         child: TabBarView(
//                           controller: tabControllerSub,
//                           children: subCategor.date
//                               .map(
//                                 (e) => FutureBuilder<product.ProductModel>(
//                               future: apiProvider.typeSelected ==0? apiProvider
//                                   .getSubProduct(e.id):apiProvider.sortByCategory(e.id, sort[apiProvider.typeSelected],),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   product.ProductModel subProduct =
//                                       snapshot.data;
//                                   if (subProduct.data.isNotEmpty) {
//                                     return GridView.builder(
//                                       primary: false,
//                                       shrinkWrap: true,
//                                       itemCount: subProduct.data.length,
//                                       itemBuilder: (context, index) =>
//                                           AnimationCart(
//                                             Grid: true,
//                                             index: index,
//                                             count:subProduct.data.length ,
//                                             duration: 800,
//                                             child: ProductItemGrid(
//                                               imagePath: subProduct
//                                                   .data[index].image,
//                                               title: subProduct
//                                                   .data[index].name,
//                                               rating: 4.2,
//                                               prize: subProduct
//                                                   .data[index].price,
//                                               fav: subProduct.data[index]
//                                                   .isFavourited,
//                                               product:subProduct
//                                                   .data[index] ,
//
//                                             ),
//                                           ),
//                                       gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         crossAxisSpacing: 0,
//                                         childAspectRatio: 0.57,
//                                       ),
//                                     );
//                                   } else {
//                                     return Center(
//                                       child: Text(
//                                         'سيتم اضافتها قريبا',
//                                         style: kSeeAll.copyWith(
//                                             fontFamily: 'Cairo-Regular',
//                                             fontSize: 18),
//                                       ),
//                                     );
//                                   }
//                                 } else {
//                                   return GridView.builder(
//                                     primary: false,
//                                     shrinkWrap: true,
//                                     itemCount: 10,
//                                     itemBuilder: (context, index) =>
//                                         LoaderGif2(),
//                                     gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         crossAxisSpacing: 10,
//                                         childAspectRatio: 0.80,
//                                         mainAxisSpacing: 10
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           )
//                               .toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
