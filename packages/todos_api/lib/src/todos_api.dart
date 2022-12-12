// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:todos_api/todos_api.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  /// Returns a list of all todos as a stream
  Stream<List<Todo>> getTodos();

  /// Creates a new todo
  Future<void> saveTodo(Todo todo);

  /// Deletes a todo
  Future<void> deleteTodo(String id);

  ///deletes all completed todos
  Future<int> clearCompleted();

  /// all todos are marked as completed
  Future<int> completeAll({required bool isCompleted});
}

class TodoNotFoundException implements Exception {}
