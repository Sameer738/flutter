import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool validator1 = true, validator2 = true;
  FirebaseUser user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('SignInEmail Succeeded : $user');

    return user;
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    print('User Created Successfull  $user');
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign With Email'),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                onChanged: (String str1) {
                  if (str1.length < 3) {
                    setState(() {
                      validator1 = false;
                    });
                  } else {
                    setState(() {
                      validator1 = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.email),
                  errorText: !validator1
                      ? "Email Should be greater than 3 characters"
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Email",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                controller: passController,
                onChanged: (String str2) {
                  if (str2.length < 3) {
                    setState(() {
                      validator2 = false;
                    });
                  } else {
                    setState(() {
                      validator2 = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.palette),
                  errorText: !validator2
                      ? "Pass Should be greater than 3 characters"
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "PassWord",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  handleSignInEmail(emailController.text, passController.text);
                },
                child: Icon(Icons.save),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  handleSignUp(emailController.text, passController.text);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
