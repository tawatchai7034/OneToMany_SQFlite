// @dart=2.9
import 'package:flutter/material.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';
import '../util/dbhelper.dart';
import 'list_item_dialog.dart';

class ItemsScreen extends StatefulWidget {
  final CattlePro shoppingList;

  ItemsScreen(this.shoppingList);

  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final CattlePro shoppingList;

  _ItemsScreenState(this.shoppingList);

  DbHelper helper;
  List<CattleTime> items;
  ListItemDialog dialog;
  @override
  void initState() {
    dialog = ListItemDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(this.shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
          itemCount: (items != null) ? items.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(items[index].date),
              onDismissed: (direction) {
                String strName = items[index].date;
                helper.deleteItem(items[index]);
                setState(() {
                  items.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Item $strName deleted")));
              },
              child: ListTile(
                title: Text(items[index].date),
                subtitle: Text(
                    'Body Lenght: ${items[index].bodyLenght}\nHeart Girth: ${items[index].heartGirth}\nHear Lenght Side: ${items[index].hearLenghtSide}\nHear Lenght Rear: ${items[index].hearLenghtRear}\nHear Lenght Top: ${items[index].hearLenghtTop}\nPixel Reference: ${items[index].pixelReference}\nDistance Reference: ${items[index].distanceReference}'),
                onTap: () {},
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            dialog.buildAlert(context, items[index], false));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => dialog.buildAlert(
                context,
                CattleTime(0, this.shoppingList.id, 0, 0, 0, 0, 0, 0, 0,
                    DateTime.now().toIso8601String()),
                true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future showData(int idList) async {
    await helper.openDb();
    items = await helper.getItems(idList);
    setState(() {
      items = items;
    });
  }
}
