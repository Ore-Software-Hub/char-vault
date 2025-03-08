class ItemModel {
  String id;
  String title;
  String quantity;
  String value;
  String description;
  String tipo;

  ItemModel(this.id, this.title, this.quantity, this.value, this.description,
      this.tipo);

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
    return ItemModel(map['id'], map['title'], map['quantity'], map['value'],
        map['description'], map['tipo']);
  }
}
