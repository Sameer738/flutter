import 'package:flutter/material.dart';
import 'package:myapp6/animate.dart';
import 'package:myapp6/authNew.dart';
import 'package:myapp6/player.dart';
import 'package:myapp6/snackbar.dart';

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
      body: Center(
          child: Text(
        "MY APPS",
        style: TextStyle(fontSize: 25),
      )),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child:
                  Center(child: Text('My App', style: TextStyle(fontSize: 25))),
              height: 100,
              color: Colors.blue,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AssetPlayer())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Audio Player"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Animate())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Animation "),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SnackBarDemo())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("SnackBar"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AuthNew())));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Authentication"),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: ((context) => FaceDetect())));
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.person),
            //     title: Text("Face Detection"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
