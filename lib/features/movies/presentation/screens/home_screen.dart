import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_error_widget.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/core/widgets/loading.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/cubit/movies_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        .getMoviesList(MovieSection.upComing),
                    error: state.message,
                  );
                } else if (state is GetUpComingMoviesListSuccessState) {
                  return ListView.separated(
                      itemBuilder: (context, index) =>
                          CustomText(state.movies[index].title),
                      separatorBuilder: (context, index) => AppSize.s10.spaceH,
                      itemCount: state.movies.length);
                } else {
                  return const Center(child: CustomLoading());
                }
              },
            ),
          ),
          Container(
            color: ColorsManager.redColor,
            height: 5,
            width: double.infinity,
          ),
          Expanded(
            child: BlocBuilder<MoviesCubit, MoviesState>(
              buildWhen: (previous, current) =>
                  current is GetTopRatedMoviesListFailedState ||
                  current is GetTopRatedMoviesListLoadingState ||
                  current is GetTopRatedMoviesListSuccessState,
              builder: (context, state) {
                if (state is GetTopRatedMoviesListFailedState) {
                  return CustomErrorWidget(
                    onTap: () => MoviesCubit.get(context)
                        .getMoviesList(MovieSection.upComing),
                    error: state.message,
                  );
                } else if (state is GetTopRatedMoviesListSuccessState) {
                  return ListView.separated(
                      itemBuilder: (context, index) =>
                          CustomText(state.movies[index].title),
                      separatorBuilder: (context, index) => AppSize.s10.spaceH,
                      itemCount: state.movies.length);
                } else {
                  return const Center(child: CustomLoading());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
