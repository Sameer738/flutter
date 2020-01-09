import 'package:flutter/material.dart';
import 'package:myapp/addStud.dart';
import 'package:myapp/calculator2.dart';
import 'package:myapp/markup.dart';
import 'package:myapp/studList.dart';
import 'package:myapp/calculator.dart';
import 'package:myapp/tiktak.dart';
import 'package:myapp/loadHttpJson.dart';

import 'addDog.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  TextEditingController nameController = new TextEditingController();

  List<String> l = new List();

  void delStud(int i) {
    setState(() {
      l.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Text("MY APPS",),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: Text("CONTENT"),
              height: 70,
              color: Colors.blue,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddStud(l, delStud)));
              },
              child: ListTile(
                leading: Icon(Icons.person_add),
                title: Text("Add Student"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudList(l, delStud)));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Students"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Calculator())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Calculator(SAMEER)"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => TikTak())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Tik Tak Toe"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => JsonParsor())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("ADD JSON PARSER"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Markup())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Markup"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => DogAdd())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Add Dog"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Calculator2())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Calculator"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
