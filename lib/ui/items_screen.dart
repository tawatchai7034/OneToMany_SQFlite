import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:one_to_many_sqf/models/photo.dart';

import 'package:one_to_many_sqf/ui/camera_page.dart';
import 'package:one_to_many_sqf/ui/imageCard.dart';
import 'package:one_to_many_sqf/util/helper.dart';

import '../models/list_items.dart';
import '../models/shopping_list.dart';
import '../util/dbhelper.dart';
import 'list_item_dialog.dart';

// class ItemsScreen extends StatefulWidget {
//   final ShoppingList shoppingList;
//   final CameraDescription camera;
//   final String imagePath;

//   ItemsScreen(this.shoppingList, this.camera, this.imagePath);

//   @override
//   _ItemsScreenState createState() =>
//       _ItemsScreenState(this.shoppingList, this.camera, this.imagePath);
// }

// class _ItemsScreenState extends State<ItemsScreen> {
//   final ShoppingList shoppingList;
//   final CameraDescription camera;
//   final String imagePath;

//   _ItemsScreenState(this.shoppingList, this.camera, this.imagePath);

//   DbHelper helper;
//   List<ListItem> items;
//   ListItemDialog dialog;
//   @override
//   void initState() {
//     dialog = ListItemDialog();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     helper = DbHelper();
//     showData(this.shoppingList.id);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(shoppingList.name),
//       ),
//       body: ListView.builder(
//           itemCount: (items != null) ? items.length : 0,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CardImage(
//                 imagePath: widget.imagePath,
//                 items: items[index],
//                 onCallback: () async{
//                   await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TakePictureScreen(
//                           camera: widget.camera,
//                           onCallback: (){},
//                           idPro: shoppingList.id,
//                           idTime: items[index].id,
//                         ),
//                       ),
//                     );
//                 },
//               ),
//             );
//             // Dismissible(
//             //   key: Key(items[index].date),
//             //   onDismissed: (direction) {
//             //     String strName = items[index].date;
//             //     helper.deleteItem(items[index]);
//             //     setState(() {
//             //       items.removeAt(index);
//             //     });
//             //     Scaffold.of(context).showSnackBar(
//             //         SnackBar(content: Text("Item $strName deleted")));
//             //   },
//             //   child:
//             //   ListTile(
//             //     title: Text(items[index].date),
//             //     // subtitle: Text(
//             //     //     'Quantity: ${items[index].quantity} - Note:  ${items[index].note}'),
//             //     leading: CircleAvatar(
//             //       child: widget.imagePath != null
//             //           ? Image.file(File(widget.imagePath))
//             //           : IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo),iconSize: 24,),
//             //     ),
//             //     onTap: () {},
//             //     trailing: IconButton(
//             //       icon: Icon(Icons.edit),
//             //       onPressed: () {
//             //         showDialog(
//             //             context: context,
//             //             builder: (BuildContext context) => dialog.buildAlert(
//             //                 context, items[index], false, ''));
//             //       },
//             //     ),
//             //   ),
//             // );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) => dialog.buildAlert(
//                 context,
//                 ListItem(0, this.shoppingList.id, 0, 0, 0, 0, 0, 0, 0, '', '',
//                     '', DateTime.now().toIso8601String(), ''),
//                 true,
//                 widget.imagePath),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.pink,
//       ),
//     );
//   }

//   Future showData(int idList) async {
//     await helper.openDb();
//     items = await helper.getItems(idList);
//     setState(() {
//       items = items;
//     });
//   }
// }

class CatTimeScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  final CameraDescription camera;
  final String imagePath;
  const CatTimeScreen({
    Key? key,
    required this.shoppingList,
    required this.camera,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<CatTimeScreen> createState() => _CatTimeScreenState();
}

class _CatTimeScreenState extends State<CatTimeScreen> {
  late final CameraDescription camera;
  late final String imagePath;
  DbHelper helper = DbHelper();
  List<ListItem>? items;
  late ListItemDialog dialog;
  late DBHelperImage dbHelper;
  late List<Photo> images;

  @override
  void initState() {
    dialog = ListItemDialog();
    super.initState();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(widget.shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
      ),
      body: ListView.builder(
          itemCount: (items != null) ? items!.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardImage(
                images: images[0],
                items: items![index],
                onCallback: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakePictureScreen(
                        camera: widget.camera,
                        onCallback: () {},
                        idPro: widget.shoppingList.id,
                        idTime: items![index].id,
                      ),
                    ),
                  );
                },
              ),
            );
            // Dismissible(
            //   key: Key(items[index].date),
            //   onDismissed: (direction) {
            //     String strName = items[index].date;
            //     helper.deleteItem(items[index]);
            //     setState(() {
            //       items.removeAt(index);
            //     });
            //     Scaffold.of(context).showSnackBar(
            //         SnackBar(content: Text("Item $strName deleted")));
            //   },
            //   child:
            //   ListTile(
            //     title: Text(items[index].date),
            //     // subtitle: Text(
            //     //     'Quantity: ${items[index].quantity} - Note:  ${items[index].note}'),
            //     leading: CircleAvatar(
            //       child: widget.imagePath != null
            //           ? Image.file(File(widget.imagePath))
            //           : IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo),iconSize: 24,),
            //     ),
            //     onTap: () {},
            //     trailing: IconButton(
            //       icon: Icon(Icons.edit),
            //       onPressed: () {
            //         showDialog(
            //             context: context,
            //             builder: (BuildContext context) => dialog.buildAlert(
            //                 context, items[index], false, ''));
            //       },
            //     ),
            //   ),
            // );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => dialog.buildAlert(
                context,
                ListItem(0, widget.shoppingList.id, 0, 0, 0, 0, 0, 0, 0, '', '',
                    '', DateTime.now().toIso8601String(), ''),
                true,
                widget.imagePath),
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
