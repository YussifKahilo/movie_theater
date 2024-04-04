import 'dart:async';

import 'package:dartz/dartz.dart';

Future<Either<T, K>> tryCatch<T, K>(
    {required Future<K> Function() tryFunction,
    required Function(String message) catchFunction}) async {
  try {
    return Right(await tryFunction());
  } catch (e, stack) {
    Completer().completeError(e, stack);

    return Left(catchFunction(e.toString()));
  }
}
