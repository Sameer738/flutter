import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Animate extends StatefulWidget {
  @override
  _AnimateState createState() => _AnimateState();
}

class _AnimateState extends State<Animate> {
  int height = 100, width = 100;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getS();
  }

  void setS(int w, int h) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("bw", w);
    prefs.setInt("bh", h);
  }

  void getS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     width = prefs.getInt('bw');
     height = prefs.getInt('bh');
     print(width.toString()+"\n"+height.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      height += 50;
                    });
                    setS(width, height);
                  },
                  onTapUp: (TapUpDetails d) {
                    Offset o = d.localPosition;
                    if (o.dx <= (width / 2) && o.dy <= (height / 2)) {
                      print("1");
                      setState(() {
                        width += 50;
                      });
                      setS(width, height);
                    }
                    if (o.dx >= (width / 2) && o.dy >= (height / 2)) {
                      print("4");
                      setState(() {
                        height += 50;
                      });
                      setS(width, height);
                    }
                    if (o.dx >= (width / 2) && o.dy <= (height / 2)) {
                      print("2");
                      setState(() {
                        width -= 50;
                        if (width == 0) {
                          width = 50;
                        }
                      });
                      setS(width, height);
                    }
                    if (o.dx <= (width / 2) && o.dy >= (height / 2)) {
                      print("3");
                      setState(() {
                        height -= 50;
                        if (height == 0) {
                          height = 50;
                        }
                      });
                      setS(width, height);
                    }
                  },
                  child: AnimatedContainer(
                    height: height.toDouble(),
                    width: width.toDouble(),
                    color: Colors.red,
                    curve: Curves.bounceInOut,
                    duration: Duration(seconds: 2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        setState(() {
                          height += 50;
                        });
                        setS(width, height);
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        setState(() {
                          height -= 50;
                          if (height == 0) {
                            height = 50;
                          }
                        });
                        setS(width, height);
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        setState(() {
                          width -= 50;
                          if (width == 0) {
                            width = 50;
                          }
                        });
                        setS(width, height);
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        setState(() {
                          width += 50;
                        });
                        setS(width, height);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
