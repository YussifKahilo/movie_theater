import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/exceptions.dart';

Future<Either<T, K>> tryCatch<T, K>(
    {required Future<K> Function() tryFunction,
    required Function(Exception exception) catchFunction}) async {
  try {
    return Right(await tryFunction());
  } on ServerException catch (e, stack) {
    Completer().completeError(e, stack);

    return Left(catchFunction(ServerException(e.toString())));
  } on CacheException catch (e, stack) {
    Completer().completeError(e, stack);

    return Left(catchFunction(CacheException(e.toString())));
  }
}
