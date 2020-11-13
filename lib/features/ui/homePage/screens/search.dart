

import 'package:beauty/features/ui/homePage/widgets/productItemGrid.dart';
import 'package:beauty/features/ui/signUI/widgets/title&subTitleAuth.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
     textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:PreferredSize(
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
              title: TextField(
onChanged: (value) {

},
                controller: _controller,
                cursorColor: kPinkLight,
                decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.all(20.0),
                  suffix: IconButton(onPressed: () => _controller.clear(),icon:Icon( Icons.close,size: 28,))  ,
                  hintText: 'بحث',
                  hintStyle: TextStyle(color: Color(0xff8F9BB3),fontSize: 15),
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
        body: Padding(
          padding:  EdgeInsets.only(
            top: ScreenUtil().setHeight(10),
            left: ScreenUtil().setWidth(15),
            right: ScreenUtil().setWidth(15),),
          child:ListView(
            physics: const BouncingScrollPhysics(),

            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                    vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:ScreenUtil().setHeight(15) ),
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(65),
                  margin: EdgeInsets.symmetric(
                      vertical:ScreenUtil().setHeight(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(125),
                        child: Image.asset('assets/images/product2.png',fit: BoxFit.contain,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'OZ Natural ',
                            style: kTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            textAlign: TextAlign.center,

                          ),

                          Text(
                            'care',
                            style: kSubTitleSign.copyWith(
                              fontSize: ScreenUtil().setSp(12),

                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
