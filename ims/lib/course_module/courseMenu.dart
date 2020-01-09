import 'package:flutter/material.dart';
import 'package:ims/course_module/addCourse.dart';
import 'package:ims/course_module/courseList.dart';
import 'package:ims/student_module/studentListView.dart';

class CourseMenu extends StatefulWidget {
  @override
  _CourseMenuState createState() => _CourseMenuState();
}

class _CourseMenuState extends State<CourseMenu> {
  bool mode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Module"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListView()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(200, 90, 150, 239),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        //color: Color.fromARGB(200, 90, 150, 239),
                        child: Center(
                          child: Text(
                            "COURSES",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCourse()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(162, 106, 99, 245),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        //color: Color.fromARGB(162, 106, 99, 245),
                        child: Center(
                          child: Text(
                            "ADD COURSE",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(151, 255, 66, 66),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        //color: Color.fromARGB(151, 255, 66, 66),
                        child: Center(
                          child: Text(
                            "___",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          height: 10,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150,
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 40,
                      ),
                      Container(
                        color: mode ? Colors.black : Colors.white12,
                        child: Center(
                          child: FloatingActionButton(
                            onPressed: () {},
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
