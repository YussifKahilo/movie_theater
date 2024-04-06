import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movie_theater/core/extensions/print_extension.dart';

class NetworkConnectivityCubit extends Cubit<bool> {
  StreamSubscription? _subscription;
  NetworkConnectivityCubit() : super(true);

  static NetworkConnectivityCubit get(context) => BlocProvider.of(context);

  void checkConnection() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      (result).dLog();
      emit(result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile);
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
