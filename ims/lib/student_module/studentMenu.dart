import 'package:flutter/material.dart';
import 'studentListView.dart';

import 'addmission.dart';

class StudentMenu extends StatefulWidget {
  @override
  _StudentMenuState createState() => _StudentMenuState();
}

class _StudentMenuState extends State<StudentMenu> {
  bool mode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Module"),
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
                                builder: (context) => StudentListView()));
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
                            "STUDENTS",
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
                                  builder: (context) => AddStudInfo()));
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
                            "ADMISSION",
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
