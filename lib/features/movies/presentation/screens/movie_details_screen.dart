import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theater/core/widgets/blurred_background.dart';
import 'package:movie_theater/core/widgets/custom_back_button.dart';
import 'package:movie_theater/core/widgets/loading.dart';
import 'package:movie_theater/core/widgets/toast.dart';
import 'package:movie_theater/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/durations.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/fonts_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_error_widget.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_details_loading.dart';

import '../../../../core/manager/strings_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/movie.dart';
import '../widgets/movie_grid_card.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    required this.cacheData,
  }) : super(key: key);

  final Movie movie;
  final bool cacheData;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    MoviesCubit.get(context).getMovie(widget.movie.id, widget.cacheData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFav = (FavoritesCubit.get(context).state as GetFavoritesSuccessState)
        .favoritesContains(widget.movie.id);
    return Scaffold(
      body: Stack(
        children: [
          BlurredBackGround(
              customImage: widget.movie.backDropImagePath == null
                  ? const SizedBox()
                  : CustomImage(
                      borderRadius: BorderRadius.zero,
                      basePath: StringsManager.imageBasePath,
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      imageUrl: widget.movie.posterPath.toString(),
                    )),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().statusBarHeight,
                ),
                MovieGridCard(
                  clickAble: false,
                  movie: widget.movie,
                  imageUrl: widget.movie.backDropImagePath.toString(),
                )
                    .withPadding(
                        (PaddingValues.p80, PaddingValues.p30).pTopHorizontal)
                    .animateSlideFade(3,
                        animationDirection: AnimationDirection.tTb),
                AppSize.s16.spaceH,
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      RatingBar(
                        ignoreGestures: true,
                        minRating: 1,
                        maxRating: 10,
                        initialRating: (widget.movie.voteAverage.round() / 2),
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30.rs,
                        ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star_rate_rounded,
                              color: ColorsManager.yellowColor,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: ColorsManager.yellowColor,
                            ),
                            empty: const Icon(
                              Icons.star_rate_rounded,
                              color: ColorsManager.greyLightColor,
                            )),
                        onRatingUpdate: (value) {},
                      ).animateSlideFade(4,
                          animationDirection: AnimationDirection.tTb),
                      AppSize.s10.spaceH,
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
                              '${widget.movie.voteAverage.toStringAsFixed(1)} | ${widget.movie.voteCount.toString()} votes',
                              color: ColorsManager.whiteColor,
                              fontWeight: FontWeightManager.regular,
                              textStyle:
                                  ThemesManager.getDisplayMediumTextStyle(
                                          context)
                                      .copyWith(),
                            )
                          ],
                        ).withPadding(PaddingValues.p2.pSymmetricVH),
                      ).animateSlideFade(5,
                          animationDirection: AnimationDirection.tTb),
                    ],
                  ),
                ),
                AppSize.s16.spaceH,
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        widget.movie.title,
                        textAlign: TextAlign.start,
                        textStyle:
                            ThemesManager.getTitleMediumTextStyle(context),
                      ),
                    ),
                    BlocConsumer<FavoritesCubit, FavoritesState>(
                      listener: (context, state) {
                        if (state is MarkMovieFavoriteFailedState) {
                          showToast(state.message);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is GetFavoritesSuccessState ||
                          current is MarkMovieFavoriteLoadingState,
                      builder: (context, state) {
                        return CustomContainer(
                          onTap: state is MarkMovieFavoriteLoadingState
                              ? null
                              : () {
                                  FavoritesCubit.get(context)
                                      .markFavorites(widget.movie.id, !isFav)
                                      .then((value) => isFav = !isFav);
                                },
                          padding: PaddingValues.p5.pAll,
                          margin: PaddingValues.p5.pAll,
                          transparentButton: true,
                          child: state is MarkMovieFavoriteLoadingState
                              ? const CustomLoading()
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Theme.of(context).iconTheme.color,
                                      size: AppSize.s30.rs,
                                    ),
                                    AnimatedOpacity(
                                      opacity: isFav ? 1 : 0,
                                      duration:
                                          DurationValues.dm250.milliseconds,
                                      child: Icon(
                                        Icons.favorite,
                                        color: ColorsManager.primaryColor,
                                        size: AppSize.s25.rs,
                                      ),
                                    )
                                  ],
                                ),
                        );
                      },
                    )
                  ],
                )
                    .withPadding(PaddingValues.p16.pSymmetricH)
                    .animateSlideFade(6),
                BlocBuilder<MoviesCubit, MoviesState>(
                  buildWhen: (previous, current) =>
                      current is GetMovieFailedState ||
                      current is GetMovieLoadingState ||
                      current is GetMovieSuccessState,
                  builder: (context, state) {
                    if (state is GetMovieFailedState) {
                      return CustomErrorWidget(
                          onTap: () => MoviesCubit.get(context)
                              .getMovie(widget.movie.id, widget.cacheData));
                    } else if (state is GetMovieSuccessState) {
                      return Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.movie.tagline != null &&
                                  state.movie.tagline!.isNotEmpty)
                                CustomText(
                                  '"${state.movie.tagline!}"',
                                  textStyle:
                                      ThemesManager.getDisplayLargeTextStyle(
                                          context),
                                ).animateSlideFade(7),
                              AppSize.s30.spaceH,
                              CustomText(
                                "Description",
                                textStyle: ThemesManager.getTitleSmallTextStyle(
                                    context),
                              ).animateSlideFade(8),
                              AppSize.s5.spaceH,
                              ReadMoreText(
                                state.movie.overview,
                                style: ThemesManager.getDisplayLargeTextStyle(
                                    context),
                                trimLines: 3,
                                colorClickableText: ColorsManager.primaryColor,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: ' Show less',
                                moreStyle:
                                    ThemesManager.getDisplayLargeTextStyle(
                                            context)
                                        .copyWith(
                                            color: ColorsManager.primaryColor),
                              ).animateSlideFade(9),
                              AppSize.s30.spaceH,
                              if (state.movie.productionCompanies != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "Production Companies",
                                      textStyle:
                                          ThemesManager.getTitleSmallTextStyle(
                                              context),
                                    ).animateSlideFade(10),
                                    AppSize.s5.spaceH,
                                    Wrap(
                                      runSpacing: AppSize.s10.rh,
                                      spacing: AppSize.s10.rw,
                                      children: List.generate(
                                          state.movie.productionCompanies!
                                              .length,
                                          (index) => CustomContainer(
                                                haveShadows: true,
                                                shadowColor:
                                                    ColorsManager.greyColor,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CustomImage(
                                                      fit: BoxFit.contain,
                                                      width: AppSize.s50.rw,
                                                      height: AppSize.s50.rh,
                                                      imageUrl: state
                                                          .movie
                                                          .productionCompanies![
                                                              index]
                                                          .logoPath
                                                          .toString(),
                                                      basePath: StringsManager
                                                          .imageBasePath,
                                                    ),
                                                    AppSize.s5.spaceW,
                                                    CustomText(
                                                      state
                                                          .movie
                                                          .productionCompanies![
                                                              index]
                                                          .name,
                                                      textStyle: ThemesManager
                                                          .getDisplayMediumTextStyle(
                                                              context),
                                                    )
                                                  ],
                                                ).withPadding(PaddingValues
                                                    .p5.pSymmetricVH),
                                              ).animateSlideFade(10 + index)),
                                    ),
                                    AppSize.s30.spaceH,
                                  ],
                                ),
                              CustomText(
                                "More Info",
                                textStyle: ThemesManager.getTitleSmallTextStyle(
                                    context),
                              ).animateSlideFade(10),
                              AppSize.s15.spaceH,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    'Release date',
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                  CustomText(
                                    state.movie.releaseDate,
                                    color: ColorsManager.primaryColor,
                                    fontWeight: FontWeightManager.bold,
                                  )
                                ],
                              ).animateSlideFade(11),
                              if (state.movie.status != null) ...[
                                AppSize.s5.spaceH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      'Movie status',
                                      fontWeight: FontWeightManager.regular,
                                    ),
                                    CustomText(
                                      state.movie.status!,
                                      color: ColorsManager.primaryColor,
                                      fontWeight: FontWeightManager.bold,
                                    )
                                  ],
                                ).animateSlideFade(12)
                              ],
                              if (state.movie.runtime != null) ...[
                                AppSize.s5.spaceH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      'Movie time',
                                      fontWeight: FontWeightManager.regular,
                                    ),
                                    CustomText(
                                      '${state.movie.runtime! ~/ 60}h ${state.movie.runtime! % 60}m',
                                      color: ColorsManager.primaryColor,
                                      fontWeight: FontWeightManager.bold,
                                    )
                                  ],
                                ).animateSlideFade(13)
                              ],
                            ],
                          ).withPadding(PaddingValues.p16.pSymmetricH),
                          if (state.movie.homePageUrl != null &&
                              state.movie.homePageUrl!.isNotEmpty) ...[
                            AppSize.s30.spaceH,
                            CustomContainer(
                              onTap: () => launch(state.movie.homePageUrl!),
                              width: double.infinity,
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsManager.primaryColor,
                                    ColorsManager.primaryColor.withOpacity(0.8),
                                    ColorsManager.primaryColor.withOpacity(0.4),
                                    ColorsManager.primaryColor.withOpacity(0.1),
                                    ColorsManager.greyDarkColor.withOpacity(0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              height:
                                  AppSize.s40.rh + ScreenUtil().bottomBarHeight,
                              borderRadius: BorderValues.b15.borderTop,
                              child: Column(
                                children: [
                                  AppSize.s10.spaceH,
                                  CustomText(
                                    'View Movie',
                                    textStyle:
                                        ThemesManager.getTitleSmallTextStyle(
                                            context),
                                    color: ColorsManager.whiteColor,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().bottomBarHeight,
                                  )
                                ],
                              ),
                            ).animateSlideFade(14,
                                animationDirection: AnimationDirection.bTt)
                          ] else
                            SizedBox(
                              height: ScreenUtil().bottomBarHeight,
                            )
                        ],
                      );
                    }
                    return const MovieDetailsLoading();
                  },
                )
              ],
            ),
          ),
          Positioned(
            left: PaddingValues.p16.rw,
            top: PaddingValues.p16.rh + ScreenUtil().statusBarHeight,
            child: const CustomBackButton().animateSlideFade(2),
          ),
        ],
      ),
    );
  }
}
