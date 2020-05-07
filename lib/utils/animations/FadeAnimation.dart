import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

/// Code referred from GitHub.
/// See <https://github.com/afgprogrammer/Flutter-Splash-Screen-Animation/blob/master/lib/Animations/FadeAnimation.dart> for source.
class FadeAnimation extends StatelessWidget {
  final Key key;
  final double delay;
  final Widget child;

  FadeAnimation({this.key, this.delay, this.child})
      : assert(delay != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(
        Duration(milliseconds: 500),
        Tween(begin: 0.0, end: 1.0),
      ),
      Track("translateY").add(
        Duration(milliseconds: 500),
        Tween(begin: -20.0, end: 0.0),
        curve: Curves.decelerate,
      )
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]),
          child: child,
        ),
      ),
    );
  }
}
