import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/list_items.dart';
import '../util/dbhelper.dart';

class ListItemDialog {
  final txtName = TextEditingController();
  final txtPrice = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildAlert(BuildContext context, ListItem item, bool isNew) {
    print(item);
    DbHelper helper = DbHelper();
    helper.openDb();
    if (!isNew) {
      txtName.text = item.name;
      txtPrice.text = item.price.toString();
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping item' : 'Edit shopping item'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Item Name')),
            TextField(
                controller: txtPrice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Price')),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(hintText: 'Quantity'),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(hintText: 'Note'),
            ),
            RaisedButton(
                child: Text('Save Item'),
                onPressed: () {
                  item.name = txtName.text;
                  item.price = double.parse(txtPrice.text);
                  item.date = DateTime.now().toIso8601String();
                  item.quantity = txtQuantity.text;
                  item.note = txtNote.text;
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
