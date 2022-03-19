import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_practice/pages/detail_page.dart';
import 'package:provider_practice/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id:(context) =>HomePage(),
      },
      getPages: [
        GetPage(name: '/home_page', page: () => HomePage()),
        GetPage(name: '/detail_page', page: () => DetailPage())
      ],
    );
  }
}