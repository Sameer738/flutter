import 'package:flutter/material.dart';

class TableDemo extends StatefulWidget {
  @override
  _TableDemoState createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Table(
        border: TableBorder.all(width: 2.0),
        children: [
          TableRow(children: [
            Container(
              color: Colors.blue,
              height: 50,
            ),
            Container(
              color: Colors.red,
              height: 50,
            )
          ])
        ],
      ),
    ));
  }
}
