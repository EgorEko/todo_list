import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_unit.dart';

class StorageMethods {
  Stream<List<TodoUnit>> fetchTodos() {
    CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');

    return tasks.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (document) => TodoUnit.fromFirestore(
                  document.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Future<void> addTodo(String id, String title, bool isCompleted) async {
    try {
      CollectionReference tasks =
          FirebaseFirestore.instance.collection('Tasks');
      await tasks.doc(id).set(TodoUnit.toJson(id, title, isCompleted));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTodo(String id, bool isCompleted, String title) async {
    try {
      CollectionReference tasks =
          FirebaseFirestore.instance.collection('Tasks');
      await tasks.doc(id).update(TodoUnit.toJson(id, title, isCompleted));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeTodo(String id) {
    CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');
    return tasks.doc(id).delete();
  }
}
