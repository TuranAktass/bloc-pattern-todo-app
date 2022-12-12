import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feat/auth/bloc/auth_bloc_bloc.dart';
import 'package:todo_app/feat/auth/view/login/login_page.dart';
import 'package:todo_app/feat/auth/view/register/register_page.dart';
import 'package:todo_app/feat/home/view/home_page.dart';
import 'package:todo_app/l10n/l10n.dart';
import 'package:todo_app/theme/themes.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoApp extends StatelessWidget {
  const TodoApp(
      {Key? key, required this.todosRepository, required this.authRepository})
      : super(key: key);
  final TodosRepository todosRepository;
  final AuthRepository authRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider.value(
        value: todosRepository,
      ),
      RepositoryProvider.value(value: authRepository)
    ], child: TodoAppView());
  }
}

class TodoAppView extends StatelessWidget {
  const TodoAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBlocBloc(authRepository: context.read<AuthRepository>()),
      child: MaterialApp(
        theme: TodosTheme.light,
        darkTheme: TodosTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: TodoAppState(),
      ),
    );
  }
}

class TodoAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: context.read<AuthBlocBloc>(),
        builder: (context, state) {
          log('state is => $state');
          switch (state.runtimeType) {
            case AuthBlocInitial:
              return const LoginPage();
            case LoginSuccess:
              return const HomePage();
            case LoginFailed:
              return const LoginPage();
            case RegisterSuccess:
              log('case register success');
              return const HomePage();
            case RegisterFailed:
              return const RegisterPage();
            case NavigateRegister:
              return const RegisterPage();
            case UserNotFound:
              return const LoginPage();
            default:
              return LoginPage();
          }
        });
  }
}
