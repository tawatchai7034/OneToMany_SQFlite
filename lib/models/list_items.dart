class ListItem {
  int id;
  int idList;
  String name;
  double price;
  String date;
  String quantity;
  String note;

  ListItem(this.id, this.idList, this.name, this.price,this.date,this.quantity, this.note);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'idList': idList,
      'name': name,
      'date':date,
      'price': price,
      'quantity': quantity,
      'note': note
    };
  }
}