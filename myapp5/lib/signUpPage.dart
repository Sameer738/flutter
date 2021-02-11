import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as Math;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController namefieldController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController emailfieldController = TextEditingController();
  TextEditingController passwordfieldController = TextEditingController();

  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true;

  bool processing = false;

  bool status = true;

  String thumbnail;
  File _imageFile;

  FirebaseUser user;
  String ans = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  // # Pick Image

  Future<Null> _pickImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    //imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
    });
  }

  Future<Null> _pickImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    //imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
    });
  }

  Future<File> compressFile(File file, String targetPath) async {
    print(file.lengthSync().toString() +
        "_______________orignal_______________________");
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 60, minHeight: 350, minWidth: 350);

    print(result.lengthSync().toString() +
        "_______________compressed_______________________");

    return result;
  }

  Future<void> _uploadFile() async {
    setState(() {
      processing = true;
    });
    String nm = namefieldController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("User_$nm _$rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    thumbnail = downurl.toString();
    print(thumbnail);
    insert();
  }

  void insert() async {
    setState(() {
      processing = true;
    });
    Firestore.instance
        .collection('Users')
        .document(emailfieldController.text)
        .setData({
      'name': namefieldController.text,
      'mobileNo': mobileController.text,
      'imageUrl': thumbnail,
      'status': status,
      'addDate': DateTime.now(),
      'email': emailfieldController.text,
    });
    Navigator.pop(context);
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
        _uploadFile();
      });
      return user;
    } catch (e) {
      setState(() {
        ans = 'Email already Exists';
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 280,
                width: double.infinity,
                child: _imageFile == null
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0ESwkWuLCiL0PBGqrdGvNWkK1MU3lQa6M2KDKBrS8LzZ3AYeI',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                        fit: BoxFit.cover,
                        height: 280,
                      )
                    : Image.file(_imageFile),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextField(
                                    controller: namefieldController,
                                    onChanged: (String str10) {
                                      if (str10.length < 3) {
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
                                      errorText: !validator1
                                          ? "Name Should be greater than 3 characters"
                                          : null,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      labelText: "Name",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: _imageFile == null
                            ? CachedNetworkImage(
                                imageUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ0ESwkWuLCiL0PBGqrdGvNWkK1MU3lQa6M2KDKBrS8LzZ3AYeI',
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                height: 280,
                              )
                            : Image.file(_imageFile),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Information"),
                        ),
                        Divider(),
                        ListTile(
                          title: TextField(
                            //enabled: editCont,
                            //maxLines: 2,
                            controller: emailfieldController,
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
                              prefixIcon: Icon(Icons.email),
                              errorText: !validator2
                                  ? "Email Should be greater than 3 characters"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "Email",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: TextField(
                            obscureText: true,
                            //enabled: editCont,
                            //maxLines: 2,
                            controller: passwordfieldController,
                            onChanged: (String str4) {
                              if (str4.length < 3) {
                                setState(() {
                                  validator4 = false;
                                });
                              } else {
                                setState(() {
                                  validator4 = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(Icons.vpn_key),
                              errorText: !validator4
                                  ? "Password Should be greater than 3 characters"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "PassWord",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: TextField(
                            //enabled: editCont,
                            keyboardType: TextInputType.number,
                            controller: mobileController,
                            onChanged: (String str3) {
                              if (str3.length != 10) {
                                setState(() {
                                  validator3 = false;
                                });
                              } else {
                                setState(() {
                                  validator3 = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(Icons.call),
                              errorText: !validator3
                                  ? "Mobile Number should be of 10 digit"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "Mobile No",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                      tooltip: 'Camera',
                      onPressed: () async => await _pickImageFromCamera(),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      tooltip: 'Gallary',
                      onPressed: () async => await _pickImageFromGallery(),
                    ),
                    processing
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child: processing
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : SizedBox(),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.save,
                              size: 30,
                            ),
                            tooltip: 'Save',
                            onPressed: () {
                              setState(() {
                                handleSignUp(emailfieldController.text,
                                    passwordfieldController.text);
                              });
                            },
                          )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
