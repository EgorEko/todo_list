import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/todo_unit.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoUnit> _todos = [];

  UnmodifiableListView<TodoUnit> get allTodos => UnmodifiableListView(_todos);

  void addTodo(String todo, bool isCompleted) {
    _todos.add(TodoUnit(title: todo, isCompleted: isCompleted));
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
