import 'package:cloud_firestore/cloud_firestore.dart';

class TodoUnit {
  TodoUnit({
    required this.title,
    required this.isCompleted,
  });

  final String title;
  bool isCompleted;

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': isCompleted,
      };

  static TodoUnit fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TodoUnit(
      title: snapshot['title'],
      isCompleted: snapshot['completed'],
    );
  }
}
