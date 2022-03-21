import 'dart:io';

import 'package:flutter/material.dart';

import 'package:one_to_many_sqf/models/list_items.dart';
import 'package:one_to_many_sqf/models/photo.dart';
import 'package:one_to_many_sqf/models/shopping_list.dart';
import 'package:one_to_many_sqf/models/utility.dart';
import 'package:one_to_many_sqf/ui/captures_screen.dart';
import 'package:one_to_many_sqf/util/helper.dart';

class PreviewScreen extends StatefulWidget {
  final File imageFile;
  final List<File> fileList;
  final ShoppingList shoppingList;
  final ListItem items;
  const PreviewScreen({
    Key? key,
    required this.imageFile,
    required this.fileList,
    required this.shoppingList,
    required this.items,
  }) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
   late DBHelper dbHelper;
  late List<Photo> images;

  @override
  void initState() {
    // TODO: implement initState
    dbHelper = DBHelper();
    images = [];
    refreshImages();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(title: Text("Preview Screen"), actions: [
        Row(
          children: [
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CapturesScreen(
                      imageFileList: widget.fileList,
                      shoppingList: widget.shoppingList,
                      items: widget.items
                    ),
                  ),
                );
              },
              icon: Icon(Icons.photo)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async{
                final file = widget.imageFile;
                String imgString = Utility.base64String(file.readAsBytesSync());
                Photo photo = Photo(
                    images.length, widget.shoppingList.id, widget.items.id, imgString);
                DBHelper dbhelper;
                await dbHelper.save(photo);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => CapturesScreen(
                //       imageFileList: widget.fileList,
                //       shoppingList: widget.shoppingList,
                //       items: widget.items
                //     ),
                //   ),
                // );
                print("save image success.");
              },
              icon: Icon(Icons.save_rounded)
            ),
          ),
          ],
        )
      ]),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(
          //           builder: (context) => CapturesScreen(
          //             imageFileList: widget.fileList,
          //           ),
          //         ),
          //       );
          //     },
          //     child: Text('Go to all captures'),
          //     style: TextButton.styleFrom(
          //       primary: Colors.black,
          //       backgroundColor: Colors.white,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Image.file(widget.imageFile),
          ),
        ],
      ),
    );
  }
}
