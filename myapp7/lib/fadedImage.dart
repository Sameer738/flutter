import 'package:flutter/material.dart';

class FadedImage extends StatefulWidget {
  @override
  _FadedImageState createState() => _FadedImageState();
}

class _FadedImageState extends State<FadedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Grey Example'),
      ),
      body: Container(
        child: ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.grey, BlendMode.saturation),
          child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQMueyisr8wYKRW8wS4G19HmwvGg_T_j5U3LgBfSPmdUc8aq-AX'),
        ),
      ),
    );
  }
}
