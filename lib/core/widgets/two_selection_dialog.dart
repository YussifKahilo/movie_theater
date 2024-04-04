import 'package:flutter/material.dart';
import '../extensions/padding_manager.dart';
import '../extensions/responsive_manager.dart';
import '../extensions/spacer.dart';
import '/config/theme/themes_manager.dart';
import '/core/manager/values_manager.dart';

import 'custom_container.dart';
import 'custom_text.dart';

class TwoSelectionDialog extends StatelessWidget {
  const TwoSelectionDialog(
      {Key? key,
      required this.firstText,
      required this.firstOnTap,
      required this.secondText,
      required this.secondOnTap,
      this.gradient,
      this.color,
      this.titleFont,
      this.haveShadows = false,
      this.title})
      : super(key: key);

  final LinearGradient? gradient;
  final String firstText;
  final String secondText;
  final VoidCallback firstOnTap;
  final VoidCallback secondOnTap;
  final String? title;

  final Color? color;
  final double? titleFont;

  final bool haveShadows;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          margin: PaddingValues.pDefault.pSymmetricVH,
          padding: PaddingValues.pDefault.pSymmetricVH,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: Values.shadowBlur.toDouble(),
                    color: Theme.of(context).scaffoldBackgroundColor)
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null)
                Column(
                  children: [
                    CustomText(
                      title!,
                      textAlign: TextAlign.center,
                      textStyle: ThemesManager.getTitleSmallTextStyle(context)
                          .copyWith(fontSize: titleFont?.rf),
                    ),
                    AppSize.s25.spaceH
                  ],
                ),
              CustomContainer(
                onTap: firstOnTap,
                gradient: gradient,
                text: firstText,
                color: color,
                haveShadows: haveShadows,
              ),
              AppSize.s15.spaceH,
              CustomContainer(
                onTap: secondOnTap,
                isFilled: false,
                text: secondText,
                color: gradient != null ? gradient?.colors[0] : color,
                haveShadows: haveShadows,
              )
            ],
          ),
        ),
      ],
    );
  }
}
