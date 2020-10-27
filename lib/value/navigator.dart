

import 'package:flutter/material.dart';

kNavigatorPush(BuildContext context,Widget route ){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}
kNavigatorPushReplacement(BuildContext context,Widget route ){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}
kNavigatorPushAndRemoveUntil(BuildContext context,Widget route ){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    builder: (context) => route,
  ), (route) => false);
}