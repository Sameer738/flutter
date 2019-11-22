import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as Math;

import 'package:chedoapp/data/course.dart';

class NewAddmission extends StatefulWidget {
  @override
  _NewAddmissionState createState() => _NewAddmissionState();
}

class _NewAddmissionState extends State<NewAddmission> {
  TextEditingController namefieldController = TextEditingController();
  TextEditingController addressfieldController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController optionalNoController = TextEditingController();
  TextEditingController aadharfieldController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  TextEditingController emailfieldController = TextEditingController();

  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true,
      validator5 = true,
      validator6 = true,
      validator7 = true,
      validator8 = true,
      validator9=true,
      validator10=true,
      togg = false;

  bool processing = false;

  bool status = true;
  DateTime dob;
  DateTime _fromDay = new DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  String thumbnail;
  File _imageFile;

  List<String> nameList = new List();
  String courseName;

  ///////////////////////////////////////////////////////////////////   Image Picker  //////////

  Future<Null> _pickImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
    });
  }

  Future<Null> _pickImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = await compressFile(imageFile, imageFile.path);
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

  //////////////////////////////////////////////////////////Uploading File //////////////////////

  Future<void> _uploadFile() async {
    setState(() {
      processing = true;
    });
    String nm = namefieldController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("Student_$nm _$rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    thumbnail = downurl.toString();
    print(thumbnail);
    insert();
  }

  void insert() async {
    print("------------------------"+courseName);
    setState(() {
      processing = true;
    });
    Firestore.instance.collection('admission').document().setData({
      'name': namefieldController.text,
      'address': addressfieldController.text,
      'mobileNo': mobileController.text,
      'optNumber': optionalNoController.text,
      'dateOfBirth': _fromDay,
      'aadharNo': aadharfieldController.text,
      'courseName': courseName,
      'batchTime': batchController.text,
      'imageUrl': thumbnail,
      'status': status,
      'addDate': DateTime.now(),
      'email': emailfieldController.text,
    });
    Navigator.pop(context);
  }

  /////////////////////////////////////////////////// Fetching  Course Data////////////////

  

  getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('course').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((data) {
      final course = Course.fromSnapshot(data);
      nameList.add(course.coursename);
    });
    setState(() {
      //courseName = nameList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //////////////////////////////////////////////////////////////////////////
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
                                          validator10 = false;
                                        });
                                      } else {
                                        setState(() {
                                          validator10 = true;
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
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                  top: 0,
                                                  left: 0,
                                                ),
                                                child: Text(
                                                  "Course Name :",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                top: 0,
                                                left: 10,
                                              ),
                                              child: DropdownButton(
                                                hint: Text(
                                                    'Please Choose Course  '),
                                                value: courseName,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    courseName = newValue;
                                                    print(courseName);
                                                  });
                                                },
                                                items: nameList.map((location) {
                                                  return DropdownMenuItem(
                                                    child: new Text(location),
                                                    value: location,
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                          title: Text("Student Information"),
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
                                  validator7 = false;
                                });
                              } else {
                                setState(() {
                                  validator7 = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(Icons.email),
                              errorText: !validator7
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
                        ListTile(
                          title: TextField(
                            //enabled: editCont,
                            keyboardType: TextInputType.number,
                            controller: optionalNoController,
                            onChanged: (String str4) {
                              if (str4.length != 10) {
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
                              prefixIcon: Icon(Icons.call),
                              errorText: !validator4
                                  ? "Mobile Number should be of 10 digit"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "Optional Number",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: TextField(
                            //enabled: editCont,
                            //maxLines: 2,
                            controller: addressfieldController,
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
                              prefixIcon: Icon(Icons.confirmation_number),
                              errorText: !validator2
                                  ? "Address Should be greater than 3 characters"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "Address",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        DateTimePicker(
                          labelText: 'DOB',
                          selectedDate: _fromDay,
                          selectDate: (DateTime date) {
                            setState(() {
                              _fromDay = date;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          title: Transform.scale(
                            scale: 1,
                            child: TextField(
                              //enabled: editCont,
                              keyboardType: TextInputType.number,
                              controller: aadharfieldController,
                              onChanged: (String str5) {
                                if (str5.length != 12) {
                                  setState(() {
                                    validator5 = false;
                                  });
                                } else {
                                  setState(() {
                                    validator5 = true;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                prefixIcon: Icon(Icons.confirmation_number),
                                errorText: !validator5
                                    ? "Aadhar Number should be of 12 digit"
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: "Aadhar Card No",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: TextField(
                            //enabled: editCont,
                            //maxLines: 3,
                            controller: batchController,
                            onChanged: (String str7) {
                              if (str7.length < 3) {
                                setState(() {
                                  validator7 = false;
                                });
                              } else {
                                setState(() {
                                  validator7 = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(Icons.access_time),
                              errorText: !validator7
                                  ? "Batch Time Should be greater than 3 characters"
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: "Batch Time",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
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
                                _uploadFile();
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

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);
  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2005),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: 
          Container(
            width: 50,
          ),
        ),
        Expanded(
          flex: 20,
          child: InputDropdown(
            
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: 
          Container(
            width: 50,
          ),
        ),
        //const SizedBox(width: 0.0),
      ],
    );
  }
}

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);
  final String labelText;
  final String valueText;

  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
