import 'dart:async';
import 'dart:developer';

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/todo_app/todo_app.dart';
import 'package:todo_app/todo_app/todo_app_observer.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

void bootstrap({required TodosApi todosApi, required AuthApi authApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = TodosBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);
  final authRepository = AuthRepository(authApi: authApi);

  runZonedGuarded(
      () => runApp(TodoApp(
          todosRepository: todosRepository, authRepository: authRepository)),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
