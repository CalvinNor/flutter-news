import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homescreen.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter News',
        theme: ThemeData(primaryColor: Colors.white),
        home: HomeScreen());
  }
}
