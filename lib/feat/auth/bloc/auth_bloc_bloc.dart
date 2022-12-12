import 'dart:developer';

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc({required this.authRepository}) : super(AuthBlocInitial()) {
    on<AppStarted>((event, emit) => _initial(event, emit));
    on<LoginStarted>((event, emit) => _login(event, emit));
    on<RegisterStarted>((event, emit) => _register(event, emit));
    on<LoggedOut>((event, emit) => _logout(event, emit));
    on<RegisterRequested>((event, emit) => _registerRequested(event, emit));
  }

  final AuthRepository authRepository;

  _login(event, emit) async {
    try {
      final user = await authRepository.login(login: event.login);
      if (user.id != '') {
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } catch (e) {
      emit(LoginFailed());
    }
  }

  _register(event, emit) async {
    try {
      final user = await authRepository.register(register: event.register);
      if (user.id != '') {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailed());
      }
    } catch (e) {
      emit(RegisterFailed());
    }
  }

  _initial(event, emit) async {
    try {
      final user = authRepository.currentUser;

      if (user.isNotEmpty) {
        log('userId is ' + user.id);
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } catch (e) {
      if (e is UserNotFoundException) {
        emit(UserNotFound());
      } else {
        emit(LoginFailed());
      }
    }
  }

  _logout(event, emit) async {
    log('LOGOUT');
    try {
      await authRepository.logout();
      emit(AuthBlocInitial());
    } catch (e) {
      emit(LoginFailed());
    }
  }

  _registerRequested(event, emit) {
    emit(NavigateRegister());
  }
}
