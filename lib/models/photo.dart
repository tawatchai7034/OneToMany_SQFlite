class Photo {
  
  int id;
  int idPro;
  int idTime;
  String photo_name;

  Photo(this.id,this.idPro,this.idTime, this.photo_name);

  Photo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
      idPro = map['idPro'],
      idTime = map['idTime'],
        photo_name = map['photo_name'];

  // Map<String, dynamic> toMap() {
  //   var map = <String, dynamic>{
  //     'id': id,
  //     'photo_name': photo_name,
  //   };
  //   return map;
  // }

  Map<String, dynamic?> toMap() {
    return {
      'id': id,
      'id': idPro,
      'id': idTime,
      'photo_name': photo_name,
    };
  }
  // Photo.fromMap(Map<String, dynamic> map) {
  //   id = map['id'];
  //   photo_name = map['photo_name'];
  // }
}
