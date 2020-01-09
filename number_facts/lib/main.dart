import 'package:flutter/material.dart';
import 'package:number_facts/numberApiGame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Fact',
      debugShowCheckedModeBanner: false,
      home: NumberApiGame(),
    );
  }
}
