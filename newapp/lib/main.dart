import 'package:flutter/material.dart';
import 'package:newapp/design.dart';
import 'package:newapp/qrCodeGenerator.dart';

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
      home: ClientView(),
    );
  }
}
