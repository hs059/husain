


import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebSite extends StatelessWidget {
final String  link ;
final String title ;
WebSite({this.link, this.title});
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title:title ),
        body: WebView(
          initialUrl:
          link,
        ),
      ),
    );
  }
}
//
