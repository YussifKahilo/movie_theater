import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_theater/core/db/db_consumer.dart';
import 'package:movie_theater/core/db/sql_consumer.dart';
import 'package:movie_theater/core/manager/strings_manager.dart';
import 'package:movie_theater/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:movie_theater/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:movie_theater/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movie_theater/features/auth/domain/repositories/auth_repository.dart';
import 'package:movie_theater/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:movie_theater/features/auth/domain/usecases/login_usecase.dart';
import 'package:movie_theater/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:movie_theater/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:movie_theater/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:movie_theater/features/favorites/domain/usecases/get_favorites_list.dart';
import 'package:movie_theater/features/favorites/domain/usecases/mark_favorite_usecase.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_local_datasource.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_remote_datasource.dart';
import 'package:movie_theater/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movie_theater/features/movies/domain/repositories/movies_repository.dart';
import 'package:movie_theater/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie_theater/features/search/domain/usecases/search_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_consumer.dart';
import '../core/api/app_interceptor.dart';
import '../core/api/dio_consumer.dart';
import '../core/cache/cache_consumer.dart';
import '../core/cache/cache_consumer_impl.dart';
import '../core/network/network_info.dart';
import '../core/features/theme/data/datasources/theme_local_datasource.dart';
import '../core/features/theme/data/repositories/theme_repository_impl.dart';
import '../core/features/theme/domain/repositories/theme_repository.dart';
import '../core/features/theme/domain/usecases/change_theme.dart';
import '../core/features/theme/domain/usecases/get_saved_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

import '../features/movies/domain/usecases/get_movie_usecase.dart';

final diInstance = GetIt.instance;

Future<void> initAppModule() async {
  //! Features
  initThemeModule();
  initMoviesModule();
  initAuthModule();
  initFavoritesModule();

  //! Core
  diInstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: diInstance()));
  diInstance.registerLazySingleton<ApiConsumer>(() => DioConsumer(
      dio: diInstance(), baseUrl: dotenv.env[StringsManager.baseUrlEnvKey]!));
  diInstance.registerLazySingleton<DBConsumer>(
      () => SQLConsumer('${StringsManager.appName}.db'));
  diInstance.registerLazySingleton<CacheConsumer>(
      () => CacheConsumerImpl(sharedPreferences: diInstance()));
  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  diInstance.registerLazySingleton(() => sharedPreferences);
  diInstance.registerLazySingleton(() => Dio());

  diInstance.registerLazySingleton(() => AppInterceptors());
  diInstance.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  diInstance.registerLazySingleton(() => InternetConnectionChecker());
}

Future<void> initThemeModule() async {
  //?Use cases
  diInstance.registerLazySingleton<GetSavedThemeUseCase>(
      () => GetSavedThemeUseCase(themeRepository: diInstance()));
  diInstance.registerLazySingleton<ChangeThemeUseCase>(
      () => ChangeThemeUseCase(themeRepository: diInstance()));

  //?Repositories
  diInstance.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDataSource: diInstance()));

  //?Data Sources
  diInstance.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(cacheConsumer: diInstance()));
}

Future<void> initAuthModule() async {
  //?Use cases
  diInstance.registerLazySingleton<GetUserUsecase>(
      () => GetUserUsecase(diInstance()));
  diInstance
      .registerLazySingleton<LoginUsecase>(() => LoginUsecase(diInstance()));

  //?Repositories
  diInstance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(diInstance(), diInstance(), diInstance()));

  //?Data Sources
  diInstance.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(diInstance()));
  diInstance.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(diInstance()));
}

Future<void> initFavoritesModule() async {
  //?Use cases
  diInstance.registerLazySingleton<GetFavoritesUsecase>(
      () => GetFavoritesUsecase(diInstance()));
  diInstance.registerLazySingleton<MarkFavoritesUsecase>(
      () => MarkFavoritesUsecase(diInstance()));

  //?Repositories
  diInstance.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(diInstance(), diInstance(), diInstance()));

  //?Data Sources
  diInstance.registerLazySingleton<FavoritesRemoteDatasource>(
      () => FavoritesRemoteDatasourceImpl(diInstance()));
}

Future<void> initMoviesModule() async {
  //?Use cases
  diInstance.registerLazySingleton<GetMoviesUsecase>(
      () => GetMoviesUsecase(diInstance()));
  diInstance.registerLazySingleton<GetMovieUsecase>(
      () => GetMovieUsecase(diInstance()));
  //?Search Usecase
  diInstance.registerLazySingleton<SearchMovieUsecase>(
      () => SearchMovieUsecase(diInstance()));

  //?Repositories
  diInstance.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(diInstance(), diInstance(), diInstance()));

  //?Data Sources
  diInstance.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(diInstance()));
  diInstance.registerLazySingleton<MoviesLocaleDataSource>(
      () => MoviesLocaleDataSourceImpl(diInstance()));
}
