import 'package:flutter/material.dart';
import 'package:shoppingsincuritiba/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping In Curitiba',
      theme: ThemeData(
        primaryColor: Color(0xff6200ee),
      ),
      home: MainPage(),
    );
  }
}
