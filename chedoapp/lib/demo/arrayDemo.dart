import 'package:chedoapp/data/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArrayDemo extends StatefulWidget {
  @override
  _ArrayDemoState createState() => _ArrayDemoState();
}

class _ArrayDemoState extends State<ArrayDemo> {
  TextEditingController nameController = new TextEditingController();
  Record record;
  String course;

  void addCourse() async {
    List temp = List();
    setState(() {
      temp.add(nameController.text);
    });
    print(temp.length);

    Firestore.instance
        .collection('newStudent')
        .document('sNvlSOc9tRlbDyvkuHUa')
        .updateData({
      'courseName': temp,
    });

    setState(() {
      course = '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  loadCourses() async {
    DocumentReference docRef = Firestore.instance
        .collection('newStudent')
        .document(record.reference.toString());

    DocumentSnapshot doc = await docRef.get();

    course = doc.data['courseName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  course=nameController.text;
                  addCourse();
                  nameController.text = '';
                });
              },
              child: Text('Add Student'),
            ),
            Container(
              child: Text(course),
            )
          ],
        ),
      ),
    );
  }
}
