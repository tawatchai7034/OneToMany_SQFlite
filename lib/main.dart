// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:one_to_many_sqf/ui/camera_page.dart';


import 'models/list_items.dart';
import 'models/shopping_list.dart';
import 'ui/items_screen.dart';
import 'ui/shopping_list_dialog.dart';
import 'util/dbhelper.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home:
          // SaveNetImage(),
          ShList(
        camera: firstCamera,
      ),
    ),
  );
}

class ShList extends StatefulWidget {
  final CameraDescription camera;
  final String imagePath;
  const ShList({Key key, this.camera, this.imagePath}) : super(key: key);
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  List<ShoppingList> shoppingList;
  DbHelper helper = DbHelper();
  ShoppingListDialog dialog;

  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                      camera: widget.camera,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.camera_alt))
        ],
      ),
      body: ListView.builder(
          itemCount: (shoppingList != null) ? shoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(shoppingList[index].name),
                onDismissed: (direction) {
                  String strName = shoppingList[index].name;
                  helper.deleteList(shoppingList[index]);
                  setState(() {
                    shoppingList.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("List $strName deleted")));
                },
                child: ListTile(
                    title: Text(shoppingList[index].name),
                    subtitle: Text(
                        "Gender: ${shoppingList[index].gender}\nSpecies: ${shoppingList[index].species}"),
                    leading: CircleAvatar(
                      child: widget.imagePath != null
                          ? Image.file(File(widget.imagePath))
                          : Container(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemsScreen(shoppingList[index],widget.camera,widget.imagePath)),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialog.buildDialog(
                                    context, shoppingList[index], false));
                      },
                    )));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, ShoppingList(0, '', '', ''), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}
