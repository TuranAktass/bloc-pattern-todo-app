// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:todos_api/todos_api.dart';

/// {@template todos_repository}
/// A repository that handles todo related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({required TodosApi todosApi}) : _todosApi = todosApi;

  final TodosApi _todosApi;

  /// Returns a list of todos.
  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  /// Creates a new todo.
  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  /// Deletes a todo.
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  /// Deletes all completed todos.
  Future<int> clearCompleted() => _todosApi.clearCompleted();

  /// set all todos as completed.
  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);
}
