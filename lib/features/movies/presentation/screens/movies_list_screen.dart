import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/cubit/custom_cubit.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/widgets/custom_app_bar.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/custom_error_widget.dart';
import 'package:movie_theater/core/widgets/pagination.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_grid_card.dart';

import '../../../../config/theme/themes_manager.dart';
import '../../../../core/manager/assets_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../../core/widgets/custom_text.dart';
import '../widgets/movie_card_loading.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({
    Key? key,
    required this.movieSection,
  }) : super(key: key);

  final MovieSection movieSection;

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  void initState() {
    MoviesCubit.get(context).getMovies(1, widget.movieSection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int page = 1;
    return BlocProvider(
      create: (context) => CustomCubit<bool>(false),
      child: Scaffold(
        appBar: CustomAppBar(
          showLeading: true,
          actions: [
            BlocBuilder<CustomCubit<bool>, bool>(
              builder: (context, state) {
                return CustomContainer(
                  onTap: () =>
                      CustomCubit.get<bool>(context).changeState(!state),
                  transparentButton: true,
                  margin: PaddingValues.p16.pOnlyEnd,
                  child: state
                      ? const Icon(Icons.grid_view_rounded)
                      : const Icon(Icons.list_rounded),
                );
              },
            )
          ],
          titleWidget: switch (widget.movieSection) {
            MovieSection.topRated => Row(
                children: [
                  CustomText(
                    'Top Rated',
                    textStyle: ThemesManager.getTitleSmallTextStyle(context),
                  ),
                  AppSize.s5.spaceW,
                  const CustomSvg(
                    AssetsManager.starIcon,
                    color: ColorsManager.yellowColor,
                    size: AppSize.s30,
                  )
                ],
              ),
            _ => CustomText(
                'Discover',
                textStyle: ThemesManager.getTitleSmallTextStyle(context),
              ),
          },
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          buildWhen: (previous, current) =>
              current is GetMoviesFailedState ||
              current is GetMoviesLoadingState ||
              current is GetMoviesSuccessState ||
              current is GetMoreMovies,
          builder: (context, state) {
            if (state is GetMovieFailedState) {
              return CustomErrorWidget(onTap: () {
                MoviesCubit.get(context).getMovies(1, widget.movieSection);
              });
            } else if (state is GetMoreMovies ||
                state is GetMoviesSuccessState) {
              final List<Movie> movies = state is GetMoreMovies
                  ? state.movies
                  : (state as GetMoviesSuccessState).movies;
              int totalPages = state is GetMoreMovies
                  ? state.totalPages
                  : (state as GetMoviesSuccessState).totalPages;
              return BlocBuilder<CustomCubit<bool>, bool>(
                builder: (context, state) {
                  if (state) {
                    return PaginationGrid(
                      separator: AppSize.s30,
                      maxPages: totalPages,
                      dataLength: movies.length,
                      loadMoreData: () {
                        MoviesCubit.get(context)
                            .getMovies(++page, widget.movieSection);
                      },
                      widgetBuilder: (index) => MovieGridCard(
                              cacheData: false,
                              clickAble: true,
                              movie: movies[index])
                          .animateSlideFade(index,
                              animationDirection: AnimationDirection.tTb),
                      page: page,
                    );
                  } else {
                    return PaginationList(
                        page: page,
                        separator: AppSize.s30,
                        maxPages: totalPages,
                        dataLength: movies.length,
                        loadMoreData: () {
                          MoviesCubit.get(context)
                              .getMovies(++page, widget.movieSection);
                        },
                        widgetBuilder: (int index) =>
                            MovieCard(movie: movies[index], cacheData: false)
                                .animateSlideFade(index));
                  }
                },
              );
            } else {
              return Column(
                children: List.generate(
                    Random().nextInt(3) + 1,
                    (index) => const MovieCardLoading()
                        .withPadding(PaddingValues.p15.pSymmetricV)),
              ).withPadding(
                  (PaddingValues.p40, PaddingValues.p16).pSymmetricVH);
            }
          },
        ),
      ),
    );
  }
}
