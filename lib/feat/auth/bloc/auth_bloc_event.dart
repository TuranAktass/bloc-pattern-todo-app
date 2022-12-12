part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthBlocEvent {}

class LoggedOut extends AuthBlocEvent {
  @override
  List<Object> get props => [];
}

class RegisterStarted extends AuthBlocEvent {
  final Register register;

  const RegisterStarted({required this.register});

  @override
  List<Object> get props => [register];

  @override
  String toString() => 'Register { register: $register }';
}

class LoginStarted extends AuthBlocEvent {
  final Login login;

  const LoginStarted({required this.login});

  @override
  List<Object> get props => [login];

  @override
  String toString() => 'Login { login: $login }';
}

class RegisterRequested extends AuthBlocEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Register { register:  }';
}
