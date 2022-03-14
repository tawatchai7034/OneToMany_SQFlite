import 'package:flutter/material.dart';
import '../util/dbhelper.dart';
import '../models/shopping_list.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtGender = TextEditingController();
  final txtSpecies = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, CattlePro list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtGender.text = list.gender;
      txtSpecies.text = list.species;
    }
    return AlertDialog(
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Shopping List Name')),
            TextField(
                controller: txtGender,
                decoration: InputDecoration(hintText: 'Gender')),
            TextField(
                controller: txtSpecies,
                decoration: InputDecoration(hintText: 'Species')),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                list.name = txtName.text;
                list.gender = txtGender.text;
                list.species = txtSpecies.text;
                helper.insertList(list);
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
