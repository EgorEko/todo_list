class TodoUnit {
  TodoUnit({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final String id;
  final String title;
  bool isCompleted;

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  TodoUnit.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        title = firestoreMap['title'],
        isCompleted = firestoreMap['isCompleted'];
}
