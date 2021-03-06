import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp5/signUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String ans = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  TextEditingController emailController1 = TextEditingController();
  TextEditingController passController1 = TextEditingController();

  bool validator1 = true, validator2 = true;

  FirebaseUser user;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);

      print('SignInEmail Succeeded : $user');
      setState(() {
        ans = 'SignInEmail Succeeded ';
      });

      return user;
    } catch (e) {
      ans = e.toString();
      return null;
    }
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      print('User Created Successfull  $user');
      setState(() {
        ans = 'User Created Successfull';
      });
      return user;
    } catch (e) {
      setState(() {
        ans = 'Email already Exists';
      });
      return null;
    }
  }

  _showDialogSignUp(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text('Enter Details for New Account'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: emailController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(3),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      obscureText: true,
                      controller: passController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.palette),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "PassWord",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      handleSignUp(emailController1.text, passController1.text);

                      setState(() {
                        emailController1.text = '';
                        passController1.text = '';
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showDialogSignIn(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text('Enter Your Details'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: emailController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(3),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: passController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.palette),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "PassWord",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      handleSignInEmail(
                          emailController1.text, passController1.text);
                      setState(() {
                        emailController1.text = '';
                        passController1.text = '';
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login With Email '),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: ListView(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text('Sign Up'),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  _showDialogSignIn(context);
                },
                child: Text('Sign In'),
              ),
              SizedBox(
                height: 100.0,
              ),
              Center(
                child: Text(ans),
              )
            ],
          ),
        ),
      ),
    );
  }
}
