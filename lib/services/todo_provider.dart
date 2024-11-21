import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_unit.dart';
import '../repositories/storage_methods.dart';

class TodoProvider with ChangeNotifier {
  final _methods = StorageMethods();

  Future<void> addTodo(String todo, bool isCompleted) async {
    var uuid = const Uuid();
    var id = uuid.v4();
    await _methods.addTodo(id, todo, isCompleted);
    notifyListeners();
  }

  Future<void> toggleTodo(TodoUnit todo) async {
    await _methods.updateTodo(todo.id, !todo.isCompleted, todo.title);
    notifyListeners();
  }

  Future<void> deleteTodo(TodoUnit todo) async {
    await _methods.removeTodo(todo.id);
    notifyListeners();
  }
}
