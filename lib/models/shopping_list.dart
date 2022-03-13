class ShoppingList {
  int id;
  String name;
  String gender;
  String species;

  ShoppingList(this.id, this.name, this.gender,this.species);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'name': name,
      'gender': gender,
      'species': species,
    };
  }


}