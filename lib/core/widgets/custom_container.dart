import 'package:flutter/material.dart';

import '../extensions/border_manager.dart';
import '../extensions/durations.dart';
import '../extensions/padding_manager.dart';

import '../../config/theme/themes_manager.dart';
import '../extensions/responsive_manager.dart';
import '/core/manager/color_manager.dart';
import '/core/manager/strings_manager.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final VoidCallback? onTap;

  final Widget? child;
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool isFilled;
  final bool haveShadows;
  final bool transparentButton;
  final BoxShape? shape;
  final Color? color;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double? shadowRadius;
  final double? borderWidth;
  final double? textFont;
  final double? height;
  final double? width;
  final LinearGradient? gradient;
  final Duration? duration;
  const CustomContainer({
    Key? key,
    this.onTap,
    this.child,
    this.text,
    this.textColor,
    this.textStyle,
    this.isFilled = true,
    this.haveShadows = false,
    this.transparentButton = false,
    this.shape,
    this.color,
    this.shadowColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.shadowRadius,
    this.borderWidth,
    this.textFont,
    this.height,
    this.width,
    this.gradient,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: AnimatedContainer(
        duration: duration ?? DurationValues.dm300.milliseconds,
        decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            gradient: gradient,
            borderRadius: shape != null
                ? null
                : borderRadius ?? BorderValues.b10.borderAll,
            border: isFilled
                ? null
                : Border.all(
                    color: color ?? ColorsManager.primaryColor,
                    width: borderWidth ?? AppSize.s1_5.rs),
            boxShadow: haveShadows && isFilled
                ? [
                    BoxShadow(
                        blurRadius:
                            shadowRadius ?? Values.shadowBlur.toDouble(),
                        color: shadowColor ??
                            color ??
                            (gradient == null
                                ? ColorsManager.primaryColor
                                : gradient!.colors[0]))
                  ]
                : null,
            color: transparentButton
                ? ColorsManager.transparent
                : isFilled
                    ? color ?? ColorsManager.primaryColor
                    : Colors.transparent),
        child: onTap == null
            ? child ?? childWidget(context)
            : Material(
                color: ColorsManager.transparent,
                child: InkWell(
                  splashColor: ColorsManager.whiteLightColor,
                  borderRadius: shape != null && shape == BoxShape.circle
                      ? BorderRadius.circular(1000)
                      : borderRadius?.resolve(TextDirection.ltr) ??
                          BorderValues.b10.borderAll.resolve(TextDirection.ltr),
                  onTap: onTap,
                  child: child ?? childWidget(context),
                ),
              ),
      ),
    ).withPadding(margin ?? PaddingValues.zero.pZero);
  }

  Widget childWidget(context) => (child ??
          CustomText(text ?? StringsManager.button,
              textStyle: textStyle?.copyWith(
                      fontSize: textFont?.rf,
                      color: transparentButton
                          ? color ?? ColorsManager.primaryColor
                          : isFilled
                              ? textColor ?? ColorsManager.whiteColor
                              : color ?? ColorsManager.primaryColor) ??
                  ThemesManager.getBodySmallTextStyle(context).copyWith(
                      fontSize: textFont?.rf,
                      color: transparentButton
                          ? color ?? ColorsManager.primaryColor
                          : isFilled
                              ? textColor ?? ColorsManager.whiteColor
                              : color ?? ColorsManager.primaryColor)))
      .withPadding(padding ?? PaddingValues.zero.pZero);
}
