import 'package:flutter/material.dart';

class AnimatedIconsDemo extends StatefulWidget {
  @override
  _AnimatedIconsDemoState createState() => _AnimatedIconsDemoState();
}

class _AnimatedIconsDemoState extends State<AnimatedIconsDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isplaying = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Animated Icon "),
      ),
      body: Container(
        child: Center(
          child: IconButton(
            iconSize: 100,
            icon: AnimatedIcon(
              icon: AnimatedIcons.ellipsis_search,
              progress: _animationController,
            ),
            onPressed: () => _handleOnPressed(),
          ),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    setState(() {
      isplaying = !isplaying;
      isplaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}
