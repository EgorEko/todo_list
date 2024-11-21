import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_unit.dart';

class StorageMethods {
  Future<void> addTodo(String id, String title, bool isCompleted) async {
    try {
      CollectionReference tasks =
          FirebaseFirestore.instance.collection('Tasks');
      await tasks.add(
        {
          'id': id,
          'title': title,
          'isCompleted': isCompleted,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

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
}
