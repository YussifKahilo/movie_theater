import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/auth/domain/entities/login_inputs.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/usecases/get_user_usecase.dart';
import '/features/auth/domain/usecases/login_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final GetUserUsecase _getUserUsecase;

  AuthCubit(
    this._loginUsecase,
    this._getUserUsecase,
  ) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Future<void> login(
      {required String userName, required String password}) async {
    emit(LoginLoadingState());

    final result = await _loginUsecase
        .call(LoginInputs(userName: userName, password: password));

    result.fold((l) => emit(LoginFailedState(l.message ?? 'Error')), (r) async {
      await getUser(r);
    });
  }

  Future<void> getUser(String? sessionId) async {
    emit(GetUserLoadingState());
    final result = await _getUserUsecase.call(sessionId);

    result.fold((failure) {
      emit(GetUserFailedState(failure.message ?? 'Error'));
    }, (r) {
      emit(GetUserSuccessState(r));
    });
  }

  void logout() {}
}
