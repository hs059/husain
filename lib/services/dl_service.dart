import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:share/share.dart';

class DynamicLinkService {

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {

      final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;

      if (deepLink != null) {
        Logger().d('hmamamamam');
        Logger().d(deepLink.path);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductMScreen()));
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {


            Logger().d('qwqwf');
            Logger().e(deepLink.path);
            Logger().d(deepLink==null);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductMScreen()));

      });

    } catch (e) {
      print(e.toString());
      Logger().e(e);
    }
  }

  Future<Uri> createDynamicLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://3beauty.page.link',
      link: Uri.parse('https://3beauty.page.link/$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.a7seen.beauty',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId:'com.a7seen.3beauty',
        minimumVersion: '1',
        appStoreId: '1545471952',
      ),
    );
    var dynamicUrl = await parameters.buildUrl();
    Uri url;
    final ShortDynamicLink shortLink =
    await parameters.buildShortLink();
    url = shortLink.shortUrl;
    Logger().d(url.toString());
    Share.share(url.toString(), subject: 'Look what I made!');
    return dynamicUrl;
  }
}
