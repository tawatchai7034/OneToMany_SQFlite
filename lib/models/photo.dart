class Photo {
  int id;
  String photo_name;

  Photo(this.id, this.photo_name);

  Photo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
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
      'photo_name': photo_name,
    };
  }
  // Photo.fromMap(Map<String, dynamic> map) {
  //   id = map['id'];
  //   photo_name = map['photo_name'];
  // }
}
