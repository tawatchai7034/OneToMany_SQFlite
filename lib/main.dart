// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:one_to_many_sqf/saveImage.dart';

import 'package:one_to_many_sqf/ui/camera_page.dart';
import 'package:one_to_many_sqf/ui/camera_screen.dart';

import 'models/list_items.dart';
import 'models/shopping_list.dart';
import 'ui/items_screen.dart';
import 'ui/shopping_list_dialog.dart';
import 'util/dbhelper.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ShList(),
    );
  }
}

class ShList extends StatefulWidget {
  const ShList({
    Key key,
  }) : super(key: key);
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
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen()
                          // TakePictureScreen(
                          //   camera: widget.camera,
                          //   onCallback: (){},
                          //   idPro: 0,
                          //   idTime: 0,
                          // ),
                          ),
                    );
                  },
                  icon: Icon(Icons.camera_alt)),
              SizedBox(height: 16),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SaveImage(idPro: 0, idTime: 0)));
                  },
                  icon: Icon(Icons.photo))
            ],
          )
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
                    // leading: CircleAvatar(
                    //   child: widget.imagePath != null
                    //       ? Image.file(File(widget.imagePath))
                    //       : Container(),
                    // ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CatTimeScreen(
                                shoppingList: shoppingList[index],
                                imagePath: null)),
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
