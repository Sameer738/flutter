import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';

class ArrayDemo extends StatefulWidget {
  @override
  _ArrayDemoState createState() => _ArrayDemoState();
}

class _ArrayDemoState extends State<ArrayDemo> {
   Record record;
  String course = 'Akdk';

  void addCourse() async {
    List temp = List();
    setState(() {
      temp.add(course);
    });
    print(temp.length);

    Firestore.instance
        .collection('bandnames')
        .document(record.reference.documentID)
        .updateData({
      'votes': temp,
    });

    setState(() {
      course = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: RaisedButton(
          onPressed: () {},
          child: Text('Add Student'),
        ),
      ),
    );
  }
}
