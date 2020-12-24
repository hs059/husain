import 'package:beauty/components/widgets/myDivider.dart';
import 'package:beauty/features/provider/apiProvider.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:beauty/features/ui/homePage/cart/widgets/containerCart.dart';
import 'package:beauty/features/ui/homePage/profile/widgets/webView.dart';
import 'package:beauty/services/connectivity.dart';
import 'package:beauty/value/constant.dart';
import 'package:beauty/value/navigator.dart';
import 'package:beauty/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar: appBarCart(title: 'من نحن'),
            body: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
              child: Column(
                children: [
                  ContainerCart(
                    // height: 400,
                    child: Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/privacyBtn.svg',
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            'سياسة الخصوصية',
                            style: kProfile,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () =>
                            kNavigatorPush(
                                context,
                                WebSite(
                                  title: 'سياسة الخصوصية',
                                  link: Provider.of<ApiProvider>(context,
                                          listen: false)
                                      .privacyPolicy['data']['url'],
                                )),

                        ),
                        MyDivider(),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/termsBtn.svg',
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            'الأحكام والشروط',
                            style: kProfile,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        MyDivider(),
                        ListTile(
                          onTap: () =>
                            _launchSocial('fb://profile/100009400440404',
                                'https://www.facebook.com/dorockxl'),
                          leading: Image.asset(
                            'assets/images/faceBookBtn.png',
                            fit: BoxFit.contain,
                            height: ScreenUtil().setHeight(35),
                            width: ScreenUtil().setWidth(35),
                          ),
                          title: Text(
                            'فيس بوك ',
                            style: kProfile,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        MyDivider(),
                        ListTile(
                          onTap: ()async {
                            var url =
                                'https://www.instagram.com/mohammed.alabadlah/';

                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                universalLinksOnly: true,
                              );
                            } else {
                              throw 'There was a problem to open the url: $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            'assets/svg/instgramBtn.svg',
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            'انستقرام ',
                            style: kProfile,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        MyDivider(),
                        ListTile(
                          onTap: () =>
                            _launchSocial('https://twitter.com/7seen1997', ''),
                          leading: SvgPicture.asset(
                            'assets/svg/twitter.svg',
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            'تويتر',
                            style: kProfile,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
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
