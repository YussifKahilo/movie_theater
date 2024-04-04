import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../extensions/padding_manager.dart';

import '../../../../manager/assets_manager.dart';
import '../../../../manager/color_manager.dart';
import '../cubit/theme_cubit.dart';
import '/core/manager/values_manager.dart';
import '../../../../widgets/custom_container.dart';
import '/core/widgets/custom_svg.dart';

class ThemeButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor;
  final Color? iconColor;
  // ignore: prefer_const_constructors_in_immutables
  ThemeButton({
    Key? key,
    this.padding,
    this.margin,
    this.backGroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) => CustomContainer(
            margin: margin ?? PaddingValues.p10.pSymmetricVH,
            padding: padding ?? PaddingValues.p8.pSymmetricVH,
            color: backGroundColor ??
                (state == ThemeMode.dark
                    ? ColorsManager.whiteLightColor
                    : ColorsManager.blackLightColor),
            shape: BoxShape.circle,
            onTap: () {
              ThemeCubit.get(context).changeCurrentThemeMode();
            },
            child: CustomSvg(
              state == ThemeMode.dark
                  ? AssetsManager.darkThemeIcon
                  : AssetsManager.lightThemeIcon,
              color: iconColor,
            )));
  }
}
