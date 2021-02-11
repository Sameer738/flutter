import 'package:flutter/material.dart';
import 'package:grocery/loginPage.dart';

main() {
  runApp(MyApp());
}

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
        title: 'Chedo_IMS',
        debugShowCheckedModeBanner: false,
        home: SignInG());
  }
}