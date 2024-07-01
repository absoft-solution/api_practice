import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile == null) {
      image = File(pickedFile!.path);
    } else {
      print("Not Selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {});
    var stream = new http.ByteStream(image!.openRead());
    var lenght = await image!.length();
    var request = new http.MultipartRequest(
        'POST', Uri.parse("https://fakestoreapi.com/products"));
    var multiport = new http.MultipartFile('image', stream, lenght);
    request.files.add(multiport);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {});
      showSpinner = false;
      print("Uploaded");
    } else {
      print("Not uploaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
                child: image == null
                    ? Text("Pick Image")
                    : Container(
                        child: Image.file(
                          height: 100,
                          width: 100,
                          File(image!.path).absolute,
                          fit: BoxFit.cover,
                        ),
                      )),
          ),
          GestureDetector(
            onTap: () {
              uploadImage();
            },
            child: Container(
              child: Text("Upload"),
            ),
          )
        ],
      ),
    );
  }
}
