


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'features/ui/homePage/cart/widgets/appBarCart.dart';

class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: appBarCart(title:'3beauty' ),
      body: WebView(
        initialUrl: 'https://www.facebook.com/profile.php?id=100013595232653',
      ),
    );
  }
  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}
//
