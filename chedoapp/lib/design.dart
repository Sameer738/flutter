import 'package:flutter/material.dart';

class ClientView extends StatefulWidget {
  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
