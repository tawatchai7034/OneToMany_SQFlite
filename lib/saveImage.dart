import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:one_to_many_sqf/models/photo.dart';
import 'package:one_to_many_sqf/models/utility.dart';
import 'package:one_to_many_sqf/ui/camera_page.dart';
import 'package:one_to_many_sqf/ui/camera_screen.dart';
import 'package:one_to_many_sqf/util/helper.dart';

class SaveImage extends StatefulWidget {
  final int idPro;
  final int idTime;
  const SaveImage({Key? key, required this.idPro, required this.idTime})
      : super(key: key);

  @override
  State<SaveImage> createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  late Future<File> imageFile;
  late Image image;
  late DBHelper dbHelper;
  late List<Photo> images;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
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

  pickImageFromGallery() {
    _picker.pickImage(source: ImageSource.gallery).then((imgFile) {
      final file = File(imgFile!.path);
      String imgString = Utility.base64String(file.readAsBytesSync());
      Photo photo =
          Photo(images.length, widget.idPro, widget.idTime, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return InkWell(
              onTap: () {
                print("photo id: ${photo.id}");
                dbHelper.delete(photo);
                refreshImages();
              },
              child: Utility.imageFromBase64String(photo.photo_name));
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Flutter Save Image"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
    );
  }
}
