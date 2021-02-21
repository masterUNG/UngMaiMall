import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungmaimall/utility/my_dialog.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  File file;
  String title, detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildImage(),
            buildTitle(),
            buildDetail(),
            buildSave(),
          ],
        ),
      ),
    );
  }

  Container buildSave() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 250,
      child: ElevatedButton.icon(
        onPressed: () {
          if (file == null) {
            normalDialog(
                context, "Non Choose Image", 'Please Click Camera or Gallery');
          } else if ((title?.isEmpty ?? true) || (detail?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else {
            uploadImageToServer();
          }
        },
        icon: Icon(Icons.save),
        label: Text('Save'),
      ),
    );
  }

  Future<Null> uploadImageToServer() async {
    String path = 'https://www.androidthai.in.th/mmm/saveFileUng.php';
    int i = Random().nextInt(100000);
    String nameFile = 'product$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);
      await Dio().post(path, data: formData).then((value) {
        String urlImage = 'https://www.androidthai.in.th/mmm/ung/$nameFile';
        insertProductToDatabase(urlImage);
      });
    } catch (e) {
      print('e== ${e.toString()}');
    }
  }

  Future<Null> insertProductToDatabase(String urlImage) async {
    String path =
        'https://www.androidthai.in.th/mmm/addProductUng.php?isAdd=true&title=$title&detail=$detail&urlimage=$urlImage';
    await Dio().get(path).then((value) => Navigator.pop(context));
  }

  Container buildTitle() {
    return Container(
      width: 250,
      child: TextFormField(
        onChanged: (value) => title = value.trim(),
        decoration: InputDecoration(
          labelText: 'Title :',
        ),
      ),
    );
  }

  Container buildDetail() {
    return Container(
      width: 250,
      child: TextFormField(
        onChanged: (value) => detail = value.trim(),
        decoration: InputDecoration(
          labelText: 'Detail :',
        ),
      ),
    );
  }

  Future<Null> chooseSource(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCamera(),
        Container(
          width: 250,
          height: 250,
          child: file == null
              ? Image(
                  image: AssetImage('images/image.png'),
                )
              : Image(image: FileImage(file)),
        ),
        buildGallery(),
      ],
    );
  }

  IconButton buildCamera() {
    return IconButton(
      icon: Icon(Icons.add_a_photo),
      onPressed: () => chooseSource(ImageSource.camera),
    );
  }

  IconButton buildGallery() {
    return IconButton(
      icon: Icon(Icons.add_photo_alternate),
      onPressed: () => chooseSource(ImageSource.gallery),
    );
  }
}
