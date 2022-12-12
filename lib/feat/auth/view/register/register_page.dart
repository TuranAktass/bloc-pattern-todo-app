import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/feat/auth/bloc/auth_bloc_bloc.dart';
import 'package:todo_app/l10n/l10n.dart';

import 'package:todo_app/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        body: BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.registerFailed)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.register,
                style: TextStyle(
                  fontSize: 24,
                )),
            16.hSizedBox,
            TodoTextField(
              controller: emailController,
              decoration: InputDecoration(hintText: l10n.email),
            ),
            16.hSizedBox,
            TodoTextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: l10n.password),
            ),
            16.hSizedBox,
            BlocBuilder<AuthBlocBloc, AuthBlocState>(
              builder: (context, state) => TodoButton(
                onTap: () => context.read<AuthBlocBloc>().add(RegisterStarted(
                    register: Register(
                        email: emailController.text,
                        password: passwordController.text))),
                text: l10n.register,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
