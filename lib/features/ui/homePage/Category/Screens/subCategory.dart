import 'package:beauty/components/btn.dart';
import 'package:beauty/features/ui/homePage/Category/widgets/sortBy.dart';
import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/hammam.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SubCategory extends StatefulWidget {
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  int index;
  String _character;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, vsync: this, length: 8);
    super.initState();
  }

  List sort = [
    'Default sort',
    'Popularity',
    'Rating',
    'Latest',
    'Low to high',
    'High to low',
  ];

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
          'Care',
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(55),
              child: TabBar(
                controller: tabController,
                indicatorColor: kPinkDark,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                indicatorWeight: 4.0,
                labelColor: kPinkDark,
                unselectedLabelColor: kGray,
                tabs: [
                  Tab(
                    text: 'ALL',
                  ),
                  Tab(
                    text: 'Hair Care',
                  ),
                  Tab(
                    text: 'Skin Care',
                  ),
                  Tab(
                    text: 'Face Care',
                  ),
                  Tab(
                    text: 'Hair Care',
                  ),
                  Tab(
                    text: 'Skin Care',
                  ),
                  Tab(
                    text: 'Face Care',
                  ),
                  Tab(
                    text: 'Hair Care',
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, index) => ProductItemGrid(
                          imagePath: 'assets/images/3beauty.png',
                          title: 'perfoume',
                          rating: 4.2,
                          prize: 10,
                          fav: false),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 15.0,
                        childAspectRatio: 0.85,
                        // mainAxisSpacing: 15.0,
                      ),
                    ),
                    Container(
                      color: Colors.blueAccent,
                    ),
                    Container(
                      color: Colors.yellow,
                    ),
                    Container(
                      color: Colors.red,
                    ),
                    Container(
                      color: Colors.redAccent,
                    ),
                    Container(
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.lime,
                    ),
                    Container(
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> radio() {
    List<Widget> radios = [];
    for (int i = 1; i <= 5; i++) {
      radios.add(Row(
        children: [
          Radio(
            value: sort[i],
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                print(_character);
                _character = value;
              });
            },
          ),
          Text(sort[i]),
        ],
      ));
    }
    return radios;
  }
}
// Widget widget = Column(
//   children: <Widget>[
//     Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       height: ScreenUtil().setHeight(50),
//       child: Row(
//         children: [
//           GestureDetector(
//             child: Icon(Icons.close),
//             onTap: () => Navigator.pop(context),
//           ),
//           SizedBox(
//             width: ScreenUtil().setWidth(125),
//           ),
//           Container(
//             height: ScreenUtil().setHeight(56),
//             alignment: Alignment.center,
//             child: Text(
//               'Sort by',
//               style: kSectionText.copyWith(
//                   fontSize: ScreenUtil().setSp(18)),
//             ),
//           ),
//         ],
//       ),
//     ),
//     Divider(
//       thickness: 1,
//       color: kBorder,
//     ),
//     ... radio(),
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Button(text: 'Save', onTap: null),
//     ),
//   ],
// );
