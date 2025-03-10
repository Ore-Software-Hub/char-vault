class ClassModel {
  String id;
  String name;
  int hp;
  List<String> savingThrows;

  ClassModel(
      {required this.id,
      required this.name,
      required this.hp,
      required this.savingThrows});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'hp': hp, 'savingThrows': savingThrows};
  }

  static ClassModel fromMap(Map<dynamic, dynamic> map) {
    var savingThrow = (map['savingThrows'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    var classe = ClassModel(
        id: map['id'],
        name: map['name'],
        hp: map['hp'],
        savingThrows: savingThrow);
    return classe;
  }
}
