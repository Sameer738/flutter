import 'package:flutter/material.dart';
import 'package:myapp/dashboard.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Dashboard(),
    );
  }
}
