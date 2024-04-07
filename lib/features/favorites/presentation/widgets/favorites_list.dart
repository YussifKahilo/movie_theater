import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/config/theme/themes_manager.dart';

import 'package:movie_theater/core/cubit/custom_cubit.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/manager/fonts_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/pagination.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movie_theater/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_theater/features/movies/presentation/widgets/movie_grid_card.dart';

import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList(
      {Key? key, required this.totalPages, required this.movies})
      : super(key: key);

  final int totalPages;
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    int page = 1;
    return AnimationLimiter(
      child: BlocProvider(
          create: (context) => CustomCubit<bool>(false),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (AuthCubit.get(context).state is GetUserSuccessState)
                          CustomText(
                            "${(AuthCubit.get(context).state as GetUserSuccessState).user.userName}'s",
                            textAlign: TextAlign.start,
                            textStyle:
                                ThemesManager.getTitleSmallTextStyle(context),
                          ),
                        CustomText(
                          'Favorites',
                          textAlign: TextAlign.start,
                          fontSize: FontSize.f45,
                          height: 1,
                          textStyle:
                              ThemesManager.getTitleLargeTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CustomCubit<bool>, bool>(
                    builder: (context, state) {
                      return CustomContainer(
                        onTap: () =>
                            CustomCubit.get<bool>(context).changeState(!state),
                        transparentButton: true,
                        child: state
                            ? const Icon(Icons.grid_view_rounded)
                            : const Icon(Icons.list_rounded),
                      );
                    },
                  ),
                ],
              ).withPadding(PaddingValues.p30.pSymmetricH),
              Expanded(
                child: BlocBuilder<CustomCubit<bool>, bool>(
                  builder: (context, state) {
                    if (state) {
                      return PaginationGrid(
                        separator: AppSize.s30,
                        maxPages: totalPages,
                        dataLength: movies.length,
                        loadMoreData: () {
                          FavoritesCubit.get(context).getFavorites(++page);
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
                            FavoritesCubit.get(context).getFavorites(++page);
                          },
                          widgetBuilder: (int index) =>
                              MovieCard(movie: movies[index], cacheData: false)
                                  .animateSlideFade(index));
                    }
                  },
                ),
              )
            ],
          )),
    );
  }
}
