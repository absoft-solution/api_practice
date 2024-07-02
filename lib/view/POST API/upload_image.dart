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
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    var length = await image!.length();
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://fakestoreapi.com/products"));
    var multipartFile = http.MultipartFile('image', stream, length);
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Uploaded");
    } else {
      setState(() {
        showSpinner = false;
      });
      print("Not uploaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 300,
                width: 300,
                color: Colors.blue,
                child: image == null
                    ? Center(
                        child: Text("Pick Image",
                            style: TextStyle(color: Colors.white)))
                    : Image.file(
                        File(image!.path).absolute,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Upload",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            if (showSpinner) SizedBox(height: 20), // Space before spinner
            if (showSpinner) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
