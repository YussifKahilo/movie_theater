import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingMoviesSectionLoading extends StatelessWidget {
  const UpcomingMoviesSectionLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      autoplay: false,
      viewportFraction: 0.45.rs,
      scale: 0.25.rs,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: ColorsManager.greyColor.withOpacity(0.5),
        highlightColor: ColorsManager.greyDarkColor.withOpacity(0.5),
        child: const CustomContainer(),
      ),
    ).withPadding(PaddingValues.p5.pSymmetricV);
  }
}
