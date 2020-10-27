
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CardsCarouselLoaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: ScreenUtil().setHeight(185),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
          ],
        ),
        child: Image.asset(
          'assets/gif/loading_card.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class AnimationCart extends StatefulWidget {
  final int count ;
  final int index ;
  final Widget child ;
  final bool Grid ;
  AnimationCart({this.count, this.index, this.child, this.Grid = false});

  @override
  _AnimationCartState createState() => _AnimationCartState();
}

class _AnimationCartState extends State<AnimationCart>with SingleTickerProviderStateMixin {
  AnimationController _controller ;
  Animation _animation ;

  @override
  void initState() {

    _controller = AnimationController(duration: Duration(milliseconds: 1500,),vsync: this);
    _animation =
        Tween<double>(begin: 0, end: 1.0).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval((1 / widget.count) * widget.index, 1.0,
                    curve: Curves.fastOutSlowIn)));
    _controller.forward();

    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return false?CardsCarouselLoaderWidget():

    AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => FadeTransition(
        opacity: _animation,
        child: Transform(
          transform: Matrix4.translationValues(
              widget.Grid?0.0:  100 * (1.0 - _animation.value),widget.Grid? 100 * (1.0 - _animation.value): 0.0, 0.0),
          child: widget.child,
        ),
      ),
    );
  }
}