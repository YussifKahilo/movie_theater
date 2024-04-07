part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class FailedState extends AuthState {
  final String message;

  const FailedState(this.message);
}

class GetUserFailedState extends FailedState {
  const GetUserFailedState(super.message);
}

class GetUserLoadingState extends AuthState {}

class GetUserSuccessState extends AuthState {
  final User user;
  const GetUserSuccessState(this.user);
}

class LoginLoadingState extends AuthState {}

class LoginFailedState extends AuthState {
  final String message;
  const LoginFailedState(this.message);
}
