import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/core/widgets/custom_text_field.dart';
import 'package:movie_theater/core/widgets/pagination.dart';
import 'package:movie_theater/features/search/presentation/cubit/search_cubit.dart';
import 'package:movie_theater/features/search/presentation/widgets/no_results_widget.dart';
import 'package:movie_theater/features/search/presentation/widgets/start_search_widget.dart';
import 'package:movie_theater/src/injection_container.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../../../movies/presentation/widgets/movie_card_loading.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int page = 1;
    final TextEditingController searchController = TextEditingController();
    return BlocProvider(
        create: (context) => SearchCubit(diInstance()),
        child: Column(
          children: [
            Builder(builder: (context) {
              return CustomTextField(
                      onChanged: (newValue) {
                        SearchCubit.get(context).searchFor(newValue.trim(), 1);
                      },
                      controller: searchController,
                      textInputType: TextInputType.text)
                  .withPadding(
                      (PaddingValues.p16, PaddingValues.p16).pTopHorizontal);
            }),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial || searchController.text.isEmpty) {
                    return const StartSearchWidget();
                  } else if (state is SearchSuccessState ||
                      state is MoreSearchSuccessState) {
                    final List<Movie> movies = state is SearchSuccessState
                        ? state.movies
                        : (state as MoreSearchSuccessState).movies;
                    int totalPages = state is SearchSuccessState
                        ? state.totalPages
                        : (state as MoreSearchSuccessState).totalPages;
                    int totalResults = state is SearchSuccessState
                        ? state.totalResults
                        : (state as MoreSearchSuccessState).totalPages;

                    if (movies.isEmpty) {
                      return NoResultsWidget(
                        title: searchController.text.trim(),
                      );
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CustomText('Results of "'),
                                CustomText(
                                  searchController.text.trim(),
                                  color: ColorsManager.primaryColor,
                                  textStyle:
                                      ThemesManager.getTitleMediumTextStyle(
                                          context),
                                ),
                                const CustomText('"'),
                              ],
                            ),
                            CustomText(totalResults.toString()),
                          ],
                        ).withPadding((PaddingValues.p10, PaddingValues.p16)
                            .pSymmetricVH),
                        Expanded(
                            child: AnimationLimiter(
                          child: PaginationList(
                            page: page,
                            padding: (
                              PaddingValues.p16,
                              PaddingValues.p10,
                              PaddingValues.p16,
                              (PaddingValues.p80 +
                                  (Platform.isAndroid
                                      ? PaddingValues.p50.rh
                                      : ScreenUtil().bottomBarHeight))
                            )
                                .pOnlyStartTopEndBottom,
                            dataLength: movies.length,
                            maxPages: totalPages,
                            loadMoreData: () {
                              SearchCubit.get(context).searchFor(
                                  searchController.text.trim(), ++page);
                            },
                            separator: AppSize.s30,
                            widgetBuilder: (int index) {
                              return MovieCard(
                                movie: movies[index],
                                cacheData: false,
                              ).animateSlideFade(index);
                            },
                          ),
                        )),
                      ],
                    );
                  } else {
                    return Column(
                      children: List.generate(
                          1,
                          (index) => const MovieCardLoading()
                              .withPadding(PaddingValues.p15.pSymmetricV)),
                    ).withPadding(
                        (PaddingValues.p40, PaddingValues.p16).pSymmetricVH);
                  }
                },
              ),
            )
          ],
        ));
  }
}
