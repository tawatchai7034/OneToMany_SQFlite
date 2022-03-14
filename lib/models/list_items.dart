class ListItem {
  int id;
  int idList;
  double bodyLenght;
  double heartGirth;
  double hearLenghtSide;
  double hearLenghtRear;
  double hearLenghtTop;
  double pixelReference;
  double distanceReference;
  String date;
  String quantity;
  String note;

  ListItem(
    this.id,
    this.idList,
    this.bodyLenght,
    this.heartGirth,
    this.hearLenghtSide,
    this.hearLenghtRear,
    this.hearLenghtTop,
    this.pixelReference,
    this.distanceReference,
    this.date,
    this.quantity,
    this.note,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'idList': idList,
      'bodyLenght': bodyLenght,
      'heartGirth': heartGirth,
      'hearLenghtSide': hearLenghtSide,
      'hearLenghtRear': hearLenghtRear,
      'hearLenghtTop': hearLenghtTop,
      'pixelReference': pixelReference,
      'distanceReference': distanceReference,
      'date': date,
      'quantity': quantity,
      'note': note
    };
  }
}
