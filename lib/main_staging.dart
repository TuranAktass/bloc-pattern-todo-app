import 'package:flutter/material.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todosApi =
      LocalStorageTodosApi(plugin: await SharedPreferences.getInstance());

  //bootstrap(todosApi: todosApi);
}
