import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/manager/fonts_manager.dart';
import 'package:movie_theater/core/manager/strings_manager.dart';
import 'package:movie_theater/core/widgets/custom_image.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';

class UpcomingMovieCard extends StatelessWidget {
  const UpcomingMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
              imageUrl: movie.posterPath,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: CustomContainer(
              onTap: () => Navigator.pushNamed(
                  context, Routes.movieDetailsScreen,
                  arguments: movie),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    movie.title,
                    fontWeight: FontWeightManager.medium,
                  ).withPadding(PaddingValues.p10.pSymmetricVH)
                ],
              ),
            ),
          ),
        ],
      ),
    ).withPadding(PaddingValues.p5.pSymmetricV);
  }
}
