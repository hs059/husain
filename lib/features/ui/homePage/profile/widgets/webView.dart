


import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebSite extends StatelessWidget {
final int type ;
WebSite( this.type);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarCart(title:'3beauty' ),
      body: WebView(
        initialUrl:
        type==1?  'https://www.facebook.com/profile.php?id=100013595232653':
        type==2?'https://www.instagram.com/hussein_sarsour/':
        type==3?  'https://twitter.com/7seen1997':'',
      ),
    );
  }
}
//
