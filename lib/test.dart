
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
      body: Center(child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => GestureDetector(
         onTap: () {
           isFav?_controller.reverse(): _controller.forward();
           setState(() {

           });
         },
          child: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: 30,
          ),
        ),
      ),),
    );
  }
}
