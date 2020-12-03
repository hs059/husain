
import 'package:beauty/value/colors.dart';
import 'package:flutter/material.dart';

class AnimationIcon extends StatefulWidget {
  bool isFav ;
 final IconData icon;
 final double iconSize ;
 final Color beginColor ;
 final Color endColor ;
  AnimationIcon({
    @required this.isFav,
    @required this.icon,
    @required this.iconSize,
    @required this.beginColor,
    @required this.endColor,
  });
  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon>with SingleTickerProviderStateMixin  {
  AnimationController _controller ;
  Animation _colorAnimation ;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _colorAnimation = ColorTween(begin: widget.beginColor,end: widget.endColor).animate(_controller);
    _controller.addListener(() {
      setState(() {

      });
    });

    _controller.addStatusListener((status) {
      if(status ==AnimationStatus.completed){
        setState(() {
          widget.isFav =true ;
        });
      }
      if(status ==AnimationStatus.dismissed){
        setState(() {
          widget.isFav =false ;
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => GestureDetector(
        onTap: () {
          setState(() {
            widget.isFav?_controller.reverse(): _controller.forward();

          });
        },
        child: Icon(
          widget.icon,
          color: _colorAnimation.value,
          size:  widget.iconSize,
        ),
      ),
    );
  }
}
