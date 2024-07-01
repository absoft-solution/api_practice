<<<<<<< HEAD
import 'package:api_practice/view/api_practice_four.dart';
=======
import 'package:api_practice/view/api_practice_one.dart';
import 'package:api_practice/view/api_practice_three.dart';
import 'package:api_practice/view/api_practice_two.dart';
>>>>>>> cb9d2a5eec66a9a6d4e4f16da8485ecf717eb2af
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const ApiPracticeFour(),
=======
      home: const ApiPracticeThree(),
>>>>>>> cb9d2a5eec66a9a6d4e4f16da8485ecf717eb2af
    );
  }
}
