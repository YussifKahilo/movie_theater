import 'package:movie_theater/core/api/api_consumer.dart';
import 'package:movie_theater/core/api/endpoints.dart';
import 'package:movie_theater/core/extensions/strings_customizability.dart';
import 'package:movie_theater/features/movies/data/models/movies_response_model.dart';

abstract class FavoritesRemoteDatasource {
  Future<void> markFavorite(
      {required int accountId,
      required bool favorite,
      required String sessionId,
      required int movieId});

  Future<MoviesResponseModel> getFavorites(
      {required String sessionId, required int accountId, required int page});
}

class FavoritesRemoteDatasourceImpl implements FavoritesRemoteDatasource {
  final ApiConsumer _apiConsumer;

  FavoritesRemoteDatasourceImpl(this._apiConsumer);

  @override
  Future<void> markFavorite(
      {required int accountId,
      required bool favorite,
      required String sessionId,
      required int movieId}) async {
    await _apiConsumer.postData(
        url: EndPoints.markFavorite.placeId(accountId.toString()),
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": favorite
        },
        query: {
          'session_id': sessionId,
        });
  }

  @override
  Future<MoviesResponseModel> getFavorites(
      {required String sessionId,
      required int accountId,
      required int page}) async {
    final response = await _apiConsumer.getData(
        url: EndPoints.favorites.placeId(accountId.toString()),
        query: {'session_id': sessionId, 'page': page});
    return MoviesResponseModel.fromMap(response.data);
  }
}
