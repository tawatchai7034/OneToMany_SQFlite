import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:one_to_many_sqf/models/list_items.dart';
import 'package:one_to_many_sqf/ui/list_item_dialog.dart';

class CardImage extends StatefulWidget {
  final String imagePath;
  final ListItem items;
  const CardImage({
    Key? key,
    required this.imagePath,
    required this.items,
  }) : super(key: key);

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  ListItemDialog dialog = new ListItemDialog();
  final angle = 90 * pi / 180;

  @override
  Widget build(BuildContext context) {
    final formatDay = DateFormat('dd/MM/yyyy hh:mm a');
    DateTime date = DateTime.parse(widget.items.date);
    var dateString = formatDay.format(date);

    return Card(
      color: Colors.white,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        title: Center(
          child: widget.imagePath != null
              ? Transform.rotate(
                  angle: angle,
                  child:
                      Image.file(File(widget.imagePath), fit: BoxFit.fitHeight))
              : IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 48,
                  color: Colors.grey,
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      dialog.buildAlert(context, widget.items, false, ''));
            },
            color: Colors.black,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
