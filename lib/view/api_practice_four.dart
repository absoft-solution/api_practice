import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/ProductsModel.dart';

class ApiPracticeFour extends StatefulWidget {
  const ApiPracticeFour({super.key});

  @override
  State<ApiPracticeFour> createState() => _ApiPracticeFourState();
}

class _ApiPracticeFourState extends State<ApiPracticeFour> {
  Future<ProductsModel> getProductApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/a699bc00-e38c-4414-a58e-9e767465006e'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Complex JSON Objects"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<ProductsModel>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                } else {
                  var product = snapshot.data!;
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data!.data![index].shop!.image
                                    .toString()),
                              ),
                              title: Text(snapshot.data!.data![index].shop!.name
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.data![index].shop!.shopemail
                                  .toString()),
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * .2,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .data![index]
                                                    .images![position]
                                                    .url
                                                    .toString()),
                                              )),
                                        ),
                                      );
                                    })),
                          ],
                        );
                      });
                }
              }),
        ));
  }
}
