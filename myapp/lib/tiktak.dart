import 'package:flutter/material.dart';

class TikTak extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TikTak();
  }
}

class _TikTak extends State<TikTak> {
  
  int flag = 0;
  TextEditingController bt1 = new TextEditingController();
  TextEditingController bt2 = new TextEditingController();
  TextEditingController bt3 = new TextEditingController();
  TextEditingController bt4 = new TextEditingController();
  TextEditingController bt5 = new TextEditingController();
  TextEditingController bt6 = new TextEditingController();
  TextEditingController bt7 = new TextEditingController();
  TextEditingController bt8 = new TextEditingController();
  TextEditingController bt9 = new TextEditingController();
  String result="";

  @override
  void initState() {
    super.initState();
  }

  void check() {
    if (bt1.text == bt2.text && bt2.text == bt3.text && bt1.text.isNotEmpty) {
      setState(() {
        if(bt1.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt1.text);
    } else if (bt4.text == bt5.text &&
        bt5.text == bt6.text &&
        bt4.text.isNotEmpty) {
          setState(() {
        if(bt4.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt4.text);
      
    } else if (bt7.text == bt8.text &&
        bt8.text == bt9.text &&
        bt7.text.isNotEmpty) {
          setState(() {
        if(bt7.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt7.text);
    } else if (bt7.text == bt4.text &&
        bt4.text == bt1.text &&
        bt7.text.isNotEmpty) {
          setState(() {
        if(bt7.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt7.text);
    } else if (bt8.text == bt5.text &&
        bt5.text == bt2.text &&
        bt8.text.isNotEmpty) {
          setState(() {
        if(bt8.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt8.text);
    } else if (bt9.text == bt6.text &&
        bt6.text == bt3.text &&
        bt9.text.isNotEmpty) {
          setState(() {
        if(bt9.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt9.text);
    } else if (bt7.text == bt5.text &&
        bt5.text == bt3.text &&
        bt7.text.isNotEmpty) {
          setState(() {
        if(bt7.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt7.text);
    } else if (bt9.text == bt5.text &&
        bt5.text == bt1.text &&
        bt9.text.isNotEmpty) {
          setState(() {
        if(bt9.text=="X")
        {
       result="player 1 won" ;
        }
        else{
          result="Player 2 Won";
        }
      });
      print(bt9.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIK TAK TOE"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                child: Text("RESET",
                    style: TextStyle(color: Colors.black, fontSize: 30)),
                onPressed: () {
                  setState(() {
                    flag = 0;
                    bt1.text = "";
                    bt2.text = "";
                    bt3.text = "";
                    bt4.text = "";
                    bt5.text = "";
                    bt6.text = "";
                    bt7.text = "";
                    bt8.text = "";
                    bt9.text = "";
                    result="";
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              
              child: Text(result,style: TextStyle(color: Colors.red, fontSize: 30))),
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
                            bt1.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt1.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt1.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt1.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt2.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt2.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt2.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt2.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt3.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt3.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt3.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt3.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
                          },
                        ),
                      ),
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
                          child: Text(
                            bt4.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt4.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt4.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt4.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt5.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt5.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt5.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt5.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt6.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt6.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt6.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt6.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
                          },
                        ),
                      ),
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
                          child: Text(
                            bt7.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt7.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt7.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt7.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt8.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt8.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt8.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt8.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
                            bt9.text,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          onPressed: () {
                            if (bt9.text.isEmpty) {
                              setState(() {
                                if (flag == 0) {
                                  bt9.text = "X";
                                  flag = 1;
                                } else if (flag == 1) {
                                  bt9.text = "0";
                                  flag = 0;
                                }
                                check();
                              });
                            }
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
