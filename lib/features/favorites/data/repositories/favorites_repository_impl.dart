import 'package:movie_theater/core/errors/exceptions.dart';
import 'package:movie_theater/core/network/network_info.dart';
import 'package:movie_theater/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:movie_theater/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:movie_theater/features/movies/data/models/movie_model.dart';

import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDatasource _favoritesRemoteDatasource;
  final NetworkInfo _networkInfo;
  final AuthLocalDatasource _authLocalDatasource;
  FavoritesRepositoryImpl(
    this._favoritesRemoteDatasource,
    this._networkInfo,
    this._authLocalDatasource,
  );
  @override
  Future<(List<MovieModel>, int)> getFavorites(int page) async {
    bool isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      final int? accountId = await _authLocalDatasource.getAccountId();
      final String? sessionId = await _authLocalDatasource.getSessionId();
      final responseModel = await _favoritesRemoteDatasource.getFavorites(
          page: page, sessionId: sessionId!, accountId: accountId!);
      return (responseModel.movies, responseModel.totalPages ?? 1);
    } else {
      throw const NoInternetConnectionException();
    }
  }

  @override
  Future<void> markFavorite(bool favorite, int movieId) async {
    bool isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      final int? accountId = await _authLocalDatasource.getAccountId();
      final String? sessionId = await _authLocalDatasource.getSessionId();
      await _favoritesRemoteDatasource.markFavorite(
          accountId: accountId!,
          favorite: favorite,
          sessionId: sessionId!,
          movieId: movieId);
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
