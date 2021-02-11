import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class SignInWithPhoneNo extends StatefulWidget {
  @override
  _SignInWithPhoneNoState createState() => _SignInWithPhoneNoState();
}

class _SignInWithPhoneNoState extends State<SignInWithPhoneNo> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  TelephonyInfo _info;
  String _message = '';
  String _verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTelephonyInfo();
  }

  Future<void> getTelephonyInfo() async {
    TelephonyInfo info;
    try {
      info = await FltTelephonyInfo.info;
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _info = info;
    });
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    print('try....');
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
        print(phoneAuthCredential);
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text('Test sign in with phone number'),
            alignment: Alignment.center,
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
                labelText: 'Phone number (+x xxx-xxx-xxxx)'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Phone number (+x xxx-xxx-xxxx)';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                _verifyPhoneNumber();
              },
              child: const Text('Verify phone number'),
            ),
          ),
          TextField(
            controller: _smsController,
            decoration: const InputDecoration(labelText: 'Verification code'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                _signInWithPhoneNumber();
              },
              child: const Text('Sign in with phone number'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _message,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Phone Number: ${_info?.line1Number}\n'),
          )
        ],
      ),
    );
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }
}
