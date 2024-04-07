import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/cubit/custom_cubit.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/manager/strings_manager.dart';
import 'package:movie_theater/core/widgets/custom_image.dart';
import 'package:movie_theater/features/movies/presentation/widgets/upcoming_movie_card.dart';

import '../../../../core/widgets/custom_container.dart';
import '../../domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';

class UpcomingMoviesSection extends StatelessWidget {
  const UpcomingMoviesSection({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomCubit<int>(0),
      child: Stack(
        children: [
          BlocBuilder<CustomCubit<int>, int>(
            builder: (context, state) {
              return Hero(
                tag: movies[state].backDropImagePath.toString(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: movies[state].backDropImagePath == null
                          ? const SizedBox()
                          : CustomImage(
                              borderRadius: BorderRadius.zero,
                              basePath: StringsManager.imageBasePath,
                              imageUrl: movies[state].backDropImagePath,
                            ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: CustomContainer(
                        borderRadius: BorderRadius.zero,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.9),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.6),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.2),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.2),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.6),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.9),
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Builder(builder: (context) {
            return Swiper(
              itemCount: movies.length,
              autoplay: true,
              viewportFraction: 0.45.rs,
              onIndexChanged: (value) {
                CustomCubit.get<int>(context).changeState(value);
              },
              scale: 0.25.rs,
              itemBuilder: (context, index) => Hero(
                tag: movies[index].posterPath.toString(),
                child: UpcomingMovieCard(
                  movie: movies[index],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
