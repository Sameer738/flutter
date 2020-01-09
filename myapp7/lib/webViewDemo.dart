import 'package:flutter/material.dart';

class WebViewDemo extends StatefulWidget {
  @override
  _WebViewDemoState createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 57, 65),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 60, right: 60, top: 40),
                            child: Icon(
                              Icons.fingerprint,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 60, top: 40),
                            child: Text(DateTime.now().day.toString(),
                                style: TextStyle(color: Colors.white))),
                        Container(
                            transform:
                                Matrix4.translationValues(0.0, -0.5, 0.0),
                            margin: EdgeInsets.only(
                              left: 30,
                              top: 40,
                            ),
                            child: Text("--",
                                style: TextStyle(color: Colors.white))),
                        Container(
                            margin: EdgeInsets.only(
                              left: 30,
                              top: 40,
                            ),
                            child: Text(DateTime.now().month.toString(),
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child:
                              Text("+", style: TextStyle(color: Colors.white)),
                          margin: EdgeInsets.only(left: 60, right: 30, top: 40),
                        ),
                        Container(
                          child:
                              Text("+", style: TextStyle(color: Colors.white)),
                          margin: EdgeInsets.only(left: 30, top: 40),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Overview",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "______",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(left: 30, top: 40),
                        ),
                        Container(
                          child: Text("Specification",
                              style: TextStyle(color: Colors.white)),
                          margin: EdgeInsets.only(left: 30, top: 40),
                        ),
                        Container(
                          child: Text("Reservation",
                              style: TextStyle(color: Colors.white)),
                          margin: EdgeInsets.only(left: 30, top: 40),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 30),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "ME",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("NU",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    transform: Matrix4.translationValues(-160.0, 0.0, 0.0),
                    child: Text(
                      "R",
                      style: TextStyle(
                          fontSize: 500,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    transform: Matrix4.translationValues(-180.0, 0.0, 0.0),
                    child: Text(
                      "ev",
                      style: TextStyle(
                          fontSize: 500,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 200),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "/Bosted" + "\n" + "Rev",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            transform:
                                Matrix4.translationValues(0.0, -40.0, 0.0),
                            child: Text(
                              "RS 1700",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            transform:
                                Matrix4.translationValues(0.0, -100.0, 0.0),
                            child: Text(
                              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Reserve for 100 Rs",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    transform: Matrix4.translationValues(160.0, 0.0, 0.0),
                    child: Text(
                      "R",
                      style: TextStyle(
                          fontSize: 500,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(300.0, 50.0, 0.0),
            child: Image.network(
              'https://cdn-reichelt.de/bilder/web/xxl_ws/E910/XIAOMI_M365S_01.png',
              height: 600,
              width: 600,
            ),
          ),
        ],
      ),
    );
  }
}
