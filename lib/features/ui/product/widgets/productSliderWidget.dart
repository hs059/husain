
import 'file:///E:/Programming/Dart/projects/3beauty/beauty/lib/components/widgets/btn.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ProductSliderWidget extends StatefulWidget {

  @override
  _ProductSliderWidgetState createState() => _ProductSliderWidgetState();
}

class _ProductSliderWidgetState extends State<ProductSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {


    return false
    // widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Container(
      height: ScreenUtil().setHeight(330),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              height: 185,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items:  image2.map((url) {
              int index = image2.indexOf(url);
              return  Image.asset(image2[index],
                  fit: BoxFit.contain,

              );
              //   Container(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(7),
              //     image: DecorationImage(
              //         image: AssetImage(image2[index]), fit: BoxFit.contain),
              //   ),
              //
              // );
            }).toList(),
          ),
          Container(
            child:Align(
              alignment:Alignment.bottomCenter ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: image2.map((url) {
                  int index = image2.indexOf(url);
                  return
                      Container(
                    width: ScreenUtil().setWidth(8),
                    height: ScreenUtil().setHeight(8),
                    margin:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:_current == index? kBlack:kGrayIndicator,
                    ),
                  );
                }).toList(),
              ),
            ),


          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Divider(color: kBorder,thickness: 1,),
            ],
          )

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
