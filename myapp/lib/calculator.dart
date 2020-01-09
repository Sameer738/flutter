import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

TextEditingController atextController = new TextEditingController();
String value = "",value1="", op = "";
int a = 0, b = 0, flag = 0;

class _Calculator extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.all(20), child: Icon(Icons.arrow_back)))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.black54,
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "AC",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = "";
                              value1="";
                              a = 0;
                              b = 0;
                              flag = 0;
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
                          color: Colors.black54,
                          child: Icon(
                            Icons.backspace,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              value = value.substring(0, (value.length - 1));
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "%",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              a = int.parse(value);
                              
                              value = "";
                              value1=value;

                              op = "%";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "/",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              a = int.parse(value);
                              value = "";
                              op = "/";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "7",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "7";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "8",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "8";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "9",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "9";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "*",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              flag++;
                              if(flag==1){
                              a = int.parse(value);
                              value = "";
                              op = "*";
                              }
                              else{
                                if(op=="+"){
                                  b=int.parse(value);
                                  a=(a+b);
                                }
                                if(op=="-"){
                                  b=int.parse(value);
                                  a=(a-b);
                                }
                                if(op=="*"){
                                  b=int.parse(value);
                                  a=(a*b);
                                }
                                if(op=="/"){
                                  b=int.parse(value);
                                  a=(a/b) as int;
                                }
                                op="*";
                                value="";
                              }
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "4",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "4";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "5",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "5";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "6",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "6";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "-",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              flag++;
                              if(flag==1){
                              a = int.parse(value);
                              value = "";
                              op = "-";
                              }
                              else{
                                if(op=="+"){
                                  b=int.parse(value);
                                  a=(a+b);
                                }
                                if(op=="-"){
                                  b=int.parse(value);
                                  a=(a-b);
                                }
                                if(op=="*"){
                                  b=int.parse(value);
                                  a=(a*b);
                                }
                                if(op=="/"){
                                  b=int.parse(value);
                                  a=(a/b) as int;
                                }
                                op="-";
                                value="";
                              }
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "1";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "2",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "2";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "3";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "+",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              flag++;
                              if(flag==1){
                              a = int.parse(value);
                              value = "";
                              op = "+";
                              }
                              else{
                                if(op=="+"){
                                  b=int.parse(value);
                                  a=(a+b);
                                }
                                if(op=="-"){
                                  b=int.parse(value);
                                  a=(a-b);
                                }
                                if(op=="*"){
                                  b=int.parse(value);
                                  a=(a*b);
                                }
                                if(op=="/"){
                                  b=int.parse(value);
                                  a=(a/b) as int;
                                }
                                op="+";
                                value="";
                              }
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(""),
                          onPressed: () {},
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "0",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + "0";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            ".",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              value = value + ".";
                            });
                          },
                        ),
                      ),
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black54,
                      child: SizedBox.expand(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Text(
                            "=",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            setState(() {
                              b = int.parse(value);
                              if (op == "+") {
                                value = (a + b).toString();
                                a = int.parse(value);
                              } else if (op == "-") {
                                value = (a - b).toString();
                                a = int.parse(value);
                              } else if (op == "*") {
                                value = (a * b).toString();
                                a = int.parse(value);
                              } else if (op == "/") {
                                value = (a / b).toString();
                                a = int.parse(value);
                              } else if (op == "%") {
                                value = (a % b).toString();
                                a = int.parse(value);
                              }
                            });
                            a = 0;
                            b = 0;
                            flag=0;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
