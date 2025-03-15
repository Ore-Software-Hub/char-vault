class PapersModel {
  String id;
  String title;
  String description;
  String tipo;
  bool completed;

  PapersModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tipo,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'description': description,
      'tipo': tipo,
      'completed': completed,
    };
  }

  factory PapersModel.fromMap(Map<dynamic, dynamic> map) {
    var papers = PapersModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      tipo: map['tipo'] ?? '',
      completed: map['completed'] ?? false,
    );
    return papers;
  }

  @override
  String toString() {
    return "Papers(id: $id, title: $title, description: $description, tipo: $tipo, completed: $completed)";
  }
}
