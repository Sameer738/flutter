import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dashboard.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chedo_IMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseUser user;
  bool authenticate = false;
  bool processing = false;

  String name = "";

  final cFirebaseAuth = FirebaseAuth.instance;

  final cGoogleSignIn = GoogleSignIn();

  void initState() {
    super.initState();
    cFirebaseAuth.currentUser().then(
          (user) => setState(() {
            this.user = user;
          }),
        );
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await cGoogleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = await cFirebaseAuth.signInWithCredential(credential);
    setState(() {
      name = user.displayName;
      authenticate = true;
      processing = false;
    });
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      if (_authorized == 'Authorized') {
        c=Colors.green;
        processing=true;
        _handleSignIn();
      }
      else{
        c=Colors.black;
      }
    });
  }

  Color c = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          WavyHeaderImage(),
          Positioned(
            bottom: 400,
            left: 30,
            child: Container(
              width: 120,
              alignment: Alignment.topLeft,
              child: Image.asset("asset/image.png"),
            ),
          ),
          Positioned(
            bottom: 125.0,
            right: 180.0,
            width: 35,
            // left: 175.0,
            // right: 175.0,
            child: processing ? CircularProgressIndicator() : SizedBox(),
          ),
          Positioned(
            bottom: 350,
            left: 40,
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chedo Tech",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                )),
          ),
          Positioned(
            bottom: 295,
            left: 40,
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Computer Education & \nDevelopment Centre",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                )),
          ),
          Positioned(
            bottom: 170,
            left: 75,
            right: 75,
            child: Container(
              height: 48,
              width: 250,
              child: !authenticate
                  ? RaisedButton(
                      color: Colors.redAccent.withOpacity(0.8),
                      onPressed: () {
                        setState(() {
                          processing = true;
                        });
                        _handleSignIn();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : SizedBox(),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 150.0,
            left: 150.0,
            child: InkWell(
                onTap: () {
                  _authenticate();
                },
                child: Icon(
                  Icons.fingerprint,
                  size: 65,
                  color: c,
                )),
          ),
        ],
      ),
    );
  }
}

class WavyHeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          child: Container(
            height: 350,
            color: Color.fromARGB(255, 233, 241, 252),
          ),
          clipper: BottomWaveClipper(),
        ),
      ],
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 1.0);
    path.cubicTo(size.width * 0.8, size.height * -0.3, size.width * 0.5,
        size.height * 1.2, size.width, size.height * 0.9);
    //path.quadraticBezierTo(size.width / 2, size.height*0.9, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
