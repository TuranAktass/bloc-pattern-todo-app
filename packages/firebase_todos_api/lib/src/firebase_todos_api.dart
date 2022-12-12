// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_api/todos_api.dart';

/// {@template firebase_todos_api}
/// firebase api for todos
/// {@endtemplate}
class FirebaseTodosApi extends TodosApi {
  /// {@macro firebase_todos_api}
  FirebaseTodosApi({required String uid}) : _uid = uid {
    _init();
  }

  final _storage = FirebaseFirestore.instance;
  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);
  final String _uid;

  void _init() {
    _storage
        .collection('users')
        .doc(_uid)
        .collection('todos')
        .snapshots()
        .listen((snapshot) {
      final todos = snapshot.docs
          .map((doc) => Todo.fromJson(Map<String, dynamic>.from(doc.data())))
          .toList();
      _todoStreamController.add(todos);
    });
  }

  @override
  Future<int> clearCompleted() async {
    var counter = 0;
    await _storage
        .collection('users')
        .doc(_uid)
        .collection('todos')
        .where('isCompleted', isEqualTo: true)
        .get()
        .then((snapshot) {
      for (final DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        counter++;
      }
    });

    return counter;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount =
        todos.where((element) => element.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted)
    ];
    _todoStreamController.add(newTodos);
    await _storage
        .collection('users')
        .doc(_uid)
        .collection('todos')
        .where('isCompleted', isEqualTo: !isCompleted)
        .get()
        .then((snapshot) {
      for (final DocumentSnapshot ds in snapshot.docs) {
        ds.reference.update({'isCompleted': isCompleted});
      }
    });

    return changedTodosAmount;
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((element) => element.id == id);
    if (todoIndex == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      await _storage
          .collection('users')
          .doc(_uid)
          .collection('todos')
          .doc(id)
          .delete();
    }
  }

  @override
  Stream<List<Todo>> getTodos() {
    return _todoStreamController.asBroadcastStream();
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((element) => element.id == todo.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
      await _storage
          .collection('users')
          .doc(_uid)
          .collection('todos')
          .doc(todo.id)
          .update(todo.toJson());
    } else {
      todos.add(todo);
      await _storage
          .collection('users')
          .doc(_uid)
          .collection('todos')
          .doc(todo.id)
          .set(todo.toJson());
    }
  }
}
