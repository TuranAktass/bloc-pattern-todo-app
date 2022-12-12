part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthBlocInitial extends AuthBlocState {
  const AuthBlocInitial();

  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class RegisterFailed extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class UserNotFound extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class NavigateRegister extends AuthBlocState {
  @override
  List<Object> get props => [];
}
