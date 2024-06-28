import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/PostModel.dart';


class ApiPracticeOne extends StatefulWidget {


  const ApiPracticeOne({super.key});

  @override
  State<ApiPracticeOne> createState() => _ApiPracticeOneState();
}

class _ApiPracticeOneState extends State<ApiPracticeOne> {
  List<PostModel> postList=[];

  String baseURL="https://jsonplaceholder.typicode.com/users";
  Future<List<PostModel>> getPostApi() async{
    final response=await http.get(Uri.parse(baseURL));
    var data=jsonDecode(response.body.toString());

    if (response.statusCode==200)
    {
      for (Map i in data){
        postList.add(PostModel.fromJson(i));

      }
      return postList;
    }
    else{
      return postList;
    }
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("API Practice"),
        centerTitle: true,
      ),
body: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      Expanded(
        child: FutureBuilder(future: getPostApi(), builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context,index){
              return Card(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID:  '+ postList[index].id.toString()),
                    Text('Name:  '+ postList[index].name.toString()),
                    Text('User Name:  '+ postList[index].username.toString()),
                    Text('Email:  '+ postList[index].email.toString()),
                    Text('Address:  '+ postList[index].address.toString()),
                    Text('Phone:  '+ postList[index].phone.toString()),
                    Text('Company:  '+ postList[index].company.toString()),
                  ],
                ),
              );
            });
          }
        }),
      )

    ],
  ),
),
    );
  }
}
