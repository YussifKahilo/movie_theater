import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/config/routes/routes.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_card_loading.dart';
import 'package:movie_theater/features/movies/presentation/widgets/upcoming_movies_section_loading.dart';
import '/core/extensions/padding_manager.dart';
import '/core/extensions/spacer.dart';
import '/core/manager/assets_manager.dart';
import '/core/manager/color_manager.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/custom_error_widget.dart';
import '/core/widgets/custom_svg.dart';
import '/core/widgets/custom_text.dart';
import '/features/movies/presentation/cubit/movies_cubit.dart';
import '/features/movies/presentation/widgets/upcoming_movies_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    MoviesCubit.get(context).getMoviesUpComingMoviesList();
    MoviesCubit.get(context).getMoviesTopRatedMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: RefreshIndicator(
        color: ColorsManager.primaryColor,
        onRefresh: () async {
          MoviesCubit.get(context).getMoviesUpComingMoviesList();
          MoviesCubit.get(context).getMoviesTopRatedMoviesList();
        },
        child: SingleChildScrollView(
          padding: ((Platform.isAndroid
                      ? PaddingValues.p50.rh
                      : ScreenUtil().bottomBarHeight) +
                  PaddingValues.p70)
              .pOnlyBottom,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Discover',
                    textStyle: ThemesManager.getTitleLargeTextStyle(context),
                  ),
                  CustomContainer(
                    transparentButton: true,
                    textStyle: ThemesManager.getDisplayLargeTextStyle(context),
                    text: 'View more',
                    onTap: () => Navigator.pushNamed(
                        context, Routes.moviesListScreen,
                        arguments: MovieSection.upComing),
                  )
                ],
              )
                  .withPadding(
                      (PaddingValues.p16, PaddingValues.p20).pSymmetricVH)
                  .animateSlideFade(2),
              SizedBox(
                height: ScreenUtil().screenHeight / 3.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BlocBuilder<MoviesCubit, MoviesState>(
                        buildWhen: (previous, current) =>
                            current is GetUpComingMoviesListFailedState ||
                            current is GetUpComingMoviesListLoadingState ||
                            current is GetUpComingMoviesListSuccessState,
                        builder: (context, state) {
                          if (state is GetUpComingMoviesListFailedState) {
                            return CustomErrorWidget(
                              onTap: () => MoviesCubit.get(context)
                                  .getMoviesUpComingMoviesList(),
                              error: state.message,
                            );
                          } else if (state
                              is GetUpComingMoviesListSuccessState) {
                            return UpcomingMoviesSection(movies: state.movies);
                          } else {
                            return const UpcomingMoviesSectionLoading();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ).animateSlideFade(4, animationDirection: AnimationDirection.tTb),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        'Top Rated',
                        textStyle:
                            ThemesManager.getTitleLargeTextStyle(context),
                      ),
                      AppSize.s5.spaceW,
                      const CustomSvg(
                        AssetsManager.starIcon,
                        color: ColorsManager.yellowColor,
                        size: AppSize.s30,
                      )
                    ],
                  ),
                  CustomContainer(
                    transparentButton: true,
                    text: 'View more',
                    textStyle: ThemesManager.getDisplayLargeTextStyle(context),
                    onTap: () => Navigator.pushNamed(
                        context, Routes.moviesListScreen,
                        arguments: MovieSection.topRated),
                  )
                ],
              )
                  .withPadding(
                      (PaddingValues.p16, PaddingValues.p20).pSymmetricVH)
                  .animateSlideFade(5),
              BlocBuilder<MoviesCubit, MoviesState>(
                buildWhen: (previous, current) =>
                    current is GetTopRatedMoviesListFailedState ||
                    current is GetTopRatedMoviesListLoadingState ||
                    current is GetTopRatedMoviesListSuccessState,
                builder: (context, state) {
                  if (state is GetTopRatedMoviesListFailedState) {
                    return CustomErrorWidget(
                      onTap: () => MoviesCubit.get(context)
                          .getMoviesTopRatedMoviesList(),
                      error: state.message,
                    );
                  } else if (state is GetTopRatedMoviesListSuccessState) {
                    return Column(
                      children: List.generate(
                          state.movies.length,
                          (index) => MovieCard(
                                movie: state.movies[index],
                                cacheData: true,
                              ).withPadding(PaddingValues.p15.pSymmetricV)),
                    ).withPadding(PaddingValues.p16.pSymmetricH);
                  } else {
                    return Column(
                      children: [
                        const MovieCardLoading(),
                        AppSize.s30.spaceH,
                        const MovieCardLoading()
                      ],
                    ).withPadding(PaddingValues.p16.pSymmetricH);
                  }
                },
              ).animateSlideFade(6),
            ],
          ),
        ),
      ),
    );
  }
}
