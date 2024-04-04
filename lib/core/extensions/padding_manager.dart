import 'package:flutter/material.dart';
import 'responsive_manager.dart';

extension PaddingManager on num {
  EdgeInsetsDirectional get pZero => EdgeInsetsDirectional.zero;
  EdgeInsetsDirectional get pSymmetricV =>
      EdgeInsetsDirectional.symmetric(vertical: rh);
  EdgeInsetsDirectional get pSymmetricH =>
      EdgeInsetsDirectional.symmetric(horizontal: rw);
  EdgeInsetsDirectional get pSymmetricVH =>
      EdgeInsetsDirectional.symmetric(horizontal: rw, vertical: rh);

  EdgeInsetsDirectional get pOnlyStart => EdgeInsetsDirectional.only(start: rw);
  EdgeInsetsDirectional get pOnlyEnd => EdgeInsetsDirectional.only(end: rw);
  EdgeInsetsDirectional get pOnlyTop => EdgeInsetsDirectional.only(top: rh);
  EdgeInsetsDirectional get pOnlyBottom =>
      EdgeInsetsDirectional.only(start: rh);
}

extension PaddingsManager on (num, num) {
  EdgeInsetsDirectional get pSymmetricVH => EdgeInsetsDirectional.symmetric(
      vertical: this.$1.rh, horizontal: this.$2.rw);
}

extension Paddings2Manager on (num, num, num, num) {
  EdgeInsetsDirectional get pOnlyStartTopEndBottom =>
      EdgeInsetsDirectional.only(
        start: this.$1.rw,
        top: this.$2.rh,
        end: this.$3.rw,
        bottom: this.$4.rh,
      );
}

extension WidgetPadding on Widget {
  Widget withPadding(EdgeInsetsGeometry padding) => Padding(
        padding: padding,
        child: this,
      );
}
