class TodoUnit {
  TodoUnit({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final String id;
  final String title;
  bool isCompleted;

  static Map<String, dynamic> toJson(
    String id,
    String title,
    bool isCompleted,
  ) =>
      {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  TodoUnit.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        title = firestoreMap['title'],
        isCompleted = firestoreMap['isCompleted'];
}
