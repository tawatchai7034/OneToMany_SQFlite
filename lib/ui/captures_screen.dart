import 'dart:io';

import 'package:flutter/material.dart';

import 'package:one_to_many_sqf/models/list_items.dart';
import 'package:one_to_many_sqf/models/shopping_list.dart';
import 'package:one_to_many_sqf/ui/preview_screen.dart';

class CapturesScreen extends StatefulWidget {
  final List<File> imageFileList;
    final ShoppingList shoppingList;
  final ListItem items;
  const CapturesScreen({
    Key? key,
    required this.imageFileList,
    required this.shoppingList,
    required this.items,
  }) : super(key: key);

  @override
  State<CapturesScreen> createState() => _CapturesScreenState();
}

class _CapturesScreenState extends State<CapturesScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Captures',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                for (File imageFile in widget.imageFileList)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => PreviewScreen(
                              fileList: widget.imageFileList,
                              imageFile: imageFile,
                              shoppingList: widget.shoppingList,
                              items: widget.items
                            ),
                          ),
                        );
                      },
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
