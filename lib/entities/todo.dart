class TodoEntity {
  final int? id;
  final String text;
  final bool isDone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int priority;

  TodoEntity({
    required this.text,
    required this.priority,
    this.isDone = false,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  TodoEntity copyWith({
    int? id,
    String? text,
    bool? isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? priority,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
    );
  }

//1969-07-20 20:18:04Z
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'priority': priority,
    };
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id'],
      text: map['text'],
      isDone: map['isDone'] == 1 ? true : false,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      priority: map['priority'],
    );
  }
}
