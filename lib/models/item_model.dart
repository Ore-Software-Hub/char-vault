class ItemModel {
  String id;
  String title;
  String value;
  String description;
  String tipo;

  ItemModel(this.id, this.title, this.value, this.description, this.tipo);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'description': description,
      'tipo': tipo,
    };
  }

  static ItemModel fromMap(Map<dynamic, dynamic> map) {
    return ItemModel(
        map['id'], map['title'], map['value'], map['description'], map['tipo']);
  }
}
