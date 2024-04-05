import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_theater/features/movies/presentation/widgets/upcoming_movies_section_loading.dart';
import '/core/extensions/padding_manager.dart';
import '/core/extensions/spacer.dart';
import '/core/features/theme/presentation/widget/theme_button.dart';
import '/core/manager/assets_manager.dart';
import '/core/manager/color_manager.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/custom_error_widget.dart';
import '/core/widgets/custom_svg.dart';
import '/core/widgets/custom_text.dart';
import '/core/widgets/loading.dart';
import '/features/movies/domain/entities/movie.dart';
import '/features/movies/presentation/cubit/movies_cubit.dart';
import '/features/movies/presentation/widgets/upcoming_movies_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().statusBarHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSvg(
                AssetsManager.appIcon,
                size: AppSize.s50,
                color: ColorsManager.primaryColor,
              ),
              ThemeButton()
            ],
          ).withPadding(PaddingValues.p16.pSymmetricVH),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      textStyle:
                          ThemesManager.getDisplayLargeTextStyle(context),
                      text: 'View more',
                      onTap: () {},
                    )
                  ],
                ).withPadding(
                    (PaddingValues.p16, PaddingValues.p20).pSymmetricVH),
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
                        return UpcomingMoviesSection(movies: state.movies);
                      } else {
                        return const UpcomingMoviesSectionLoading();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    'Top Rated',
                    textStyle: ThemesManager.getTitleLargeTextStyle(context),
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
                onTap: () {},
              )
            ],
          ).withPadding((PaddingValues.p16, PaddingValues.p20).pSymmetricVH),
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
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: PaddingValues.p16.pSymmetricH,
                    child: Column(
                      children: List.generate(
                          state.movies.length,
                          (index) => MovieCard(movie: state.movies[index])
                              .withPadding(PaddingValues.p20.pSymmetricV)),
                    ),
                  );
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
