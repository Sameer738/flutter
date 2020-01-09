import 'package:flutter/material.dart';

class RichTextDemo extends StatefulWidget {
  @override
  _RichTextDemoState createState() => _RichTextDemoState();
}

class _RichTextDemoState extends State<RichTextDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: 'bold', style: TextStyle(fontWeight: FontWeight.normal)),
          TextSpan(
              text: ' world!', style: TextStyle(fontWeight: FontWeight.w200)),
        ],
      ),
    )));
  }
}
