import 'package:flutter/material.dart';

class BoxCat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoxCat();
  }

  String name;
  BoxCat(this.name);
}

class _BoxCat extends State<BoxCat> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Image.network(
            'https://png.pngtree.com/png-vector/20190130/ourmid/pngtree-animal-series-cute-kitten-serieslovelykittyblack-catpretty-png-image_603866.jpg'),
        Text(
          widget.name,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
