
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myapp3/profiles.dart';
import 'package:myapp3/webview.dart';

import 'calculator.dart';
import 'htmlview.dart';
import 'input.dart';
import 'moreInput.dart';


class DrawerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawerApp();
  }
}

class _DrawerApp extends State<DrawerApp> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Calculator()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "Calculator",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Input()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "Input",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profiles()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "Profiles",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MoreInput()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "More Inputs",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WebView()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "Web View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DrawerApp()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "DrawerApp",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HTMLView()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.donut_small,
                  ),
                  title: Text(
                    "Html View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}
