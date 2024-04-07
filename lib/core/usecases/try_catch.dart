import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/exceptions.dart';
import 'package:movie_theater/core/errors/failure.dart';

Future<Either<Failure, T>> tryCatch<T>(
    {required Future<T> Function() tryFunction}) async {
  try {
    return Right(await tryFunction());
  } on ServerException catch (e, stack) {
    Completer().completeError(e, stack);
    return Left(ServerFailure(e.message));
  } on CacheException catch (e, stack) {
    Completer().completeError(e, stack);
    return Left(CacheFailure(e.message));
  }
}
