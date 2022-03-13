class ListItem {
  int id;
  int idList;
  String name;
  double price;
  String quantity;
  String note;

  ListItem(this.id, this.idList, this.name, this.price,this.quantity, this.note);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'idList': idList,
      'name': name,
      'price': price,
      'quantity': quantity,
      'note': note
    };
  }
}