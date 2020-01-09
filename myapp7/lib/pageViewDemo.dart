import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp7/webViewDemo.dart';

class WebMainPage extends StatefulWidget {
  @override
  _WebMainPageState createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => WebViewDemo()));
        },
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
