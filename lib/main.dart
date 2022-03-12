// @dart=2.9
import 'package:flutter/material.dart';
import 'package:one_to_many_sqf/models/catPro.dart';
import 'util/dbhelper.dart';
import 'models/list_items.dart';
import 'models/shopping_list.dart';
import 'ui/items_screen.dart';
import 'ui/shopping_list_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ShoppingListDialog dialog = ShoppingListDialog();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shoppping List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShList());
  }
}

class ShList extends StatefulWidget {
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
    // showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: Column(children: []),
      // ListView.builder(
      //     itemCount: (shoppingList != null) ? shoppingList.length : 0,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Dismissible(
      //           key: Key(shoppingList[index].name),
      //           onDismissed: (direction) {
      //             String strName = shoppingList[index].name;
      //             helper.deleteList(shoppingList[index]);
      //             setState(() {
      //               shoppingList.removeAt(index);
      //             });
      //             Scaffold.of(context).showSnackBar(
      //                 SnackBar(content: Text("List $strName deleted")));
      //           },
      //           child: ListTile(
      //               title: Text(shoppingList[index].name),
      //               leading: CircleAvatar(
      //                 child: Text(shoppingList[index].priority.toString()),
      //               ),
      //               onTap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) =>
      //                           ItemsScreen(shoppingList[index])),
      //                 );
      //               },
      //               trailing: IconButton(
      //                 icon: Icon(Icons.edit),
      //                 onPressed: () {
      //                   showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) =>
      //                           dialog.buildDialog(
      //                               context, shoppingList[index], false));
      //                 },
      //               )));
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // helper
          //     .insertCatPro(CattlePro(
          //         name: 'calttle01', gender: 'male', species: 'barhman'))
          //     .then((value) {
          //   print("add data completed");
          // }).onError((error, stackTrace) {
          //   print("Error: " + error.toString());
          // });
          
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, CattlePro(name:"",gender:'',species:''), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  // Future showData() async {
  //   await helper.openDb();
  //   shoppingList = await helper.getLists();
  //   setState(() {
  //     shoppingList = shoppingList;
  //   });
  // }
}
