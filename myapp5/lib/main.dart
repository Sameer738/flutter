import 'package:myapp5/arrayDemo.dart';
import 'package:myapp5/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:myapp5/loginPage.dart';
import 'package:myapp5/ocrDemo.dart';

import 'package:myapp5/signInWithEmail.dart';
import 'package:myapp5/signInWithPhoneNo.dart';

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
      debugShowCheckedModeBanner: false,
      home: SignInWithPhoneNo(),
    );
  }
}
