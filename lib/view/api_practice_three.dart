import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/UserModel.dart';

class ApiPracticeThree extends StatefulWidget {
  const ApiPracticeThree({super.key});

  @override
  State<ApiPracticeThree> createState() => _ApiPracticeThreeState();
}

List<UserModel> userList = [];

Future<List<UserModel>> getUserApi() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      userList.add(UserModel.fromJson(i));
    }
    return userList;
  } else {
    return userList;
  }
}

class _ApiPracticeThreeState extends State<ApiPracticeThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Nested JSON Objects"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 20,
                              margin: EdgeInsets.all(10),
                              color: Color(0xff78B1CCFF),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('User ID: ${userList[index].id}'),
                                  Text(
                                      'User Name: ${userList[index].username}'),
                                  Text(
                                      'City: ${userList[index].address!.city}'),
                                  Text(
                                      'Street: ${userList[index].address!.street}'),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
