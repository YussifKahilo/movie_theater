import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/fonts_manager.dart';
import '../../../../core/manager/strings_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../domain/entities/movie.dart';

class MovieGridCard extends StatelessWidget {
  const MovieGridCard(
      {Key? key,
      required this.clickAble,
      required this.movie,
      this.imageUrl,
      this.cacheData})
      : super(key: key);

  final bool clickAble;
  final Movie movie;
  final bool? cacheData;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (clickAble && cacheData == null) {
      throw Exception(
          'You have to set to cache data or not when making the widget clickable');
    }
    return CustomContainer(
      height: AppSize.s250.rh,
      haveShadows: true,
      shadowColor: ColorsManager.blackColor,
      color: ColorsManager.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: CustomImage(
              basePath: StringsManager.imageBasePath,
              imageUrl: imageUrl ?? movie.posterPath.toString(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: CustomContainer(
              onTap: clickAble
                  ? () => Navigator.pushNamed(
                      context, Routes.movieDetailsScreen,
                      arguments: (movie, cacheData!))
                  : null,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              child: clickAble
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          movie.title,
                          fontWeight: FontWeightManager.medium,
                        ).withPadding(PaddingValues.p10.pSymmetricVH)
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
