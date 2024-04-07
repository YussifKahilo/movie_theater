import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/manager/values_manager.dart';

class MovieCardLoading extends StatelessWidget {
  const MovieCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: ColorsManager.greyColor.withOpacity(0.5),
          highlightColor: ColorsManager.greyDarkColor.withOpacity(0.5),
          child: CustomContainer(
            width: double.infinity,
            haveShadows: true,
            height: AppSize.s140.rh,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorsManager.greyColor.withOpacity(0.5),
                highlightColor: ColorsManager.greyDarkColor.withOpacity(0.5),
                child: CustomContainer(
                  height: (AppSize.s120 + AppSize.s5).rh,
                  width: AppSize.s100.rw,
                ),
              ),
              AppSize.s10.spaceW,
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: ColorsManager.greyColor.withOpacity(0.5),
                  highlightColor: ColorsManager.greyDarkColor.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            height: AppSize.s25.rw,
                            width: double.infinity,
                          ),
                          AppSize.s5.spaceH,
                          CustomContainer(
                            height: AppSize.s15.rw,
                            width: AppSize.s100.rh,
                          ),
                        ],
                      ),
                      CustomContainer(
                        color: ColorsManager.greyColor,
                        height: AppSize.s30.rh,
                        width: AppSize.s120.rw,
                      )
                    ],
                  ).withPadding(PaddingValues.p2.pSymmetricV),
                ),
              )
            ],
          ).withPadding(PaddingValues.p15.pSymmetricVH),
        )
      ],
    );
  }
}
