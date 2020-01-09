import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NumberApiGame extends StatefulWidget {
  @override
  _NumberApiGameState createState() => _NumberApiGameState();
}

class _NumberApiGameState extends State<NumberApiGame> {
  TextEditingController numbercontroller = TextEditingController();
  Random r = Random();
  int a = 1;
  String b;
  String value = "";
  String url = 'http://numbersapi.com/0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: FutureBuilder(
                future: url != null
                    ? http.get(url).then((response) => response.body)
                    : null,
                builder: (BuildContext contex, AsyncSnapshot<String> snapshot) {
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
                        return Container(
                          child: Text('data'),
                        );
                      }
                  }
                }),
          ),
          Container(
            child: TextField(),
          )
        ],
      ),
    );
  }
}
