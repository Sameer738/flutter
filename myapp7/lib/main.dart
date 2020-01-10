import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:myapp7/animatedSwitcher.dart';
import 'package:myapp7/connectionDemo.dart';
import 'package:myapp7/fetchApiToJson.dart';
import 'package:myapp7/futureBuilder.dart';
import 'package:myapp7/googleFontsDemo.dart';
import 'package:myapp7/numberApi.dart';
import 'package:myapp7/richTextDemo.dart';
import 'package:myapp7/wrapDemo.dart';

void main() {
  timeDilation=1.0;
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
      debugShowCheckedModeBanner: false,
      home: RichTextDemo(),
    );
  }
}
