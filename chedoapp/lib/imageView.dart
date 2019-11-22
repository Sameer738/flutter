import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;
  ImageView(this.imageUrl);
  @override
  _ImageView createState() => _ImageView();
}

class _ImageView extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.imageUrl),
        ),
      ),
    );
  }
}
