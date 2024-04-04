import 'package:flutter/material.dart';
import '/config/theme/themes_manager.dart';
import '../extensions/responsive_manager.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? height;
  const CustomText(
    this.text, {
    Key? key,
    this.fontWeight,
    this.height,
    this.textStyle,
    this.textAlign,
    this.fontSize,
    this.color,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          ThemesManager.getBodyMediumTextStyle(context).copyWith(
              fontWeight: fontWeight,
              color: color,
              fontSize: fontSize?.rf,
              height: height,
              overflow: overflow),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
    );
  }
}
