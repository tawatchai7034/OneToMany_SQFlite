import 'package:flutter/material.dart';
import 'package:one_to_many_sqf/models/catPro.dart';
import '../util/dbhelper.dart';
import '../models/shopping_list.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtGender = TextEditingController();
  final txtspecies = TextEditingController();

  Widget buildDialog(BuildContext context, CattlePro list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtspecies.text = list.species;
    }
    return AlertDialog(
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Cattle Name')),
            TextField(
                controller: txtGender,
                decoration: InputDecoration(hintText: 'Gender')),
            TextField(
              controller: txtspecies,
              // keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Species'),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                list.name = txtName.text;
                list.gender = txtGender.text;
                list.species = txtspecies.text;
                // int.parse(txtPriority.text);
                helper.insertCatPro(list).then((value) {
                  print("add data completed");
                });
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
