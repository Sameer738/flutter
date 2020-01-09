import 'package:flutter/material.dart';
import 'list.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "WELCOME",
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.green[300],
      body: Center(
        child: Text(
          "MY APPS",
          style: TextStyle(fontSize: 30),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.cyan),
                child: Center(
                  child: Text(
                    "INDEX",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                    ),
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ListPage())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Cloud Firebase"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
