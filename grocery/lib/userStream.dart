
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/data/constant.dart';

class UserStream extends StatefulWidget {
  final Function handleSignOut;
  final String documentPath;
  final String documentPathOwner;
  final GoogleSignInAccount _currentUser;
  UserStream(this.handleSignOut, this._currentUser, this.documentPath,this.documentPathOwner);
  @override
  _UserStreamState createState() => _UserStreamState();
}

class _UserStreamState extends State<UserStream> {
  String userEmail;
  TextEditingController name = TextEditingController();
  FirebaseUser user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String customerprofile;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cFireBaseAuth.currentUser().then((user) => setState(() {
          this.user = user;
          userEmail = user.email;
        }));
    setState(() {
     
    });
  }

  void getCustomerEmail() {
    setState(() {
      Firestore.instance
          .document(widget.documentPath)
          .get()
          .then((DocumentSnapshot ds) {
        if (ds.exists) {
          print("__________true________________" + ds.documentID.toString());
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (contex) => CustomerDashBoard(
          //             widget.handleSignOut,
          //             widget._currentUser)));

        } else {
          print("--Email Null--  " + ds.documentID.toString());
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => CreateProfilePage(
          //             widget.handleSignOut,
          //             widget._currentUser)));

        }
      });
    });
  }


  void getShopOwnerEmail() {
    setState(() {
        print(widget.documentPathOwner);
        print(userEmail);
      Firestore.instance
          .document(widget.documentPathOwner)
          .get()
          .then((DocumentSnapshot ds) {
        if (ds.exists) {
          print("__________true________________" + ds.documentID.toString());
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (contex) => DashBoardPage(
          //             widget.handleSignOut,
          //             widget._currentUser)));

        } else {
          print("--Email Null--  " + ds.documentID.toString());
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => CreateShopOwner(
          //             widget.handleSignOut,
          //             widget._currentUser)));

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            InkWell(
              child: ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage(
                            'asset/wallpaper.jpg',
                          ),
                          fit: BoxFit.fill)),
                ),
                clipper: BottomWaveClipper(),
              ),
            ),
           
            Container(
              padding: EdgeInsets.only(top: 170),
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                padding: EdgeInsets.only(top: 140),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text("Select If your are Customer Or Shop Owner"),
                  ),
                  InkWell(
                    child: Card(
                        color: Colors.red,
                        margin: EdgeInsets.all(30),
                        elevation: 30,
                        child: Container(
                          //height: 60,
                          padding: new EdgeInsets.all(20.0),
                          child: Text(
                            "Customer",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    onTap: () {
                      getCustomerEmail();
                    },
                  ),
                  InkWell(
                    child: Card(
                        color: Colors.red,
                        margin: EdgeInsets.all(30),
                        elevation: 30,
                        child: Container(
                          //height: 60,
                          padding: new EdgeInsets.all(20.0),
                          child: Text(
                            "Shop Owner",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    onTap: () {
                      setState(() {
                       getShopOwnerEmail();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardPage(widget.handleSignOut, widget._currentUser)));
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 110);
    path.lineTo(
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
