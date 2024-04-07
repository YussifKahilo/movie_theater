import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/core/widgets/custom_text_field.dart';
import 'package:movie_theater/core/widgets/pagination_screen.dart';
import 'package:movie_theater/features/search/presentation/cubit/search_cubit.dart';
import 'package:movie_theater/features/search/presentation/widgets/no_results_widget.dart';
import 'package:movie_theater/features/search/presentation/widgets/start_search_widget.dart';
import 'package:movie_theater/src/injection_container.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../../../movies/presentation/widgets/movie_card_loading.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  } else if (state is SearchSuccessState) {
                    if (state.movies.isEmpty) {
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
                            CustomText(state.totalResults.toString()),
                          ],
                        ).withPadding((PaddingValues.p10, PaddingValues.p16)
                            .pSymmetricVH),
                        Expanded(
                            child: AnimationLimiter(
                          child: PaginationList(
                            padding: (
                              PaddingValues.p16,
                              PaddingValues.p10,
                              PaddingValues.p16,
                              (PaddingValues.p80 + ScreenUtil().bottomBarHeight)
                            )
                                .pOnlyStartTopEndBottom,
                            dataLength: state.movies.length,
                            maxPages: state.totalPages,
                            loadMoreData: (nextPage) {
                              SearchCubit.get(context).searchFor(
                                  searchController.text.trim(), nextPage);
                            },
                            separator: AppSize.s30,
                            widgetBuilder: (index) {
                              return MovieCard(
                                movie: state.movies[index],
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
                          Random().nextInt(3) + 1,
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
