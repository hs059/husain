
import 'package:beauty/components/model/sliderModel.dart';
import 'package:beauty/components/widgets/LoaderGif.dart';
import 'package:beauty/components/widgets/btn.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:beauty/value/colors.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/shadow.dart';
import 'package:beauty/value/string.dart';
import 'package:beauty/value/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class HomeSliderWidget extends StatefulWidget {
final int num  ;
HomeSliderWidget({this.num = 1});
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {

    return Consumer<ApiProvider>(
        builder:(context, value, child) {

          SliderModel slider =   widget.num == 1?
            value.slider1: widget.num == 2?value.slider2:value.slider3;
          return slider == null
              ? HomeSliderLoaderWidget()
              : Container(
            height: ScreenUtil().setHeight(200),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: sCardShadow
            ),
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    height: ScreenUtil().setHeight(185),
                    viewportFraction: 1.0,

                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                        // _alignmentDirectional = Helper.getAlignmentDirectional(widget.slides.elementAt(index).textPosition);
                      });
                    },
                  ),
                  items:  slider.data.map((url) {
                    int index = slider.data.indexOf(url);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: ScreenUtil().setHeight(200),
                      decoration: BoxDecoration(
                        //toDo:color
                        borderRadius: BorderRadius.circular(7),
                        // image: DecorationImage(
                        //     // image: AssetImage(image[index]),
                        //   image: CachedNetworkImageProvider(
                        //     slider.data[index].imageUrl,
                        //   ),
                        //     fit: BoxFit.contain),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(176),
                          ),
                          Row(
                            children: [
                              Expanded(child: Container(),
                              flex: 1,),
                              Expanded(
                                child: CachedNetworkImage(
                                    imageUrl: slider.data[index].imageUrl,
                                    placeholder: (context, url) => LoaderGif1(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/3beauty.png',fit: BoxFit.contain,),
                                    height: ScreenUtil().setHeight(176),
                                    fit: BoxFit.contain
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                slider.data[index].title,
                                style:kBannerTitle,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                              ),
                              // SizedBox(
                              //   height: ScreenUtil().setHeight(10),
                              // ),
                              Container(
                                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(185),),
                                child: Text(
                                  slider.data[index].content,
                                  style: kBannerSubTitle,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              // SizedBox(
                              //   height: ScreenUtil().setHeight(20),
                              // ),
                             Row(
                               children: [
                                 //Todo:push with product ID
                                 Container(
                                     child: Button(text: '  Shop Now  ', onTap: ()async{
                                       Provider.of<ApiProvider>(context,listen: false).getProductDetailsSearch(int.parse(slider.data[index].prodOrCatId),context);
                                          kNavigatorPush(context, ProductMScreen());
                                     }),
                                 ),
                               ],
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
        },
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
