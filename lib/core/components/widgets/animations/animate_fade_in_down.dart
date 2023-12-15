import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimateFadeInDown extends StatelessWidget {
  final Widget child;
  final int duration;
  final bool animate;
  const AnimateFadeInDown(
      {super.key,
      required this.child,
      required this.duration,
      required this.animate});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        animate: animate,
        duration: Duration(milliseconds: duration),
        child: child);
  }
}
