import 'package:flutter/material.dart';
import 'responsive_manager.dart';

extension BorderManager on num {
  BorderRadiusDirectional get borderAll => BorderRadiusDirectional.circular(rc);
  BorderRadiusDirectional get borderTop => BorderRadiusDirectional.only(
      topEnd: Radius.circular(rc), topStart: Radius.circular(rc));
  BorderRadiusDirectional get borderBottom => BorderRadiusDirectional.only(
      bottomEnd: Radius.circular(rc), bottomStart: Radius.circular(rc));
  BorderRadiusDirectional get borderStart => BorderRadiusDirectional.only(
      bottomStart: Radius.circular(rc), topStart: Radius.circular(rc));
  BorderRadiusDirectional get borderEnd => BorderRadiusDirectional.only(
      topEnd: Radius.circular(rc), bottomEnd: Radius.circular(rc));
}

extension BorderDirectionalToBorder on BorderRadiusDirectional {
  BorderRadius asBorderRadius(
          {TextDirection textDirection = TextDirection.ltr}) =>
      BorderRadius.only(
          topLeft: textDirection == TextDirection.ltr ? topStart : topEnd,
          topRight: textDirection == TextDirection.ltr ? topEnd : topStart,
          bottomLeft:
              textDirection == TextDirection.ltr ? bottomStart : bottomEnd,
          bottomRight:
              textDirection == TextDirection.ltr ? bottomEnd : bottomStart);
}
