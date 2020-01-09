import 'dart:math';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NumberApiGame extends StatefulWidget {
  @override
  _NumberApiGameState createState() => _NumberApiGameState();
}

class _NumberApiGameState extends State<NumberApiGame>
    with TickerProviderStateMixin {
  TextEditingController numbercontroller = TextEditingController();
  String numberPressed;
  String b;
  String hText = 'Enter Any Number';
  String value = "";
  String select;
  String url = 'http://numbersapi.com/' + Random().nextInt(1000).toString();

  @override
  void initState() {
    super.initState();
    select = 'Trivia';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Interesting Fact About Number'),
          //centerTitle: true,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 28,
                    color: Colors.white,
                  ),
                  tooltip: 'Random Number',
                ),
                onTap: () {
                  setState(() {
                    String rn = Random().nextInt(1000).toString();
                    url = 'http://numbersapi.com/' + rn;
                    numbercontroller.text = rn;
                  });
                },
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextField(
                  style: TextStyle(fontSize: 22),
                  enabled: false,
                  controller: numbercontroller,
                  decoration: InputDecoration(
                      hintText: hText,
                      hintStyle: TextStyle(color: Colors.red),
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                  future: url != null
                      ? http.get(url).then((response) => response.body)
                      : null,
                  builder:
                      (BuildContext contex, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("Could not connect to INTERNET !!!");
                      case ConnectionState.waiting:
                        return new Center(
                          child: const SpinKitFadingGrid(
                            color: Colors.black,
                          ),
                        );
                      case ConnectionState.active:
                        return new Text("Active");
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(
                            child: new Text(
                              ' Please Connect to Network',
                              style: TextStyle(color: Colors.red, fontSize: 19),
                            ),
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(18),
                                  child: Text(
                                    snapshot.data,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ],
                          );
                        }
                    }
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.greenAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          'Search by :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RadioButtonGroup(
                        orientation: GroupedButtonsOrientation.HORIZONTAL,
                        labels: <String>[
                          "Trivia",
                          "Math",
                          "Date",
                          "Year",
                        ],
                        picked: select,
                        labelStyle: TextStyle(
                          fontSize: 17,
                        ),
                        onSelected: (String selected) {
                          setState(() {
                            if (selected == 'Trivia') {
                              select = selected;
                              numbercontroller.text = '';
                              hText = 'Enter Any Number ';
                            } else if (selected == 'Math') {
                              select = selected;
                              numbercontroller.text = '';
                              hText = 'Enter Any Number ';
                            } else if (selected == 'Date') {
                              select = selected;
                              numbercontroller.text = '';
                              hText = "Enter Date :  eg : '05/28' ";
                            } else if (selected == 'Year') {
                              select = selected;
                              numbercontroller.text = '';
                              hText = "Enter Year :  eg : '2019' ";
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "1",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "1";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "2",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "2";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "3",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "3";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "4",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "4";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "5",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "5";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "6",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "6";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "7",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "7";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "8",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "8";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "9",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "9";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "/",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "/";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "0",
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              numberPressed = "0";
                              _clickedButton();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          child: Text(
                            "AC",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                                fontWeight: FontWeight.w800),
                          ),
                          onPressed: () {
                            setState(() {
                              numbercontroller.text = '';
                              url = 'http://numbersapi.com/0';
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _clickedButton() {
    numbercontroller.text = numbercontroller.text + numberPressed;
    if (select == 'Trivia') {
      url = 'http://numbersapi.com/' + numbercontroller.text;
    } else if (select == 'Math') {
      url = 'http://numbersapi.com/' + numbercontroller.text + '/math';
    } else if (select == 'Date') {
      url = 'http://numbersapi.com/' + numbercontroller.text + '/date';
    } else if (select == 'Year') {
      url = 'http://numbersapi.com/' + numbercontroller.text + '/year';
    } else {
      url = 'http://numbersapi.com/' + numbercontroller.text;
    }
  }
}
