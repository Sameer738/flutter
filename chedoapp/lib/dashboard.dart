import 'package:cached_network_image/cached_network_image.dart';
import 'package:chedoapp/course/addCourse.dart';
import 'package:chedoapp/design.dart';
import 'package:chedoapp/student/addmissionNew.dart';
import 'package:chedoapp/student/studentListView.dart';
import 'package:chedoapp/course/courseView.dart';
import 'package:chedoapp/teacher/addTeacherNew.dart';
import 'package:chedoapp/teacher/teacherListView.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chedoapp/login.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  bool mode = false;

  FirebaseUser user;
  final cFirebaseAuth = FirebaseAuth.instance;
  final cGoogleSignIn = GoogleSignIn();
  String photourl =
      'http://www.stleos.uq.edu.au/wp-content/uploads/2016/08/image-placeholder.png';
  String enqFormUrl =
      "https://docs.google.com/forms/d/e/1FAIpQLSez0X0Ja72aPveJVYzUiVWAb6YGwAhMJ8LrfXu_9Q3U-dhxhw/viewform";
  @override
  void initState() {
    super.initState();
    cFirebaseAuth.currentUser().then(
          (user) => setState(() {
            this.user = user;
            photourl = user.photoUrl;
          }),
        );
        
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: menuDrawer(context),
      backgroundColor: mode ? Colors.black87 : Colors.grey[300],
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: mode ? Colors.black87 : Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 20,
                        top: 35,
                        child: Container(
                            width: 90,
                            height: 90,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  CachedNetworkImageProvider(photourl),
                            ))),
                    Positioned(
                        right: 13,
                        top: 25,
                        child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                            child: dropMenu()))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
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
                                builder: (context) => NewAddmission()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(200, 90, 150, 239),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "ADMISSION",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentListView()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(210, 25, 25, 112),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "STUDENTS",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
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
                                  builder: (context) => TeacherListView()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(162, 106, 99, 245),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "TEACHERS",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCourse()));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(151, 255, 66, 66),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "COURSES",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
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
                          color: mode ? Colors.black87 : Colors.white,
                        ),
                      ),
                      Container(
                        color: mode ? Colors.black87 : Colors.white,
                        height: 150,
                      ),
                      Container(
                        color: mode ? Colors.black87 : Colors.grey[300],
                        height: 40,
                      ),
                      Container(
                        child: Center(
                          child: FloatingActionButton.extended(
                            //icon: Icon(Icons.work),
                            label: Text(
                              "Chedo Tech",
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              var media = MediaQuery.of(context);
                              print(media.size.width);
                              print(media.size.height);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget dropMenu() {
    return Container(
      margin: EdgeInsets.only(top: 45, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 4),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }

  Widget menuDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: mode ? Colors.black87 : Colors.white10,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20, left: 35, right: 35),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black12,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(photourl),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 1, left: 20, right: 20),
              child: ListTile(
                title: Text(
                  "Night Mode",
                  style: TextStyle(
                      fontSize: 18,
                      color: mode ? Colors.white30 : Colors.black38),
                ),
                trailing: Switch(
                  value: mode,
                  onChanged: (bool b) {
                    setState(() {
                      mode = !mode;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(200, 90, 150, 239),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(220, 25, 25, 112),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.face,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Student",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentListView()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(212, 106, 99, 245),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Teacher",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTeacherNew()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(221, 255, 66, 66),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Course",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewCourse()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(160, 25, 25, 112),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.event_note,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Enquiries",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCourse()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(210, 90, 150, 239),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Receipt",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewDesign()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTeacherNew()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    "Setting",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: (){
                    cGoogleSignIn.disconnect();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  // _launchURL() async {
  //   const url =
  //       'https://docs.google.com/spreadsheets/d/1Nhc9AAdfBI0cMqBOJ367w_L6_hsH0OCBvfXMSjrzJcE/edit#gid=79772504';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
