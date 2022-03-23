import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/pages/home_page.dart';
import 'package:bloc/bloc.dart';

import 'blocks/list_post_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ListPostCubit())
        ], child: HomePage(),
      ),
      routes: {
        HomePage.id:(context) =>HomePage(),
      },
    );
  }
}