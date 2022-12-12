import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bootstrap.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:firebase_todos_api/firebase_todos_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authApi = FirebaseAuthApi();
  final todosApi = FirebaseTodosApi(uid: authApi.currentUser.id);

  bootstrap(todosApi: todosApi, authApi: authApi);
}
