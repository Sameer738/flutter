import 'dart:math';

import 'package:flutter/material.dart';

class WrapDemo extends StatefulWidget {
  @override
  _WrapDemoState createState() => _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {
  double pad=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
              Container(
                color: randomColor(),
                height: 200,
              ),
          ],
        )
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            pad=pad-10;
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    );
                  }
                
                  Color randomColor() {

                    Random random = Random();

                    int r = random.nextInt(250);
                    int g = random.nextInt(250);
                    int b = random.nextInt(250);

                    return Color.fromRGBO(r, g, b, 10);

                  }
}
