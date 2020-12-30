


import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebSite extends StatefulWidget {
final String  link ;
final String title ;
WebSite({this.link, this.title});

  @override
  _WebSiteState createState() => _WebSiteState();
}

class _WebSiteState extends State<WebSite> {

  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarCart(title:widget.title ),
        body: Stack(
          children: [
            WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
              widget.link,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}
//
