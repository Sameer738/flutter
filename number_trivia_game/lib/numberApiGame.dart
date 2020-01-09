import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NumberApiGame extends StatefulWidget {
  @override
  _NumberApiGameState createState() => _NumberApiGameState();
}

class _NumberApiGameState extends State<NumberApiGame> {
  TextEditingController numbercontroller = TextEditingController();
  String b;
  String value = "";
  String url = 'http://numbersapi.com/' + Random().nextInt(1000).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Numer Fact'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
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
                        return Text("Input A url to start");
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        return new Text("Active");
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return new Text(
                            '${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 50, right: 10, left: 10),
                                  child: Text(
                                    snapshot.data,
                                    style: TextStyle(fontSize: 20),
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
                padding: EdgeInsets.only(left: 60, right: 60, bottom: 50),
                child: TextField(
                  enabled: false,
                  controller: numbercontroller,
                  decoration: InputDecoration(
                      hintText: 'Enter Any Number',
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
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
                              numbercontroller.text =
                                  numbercontroller.text + "1";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "2";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "3";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "4";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "5";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "6";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "7";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "8";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                              numbercontroller.text =
                                  numbercontroller.text + "9";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 18,color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'R',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,fontSize: 23,color: Colors.red)),
                                TextSpan(
                                    text: 'andom Number',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              var r = Random().nextInt(999).toString();
                              numbercontroller.text = r;
                              url = 'http://numbersapi.com/' + r;
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
                              numbercontroller.text =
                                  numbercontroller.text + "0";
                              url = 'http://numbersapi.com/' +
                                  numbercontroller.text;
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
                            style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.w800),
                          ),
                          onPressed: () {
                            setState(() {
                              numbercontroller.text = '';
                              url = 'http://numbersapi.com/' +
                                  Random().nextInt(999).toString();
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
}
