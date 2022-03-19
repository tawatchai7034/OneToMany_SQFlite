import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:one_to_many_sqf/models/list_items.dart';
import 'package:one_to_many_sqf/ui/list_item_dialog.dart';

class CartImage extends StatefulWidget {
  final String imagePath;
  final ListItem items;
  const CartImage({
    Key? key,
    required this.imagePath,
    required this.items,
  }) : super(key: key);

  @override
  State<CartImage> createState() => _CartImageState();
}

class _CartImageState extends State<CartImage> {
  late ListItemDialog dialog;
  final angle = 90 * pi / 180;

  @override
  Widget build(BuildContext context) {
    final formatDay = DateFormat('dd-MM-yyyy hh:mm a');
    DateTime date = DateTime.parse(widget.items.date);
    var dateString = formatDay.format(date);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.white,
            width: 4.0,
            style: BorderStyle.solid), //Border.all
        /*** The BorderRadius widget  is here ***/
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ), //BorderRadius.all
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: ListTile(
        title: Center(
          child: Container(
            height: 156,
            width: 328,
            child: widget.imagePath != null
                ? Transform.rotate(
                    angle: angle,
                    child:
                        Image.file(File(widget.imagePath), fit: BoxFit.contain))
                : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_a_photo),
                    iconSize: 48,
                    color: Colors.grey,
                  ),
          ),
        ),
        subtitle: ListTile(
          title: Text(dateString,
              style: TextStyle(
                color: Colors.black,
              )),
          onTap: () {},
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // showDialog(
              //           context: context,
              //           builder: (BuildContext context) => dialog.buildAlert(
              //               context, items[index], false, ''));
            },
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
