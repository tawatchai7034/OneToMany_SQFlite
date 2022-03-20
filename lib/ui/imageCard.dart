import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:one_to_many_sqf/models/list_items.dart';
import 'package:one_to_many_sqf/models/photo.dart';
import 'package:one_to_many_sqf/models/utility.dart';
import 'package:one_to_many_sqf/ui/list_item_dialog.dart';

class CardImage extends StatefulWidget {
  final Photo images;
  final ListItem items;
  final VoidCallback onCallback;
  const CardImage({
    Key? key,
    required this.images,
    required this.items,
    required this.onCallback,
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
          child: widget.images != null
              ? Transform.rotate(
                  angle: angle,
                  child:
                      Utility.imageFromBase64String(widget.images.photo_name))
              : IconButton(
                  onPressed: () {
                    widget.onCallback();
                  },
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 48,
                  color: Colors.grey,
                ),
        ),
        subtitle: ListTile(
          title: Text("Date: ${dateString}\nImage pro id: ${widget.images.idPro}\nImage time id: ${widget.images.idTime}",
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
