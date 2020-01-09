import 'package:flutter/material.dart';
import 'package:myapp7/secondage.dart';

class HeroAnimation extends StatefulWidget {
  @override
  _HeroAnimationState createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: Center(
          child: Container(
            child: Hero(
              tag: 'animation',
              child: Icon(
                Icons.play_circle_outline,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
