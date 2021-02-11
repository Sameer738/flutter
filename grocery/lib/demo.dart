import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/loginPage.dart';

class Demo extends StatefulWidget {
  final GoogleSignInAccount _currentuser;
  final Function _handleSignOut;
  Demo(this._currentuser,this._handleSignOut);
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        actions: <Widget>[
          InkWell(
            onTap: (){
              setState(() {
                widget._handleSignOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInG()));
              });
            },
              child: Icon(
            Icons.settings_power,
            size: 35,
          )),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(widget._currentuser.email),
        ),
      ),
    );
  }
}
