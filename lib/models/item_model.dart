class ItemModel {
  String id;
  String title;
  String quantity;
  String value;
  String description;
  String tipo;

  ItemModel(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.value,
      required this.description,
      required this.tipo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'value': value,
      'description': description,
      'tipo': tipo,
    };
  }

  static ItemModel fromMap(Map<dynamic, dynamic> map) {
    return ItemModel(
        id: map['id'],
        title: map['title'],
        quantity: map['quantity'],
        value: map['value'],
        description: map['description'],
        tipo: map['tipo']);
  }
}
