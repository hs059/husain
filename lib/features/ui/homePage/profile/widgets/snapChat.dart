  import 'package:beauty/features/ui/homePage/cart/widgets/appBarCart.dart';
import 'package:flutter/material.dart';

class SnapChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBarCart(title: 'التقط الشاشة'),
        body: Center(

          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Image.asset('assets/images/snapChat.jpg',fit: BoxFit.contain,)),
        ),
      ),
    );
  }
}
