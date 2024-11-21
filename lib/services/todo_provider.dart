import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_unit.dart';
import '../repositories/storage_methods.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoUnit> _todos = [];
  final methods = StorageMethods();

  UnmodifiableListView<TodoUnit> get allTodos => UnmodifiableListView(_todos);

  Future<void> addTodo(String todo, bool isCompleted) async {
    var uuid = const Uuid();
    var id = uuid.v4();
    _todos.add(TodoUnit(id: id, title: todo, isCompleted: isCompleted));
    await methods.addTodo(id, todo, isCompleted);
    notifyListeners();
  }

  void toggleTodo(TodoUnit todo) {
    final todoIndex = _todos.indexOf(todo);
    _todos[todoIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(TodoUnit todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}
