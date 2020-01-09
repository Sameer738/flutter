
import 'package:flutter/material.dart';

class FirstDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstDemo();
  }
}

class _FirstDemo extends State<FirstDemo> {
  List<String> player = new List();

  addPlayer(String s) {
    print(s);
    player.add(s);
  }

  String p = "--";
  int cnt = 0;
  TextEditingController playerController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              cnt++;
            });
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("FirstDemo"),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Image.asset('img/saina.jpg'),
              Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: playerController,
                  )),
              Container(
                  child: RaisedButton(
                onPressed: () {
                  setState(() {
                    addPlayer(playerController.text);
                    p = " ";
                    for (int i = 0; i < player.length; i++) {
                      p = p + "\n" + player[i];
                    }
                  });
                },
                child: Text("ADD"),
              )),
              Text(p),
              Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    cnt.toString(),
                    style: TextStyle(fontSize: 40),
                  )),
                  Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child:RaisedButton(
                    onPressed: () {
                  setState(() {
                    cnt--;
                  });
                },
                child: Text("-",),
                    
                  )
                  )
            ],
          ),
        ),
      );
  }
}
