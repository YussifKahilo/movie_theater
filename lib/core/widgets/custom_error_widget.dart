import 'package:flutter/material.dart';
import '../extensions/spacer.dart';

import '../../config/theme/themes_manager.dart';
import '../manager/assets_manager.dart';
import '../manager/color_manager.dart';
import '../extensions/responsive_manager.dart';
import '../manager/strings_manager.dart';
import '../manager/values_manager.dart';
import 'custom_container.dart';
import 'custom_svg.dart';
import 'custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? error;
  const CustomErrorWidget({
    Key? key,
    required this.onTap,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: PaddingValues.pDefault.rw,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: CustomSvg(
                  AssetsManager.alertIcon,
                  size: AppSize.s350.rs,
                  color: ColorsManager.redColor,
                ),
              ),
              AppSize.s50.spaceH,
              CustomText(
                'Error',
                textStyle: ThemesManager.getTitleSmallTextStyle(context),
              ),
            ],
          ),
          AppSize.s15.spaceH,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomText(
                    error ?? '',
                    textStyle: ThemesManager.getBodyMediumTextStyle(context),
                  ),
                ),
                AppSize.s50.spaceH,
                CustomContainer(
                  onTap: onTap,
                  text: StringsManager.tryAgain,
                ),
              ],
            ),
          ),
          AppSize.s25.spaceH,
        ],
      ),
    );
  }
}
