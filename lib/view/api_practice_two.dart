import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiPracticeTwo extends StatefulWidget {
  const ApiPracticeTwo({super.key});

  @override
  State<ApiPracticeTwo> createState() => _ApiPracticeTwoState();
}

class _ApiPracticeTwoState extends State<ApiPracticeTwo> {
  List<Photo> photoList = [];

  Future<List<Photo>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    photoList.clear();
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photo photo = Photo(title: i['title'], id: i['id'], url: i['url']);
        photoList.add(photo);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Custom API Model"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(photoList[index].url),
                          ),
                          title: Text(
                            'Notes ID: ${photoList[index].id}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(photoList[index].title.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photo {
  String title, url;
  int id;

  Photo({required this.title, required this.id, required this.url});
}
