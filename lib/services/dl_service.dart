import 'package:beauty/features/ui/product/productMScreen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:beauty/features/provider/apiProvider.dart';

class DynamicLinkService {

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      if (deepLink != null) {
        Logger().d('qazwdc');
        String id = deepLink.queryParameters['id'];
        Logger().d(id);
        Provider.of<ApiProvider>(Get.context,listen: false).getProductDetailsDLOut(int.parse(id),Get.context);
      }
      FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
        Logger().d('aaasdasdasd');
        final Uri deepLink = dynamicLink?.link;
        String id = deepLink.queryParameters['id'];
        Logger().d(id);
        Provider.of<ApiProvider>(Get.context,listen: false).getProductDetailsDlResume(int.parse(id),Get.context);
      });

    } catch (e) {
      print(e.toString());
    }
  }
  Future<Uri> createDynamicLink(String id) async {
    Logger().d(id);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://3beauty.page.link',
      link: Uri.parse('https://3beauty.page.link.com/?id=$id'),
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
    Logger().d(dynamicUrl.toString());
    Share.share(url.toString(), subject: 'Look what I made!');
    return dynamicUrl;
  }
}
