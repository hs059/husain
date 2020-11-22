
import 'package:beauty/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test>with SingleTickerProviderStateMixin  {
  AnimationController _controller ;
  Animation _colorAnimation ;
  bool isFav =false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _colorAnimation = ColorTween(begin: kGray,end: kRed).animate(_controller);
    _controller.addListener(() {
setState(() {

});
    });

    _controller.addStatusListener((status) {
      if(status ==AnimationStatus.completed){
        setState(() {
          isFav =true ;
        });
      }
      if(status ==AnimationStatus.dismissed){
        setState(() {
          isFav =false ;
        });
      }

    });

  }
  @override
  void dispose() {
    _controller.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ClipPath(
        clipper: CustomTriangleClipper(),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xffF25D50), Color(0xffF2BB77)],
            ),
          ),
        ),
      ),),
    );
  }
}
class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}