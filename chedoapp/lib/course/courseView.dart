import 'package:cached_network_image/cached_network_image.dart';
import 'package:chedoapp/course/courseDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chedoapp/data/course.dart';

class ViewCourse extends StatefulWidget {
  @override
  _ViewCourseState createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(162, 106, 99, 245),
        title: Text(
          "Course",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('course')
          .orderBy('coursename')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      //padding: const EdgeInsets.only(top: 20.0),
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final course = Course.fromSnapshot(data);
    return Padding(
      key: ValueKey(course.coursename),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: InkWell(
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CourseDetail(data)));
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: CachedNetworkImageProvider(course.imageurl),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0),
                    bottomLeft: const Radius.circular(15.0),
                    bottomRight: const Radius.circular(15.0),
                  )),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 1, right: 2),
                alignment: AlignmentDirectional(0, 1),
                child: Row(
                  children: <Widget>[
                    Chip(
                      backgroundColor: Colors.pink,
                      label: Text(
                        course.coursename,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
