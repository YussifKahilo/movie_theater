import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/config/routes/routes.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movie_theater/features/favorites/presentation/widgets/favorites_list.dart';
import 'package:movie_theater/features/search/presentation/widgets/no_results_widget.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/presentation/widgets/movie_card_loading.dart';
import '../cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GetUserFailedState ||
          current is GetUserLoadingState ||
          current is GetUserSuccessState,
      builder: (context, state) {
        if (state is GetUserSuccessState) {
          return BlocBuilder<FavoritesCubit, FavoritesState>(
            buildWhen: (previous, current) =>
                current is GetFavoritesFailedState ||
                current is GetFavoritesLoadingState ||
                current is GetFavoritesSuccessState ||
                current is GetMoreFavorites,
            builder: (context, state) {
              if (state is GetFavoritesFailedState) {
                return CustomErrorWidget(onTap: () {
                  FavoritesCubit.get(context).getFavorites(1);
                });
              } else if (state is GetMoreFavorites ||
                  state is GetFavoritesSuccessState) {
                final List<Movie> movies = state is GetMoreFavorites
                    ? state.movies
                    : (state as GetFavoritesSuccessState).movies;
                if (movies.isEmpty) {
                  return const NoResultsWidget(
                    text: 'You did not add any movies in your favorites',
                  );
                }
                int totalPages = state is GetMoreFavorites
                    ? state.totalPages
                    : (state as GetFavoritesSuccessState).totalPages;
                return FavoritesList(totalPages: totalPages, movies: movies);
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
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'You have to login to access this page',
              ),
              AppSize.s30.spaceH,
              CustomContainer(
                onTap: () => Navigator.pushNamed(context, Routes.loginScreen)
                    .then((value) => value != null
                        ? FavoritesCubit.get(context).getFavorites(1)
                        : null),
                haveShadows: true,
                padding: (PaddingValues.p10, PaddingValues.p80).pSymmetricVH,
                text: 'Login',
              ),
              AppSize.s100.spaceH,
            ],
          );
        }
      },
    );
  }
}
