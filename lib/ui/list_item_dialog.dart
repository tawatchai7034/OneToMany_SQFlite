import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/list_items.dart';
import '../util/dbhelper.dart';

class ListItemDialog {
  final txtBodyLenght = TextEditingController();
  final txtHeartGirth = TextEditingController();
  final txtHearLenghtSide = TextEditingController();
  final txtHearLenghtRear = TextEditingController();
  final txtHearLenghtTop = TextEditingController();
  final txtPixelReference = TextEditingController();
  final txtDistanceReference = TextEditingController();

  Widget buildAlert(BuildContext context, CattleTime item, bool isNew) {
    print(item);
    DbHelper helper = DbHelper();
    helper.openDb();
    if (!isNew) {
      txtBodyLenght.text = item.bodyLenght.toString();
      txtHeartGirth.text = item.heartGirth.toString();
      txtHearLenghtSide.text = item.hearLenghtSide.toString();
      txtHearLenghtRear.text = item.hearLenghtRear.toString();
      txtHearLenghtTop.text = item.hearLenghtTop.toString();
      txtPixelReference.text = item.pixelReference.toString();
      txtDistanceReference.text = item.distanceReference.toString();
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping item' : 'Edit shopping item'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
                controller: txtBodyLenght,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Body Lenght')),
            TextField(
                controller: txtHeartGirth,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Heart Girth')),
            TextField(
                controller: txtHearLenghtSide,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Hear Lenght Side')),
            TextField(
                controller: txtHearLenghtRear,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Lenght Rear')),
            TextField(
                controller: txtHearLenghtTop,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Hear Lenght Top')),
            TextField(
                controller: txtPixelReference,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Pixel Reference')),
            TextField(
                controller: txtDistanceReference,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Distance Reference')),
            RaisedButton(
                child: Text('Save Item'),
                onPressed: () {
                  item.bodyLenght = double.parse(txtBodyLenght.text);
                  item.heartGirth = double.parse(txtHeartGirth.text);
                  item.hearLenghtSide = double.parse(txtHearLenghtSide.text);
                  item.hearLenghtRear = double.parse(txtHearLenghtRear.text);
                  item.hearLenghtTop = double.parse(txtHearLenghtTop.text);
                  item.pixelReference = double.parse(txtPixelReference.text);
                  item.distanceReference =
                      double.parse(txtDistanceReference.text);
                  item.date = DateTime.now().toIso8601String();

                  helper.insertItem(item);
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)))
          ],
        ),
      ),
    );
  }
}
