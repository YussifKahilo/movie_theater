import 'package:flutter/material.dart';

import 'package:movie_theater/config/routes/routes.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import '../../../../core/manager/fonts_manager.dart';
import '../../../../core/manager/strings_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
    required this.cacheData,
  }) : super(key: key);

  final Movie movie;
  final bool cacheData;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      haveShadows: true,
      shadowColor: Colors.black,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          if (movie.backDropImagePath != null)
            Positioned(
              top: 0,
              bottom: 0,
              child: CustomImage(
                basePath: StringsManager.imageBasePath,
                imageUrl: movie.backDropImagePath.toString(),
              ),
            ),
          CustomContainer(
            width: double.infinity,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            onTap: () => Navigator.pushNamed(context, Routes.movieDetailsScreen,
                arguments: (movie, cacheData)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  CustomContainer(
                    color: ColorsManager.transparent,
                    shadowColor: ColorsManager.blackColor,
                    haveShadows: true,
                    child: Stack(
                      children: [
                        CustomImage(
                          height: (AppSize.s120 + AppSize.s5).rh,
                          basePath: StringsManager.imageBasePath,
                          imageUrl: movie.posterPath.toString(),
                          width: AppSize.s100.rw,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: CustomContainer(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.4),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.2),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              child: const SizedBox()),
                        )
                      ],
                    ),
                  ),
                  AppSize.s10.spaceW,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              movie.title,
                              textAlign: TextAlign.start,
                              textStyle:
                                  ThemesManager.getBodySmallTextStyle(context)
                                      .copyWith(
                                          fontWeight: FontWeightManager.medium),
                            ),
                            CustomText(
                              movie.releaseDate,
                              fontWeight: FontWeightManager.medium,
                              textStyle: ThemesManager.getDisplayLargeTextStyle(
                                      context)
                                  .copyWith(),
                            ),
                          ],
                        ),
                        AppSize.s20.spaceH,
                        CustomContainer(
                          haveShadows: true,
                          color: ColorsManager.greyColor,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: ColorsManager.yellowColor,
                              ),
                              CustomText(
                                '${movie.voteAverage.toStringAsFixed(1)} | ${movie.voteCount.toString()} votes',
                                color: ColorsManager.whiteColor,
                                fontWeight: FontWeightManager.regular,
                                textStyle:
                                    ThemesManager.getDisplayMediumTextStyle(
                                            context)
                                        .copyWith(),
                              )
                            ],
                          ).withPadding(PaddingValues.p2.pSymmetricVH),
                        )
                      ],
                    ).withPadding(PaddingValues.p2.pSymmetricV),
                  )
                ],
              ).withPadding(PaddingValues.p15.pSymmetricVH),
            ),
          )
        ],
      ),
    );
  }
}
