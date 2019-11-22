import 'package:chedoapp/data/course.dart' as prefix0;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  List<String> nameList = new List();
  String selected;

  getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('course').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((data) {
      final course = prefix0.Course.fromSnapshot(data);
      print(course.coursename);
      nameList.add(course.coursename);
    });
    setState(() {
      selected = nameList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(40),
        child: DropdownButton(
          hint: Text('Please choose Course'),
          value: selected,
          onChanged: (newValue) {
            setState(() {
              selected = newValue;
            });
          },
          items: nameList.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }
}
