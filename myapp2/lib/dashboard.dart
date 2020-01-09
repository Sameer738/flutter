import 'package:flutter/material.dart';

import 'package:myapp2/webview.dart';

import 'package:myapp2/htmlview.dart';

import 'package:myapp2/markup.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME",
        ),
      ),
      body: Text("MY APPS"),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: Text('My App'),
              height: 100,
              color: Colors.blue,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => WebView())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Web View"),
              ),
            ),
            
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MarkUp())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Mark Up"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HTMLView())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("HTML VIEW"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
