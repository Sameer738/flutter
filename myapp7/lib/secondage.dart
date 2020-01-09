import 'package:flutter/material.dart';
import 'package:myapp7/heroanimation.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HeroAnimation()));
        },
        child: Container(
          child: Hero(
            tag: 'animation',
            child: Icon(
              Icons.play_for_work,
              size: 300,
            ),
          ),
        ),
      ),
    );
  }
}
