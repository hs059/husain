
import 'package:beauty/components/btn.dart';
import 'package:beauty/features/ui/product/productScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomeSliderWidget extends StatefulWidget {

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {


    return false
    // widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Container(
      height: ScreenUtil().setHeight(185),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: kBorder,
      ),
      child: Stack(
        // alignment: _alignmentDirectional ?? Helper.getAlignmentDirectional(widget.slides.elementAt(0).textPosition),
        fit: StackFit.passthrough,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              height: 185,
              viewportFraction: 1.0,

              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  // _alignmentDirectional = Helper.getAlignmentDirectional(widget.slides.elementAt(index).textPosition);
                });
              },
            ),
            items:  image.map((url) {
              int index = image.indexOf(url);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  //toDo:color
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      image: AssetImage(image[index]), fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Perfume offers For 2020',
                      style:kBannerTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(185),),
                      child: Text(
                        'We are the original perfume storeWe strive to put in your hands the latest',
                        style: kBannerSubTitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                   Row(
                     children: [
                       //Todo:push with product ID
                       Container(
                           child: Button(text: '  Shop Now  ', onTap: (){
                             kNavigatorPush(context, ProductScreen());
                           }),
                       ),
                     ],
                   ),
                  ],
                ),
              );
            }).toList(),
          ),
          Container(
            child:Align(
              alignment:Alignment.bottomCenter ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: image.map((url) {
                  int index = image.indexOf(url);
                  return _current == index
                      ? Container(
                    width: 12.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPinkLight,
                    ),
                  )
                      : Container(
                    width: 6.0,
                    height: 6.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPinkDark,
                    ),
                  );
                }).toList(),
              ),
            ),


          ),
        ],
      ),
    );
  }
}
class HomeSliderLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(180),

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), blurRadius: 15, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset('assets/gif/loading.gif', fit: BoxFit.cover),
      ),
    );
  }
}
