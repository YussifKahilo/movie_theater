import 'package:flutter/material.dart';
import '../widgets/animations.dart';

enum AnimationDirection { lTr, rTl, bTt, tTb, blTtr, brTtl, tlTbr, trTbl }

extension AnimationsManager on Widget {
  Widget animateSlideFade(
    int index, {
    bool reverseHorizontal = false,
    int? delay,
    int? duration,
    AnimationDirection animationDirection = AnimationDirection.lTr,
  }) =>
      ListSLiderFadeAnimation(
        position: index,
        delay: delay,
        duration: duration,
        horizontalOffset: animationDirection == AnimationDirection.rTl ||
                animationDirection == AnimationDirection.brTtl ||
                animationDirection == AnimationDirection.trTbl
            ? -150
            : animationDirection == AnimationDirection.lTr ||
                    animationDirection == AnimationDirection.blTtr ||
                    animationDirection == AnimationDirection.tlTbr
                ? 150
                : 0,
        reverseHorizontal: reverseHorizontal,
        verticalOffset: animationDirection == AnimationDirection.tTb ||
                animationDirection == AnimationDirection.tlTbr ||
                animationDirection == AnimationDirection.trTbl
            ? -150
            : animationDirection == AnimationDirection.bTt ||
                    animationDirection == AnimationDirection.blTtr ||
                    animationDirection == AnimationDirection.brTtl
                ? 150
                : 0,
        child: this,
      );
}
