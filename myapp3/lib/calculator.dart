import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String str = 'Hello World !!';
  String val = "0";
  int a = 0;
  int b = 0;
  String op = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
              child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  val.toString(),
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "AC",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = "";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                              child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Icon(Icons.backspace),
                              onPressed: () {
                                setState(() {
                                  String str = val.toString();
                                  str = str.substring(0, (str.length - 1));
                                  val = str;
                                });
                              },
                            ),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                              child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "%",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  a = int.parse(val);
                                  val = "";
                                  op = "%";
                                });
                              },
                            ),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "/",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  a = int.parse(val);
                                  val = "";
                                  op = "/";
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "7",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "7";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "8",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "8";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "9",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "9";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "x",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  a = int.parse(val);
                                  val = "";
                                  op = "x";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "4",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "4";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "5",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "5";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "6",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "6";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "-",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  a = int.parse(val);
                                  val = "";
                                  op = "-";
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "1";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "2",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "2";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "3",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "3";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "+",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  a = int.parse(val) + a;
                                  val = "";
                                  op = "+";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                ".",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "0",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () {
                                setState(() {
                                  val = val + "0";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.2),
                              color: Colors.deepOrangeAccent),
                          child: SizedBox.expand(
                            child: new RaisedButton(
                              color: Colors.deepOrangeAccent,
                              child: Text(
                                "=",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  b = int.parse(val);
                                  if (op == "+") {
                                    val = (a + b).toString();
                                  } else if (op == "-") {
                                    val = (a - b).toString();
                                  } else if (op == "/") {
                                    val = (a / b).toString();
                                    if (val.contains('.')) {
                                      String s = val.substring(
                                          val.indexOf('.'), val.length);
                                      if (s.length > 5) {
                                        val =
                                            val.substring(0, val.indexOf(".")) +
                                                val.substring(val.indexOf('.'),
                                                    val.indexOf('.') + 5);
                                      } else {
                                        val =
                                            val.substring(0, val.indexOf(".")) +
                                                val.substring(val.indexOf('.'));
                                      }
                                    }
                                  } else if (op == "x") {
                                    val = (a * b).toString();
                                  } else if (op == "%") {
                                    val = (a % b).toString();
                                  }

                                  op = "+";
                                });
                                a = 0;
                                b = 0;
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
