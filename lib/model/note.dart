class Note {
  String id;
  String title;
  String description;
  DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // Convert Note object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create Note object from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
