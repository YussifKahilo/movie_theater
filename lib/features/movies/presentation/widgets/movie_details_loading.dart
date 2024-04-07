import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../config/theme/themes_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_container.dart';

class MovieDetailsLoading extends StatelessWidget {
  const MovieDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.greyColor.withOpacity(0.5),
      highlightColor: ColorsManager.greyDarkColor.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainer(
            height: AppSize.s20.rh,
            width: AppSize.s300.rw,
            textStyle: ThemesManager.getDisplayLargeTextStyle(context),
          ),
          AppSize.s30.spaceH,
          CustomContainer(
            height: AppSize.s40.rh,
            width: AppSize.s150.rw,
            textStyle: ThemesManager.getDisplayLargeTextStyle(context),
          ),
          AppSize.s10.spaceH,
          CustomContainer(
            height: AppSize.s20.rh,
            width: double.infinity,
            textStyle: ThemesManager.getDisplayLargeTextStyle(context),
          ),
          AppSize.s10.spaceH,
          CustomContainer(
            height: AppSize.s20.rh,
            width: double.infinity,
            textStyle: ThemesManager.getDisplayLargeTextStyle(context),
          ),
          AppSize.s10.spaceH,
          CustomContainer(
            height: AppSize.s20.rh,
            width: double.infinity,
            margin: PaddingValues.p100.pOnlyEnd,
            textStyle: ThemesManager.getDisplayLargeTextStyle(context),
          ),
        ],
      ).withPadding(PaddingValues.p16.pSymmetricH),
    );
  }
}
