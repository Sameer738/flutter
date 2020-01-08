import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chedoapp/imageView.dart';
import 'package:chedoapp/student/studentShowDetails.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as Math;
import 'package:chedoapp/data/course.dart';
import 'package:chedoapp/data/teacher.dart';

class TeacherDetails extends StatefulWidget {
  final Teacher teacher;
  TeacherDetails(this.teacher);
  @override
  _TeacherDetails createState() => _TeacherDetails(teacher);
}

class _TeacherDetails extends State<TeacherDetails> {
  final Teacher teacher;
  _TeacherDetails(this.teacher);

  TextEditingController namefieldController = TextEditingController();
  TextEditingController aadharfieldController = TextEditingController();
  TextEditingController educationfieldController = TextEditingController();
  TextEditingController emailfieldController = TextEditingController();
  TextEditingController mobilefieldController = TextEditingController();
  TextEditingController optionalNofieldController = TextEditingController();
  TextEditingController designationfieldController = TextEditingController();
  TextEditingController addressfieldController = TextEditingController();
  TextEditingController salaryfieldController = TextEditingController();
  TextEditingController timingfieldController = TextEditingController();

  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true,
      validator5 = true,
      validator6 = true,
      validator7 = true,
      validator8 = true,
      validator9 = true,
      validator10 = true;

  bool processing = false, editCont = false;

  bool status = true, flag = true,val;

  DateTime dob, addDate;
  DateTime _fromDay = new DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  String thumbnail;
  File _imageFile;

  Future<Null> _pickImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
    });
  }

  Future<Null> _pickImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this._imageFile = imageFile;
    });
  }

  Future<File> compressFile(File file, String targetPath) async {
    // print(file.lengthSync().toString() +
    //     "_______________orignal_______________________");
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 60, minHeight: 350, minWidth: 350);

    // print(result.lengthSync().toString() +
    //     "_______________compressed_______________________");

    return result;
  }

  Future<void> _uploadFile() async {
    setState(() {
      processing = true;
    });
    String nm = namefieldController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("Teacher_$nm $rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    thumbnail = downurl.toString();
    print(thumbnail);
    update();
  }

  void update() async {
    CircularProgressIndicator();
    Firestore.instance.collection('teacher').document().setData({
      'name': namefieldController.text,
      'education': educationfieldController.text,
      'designation': designationfieldController.text,
      'course': courseName,
      'dateofbirth': _fromDay,
      'mobileno': mobilefieldController.text,
      'optionalno': optionalNofieldController.text,
      'address': addressfieldController.text,
      'salary': salaryfieldController.text,
      'imageurl': thumbnail,
      'timing': timingfieldController.text,
      'addDate': DateTime.now(),
      'aadharNo': aadharfieldController.text,
      'email': emailfieldController.text,
    });
    Navigator.pop(context);
  }

  //////////////////////////////////////////////////Fetching Course Data ////////////////////////

  List<String> nameList = new List();
  String courseName;

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
    namefieldController.text = teacher.name;
    educationfieldController.text = teacher.education;
    designationfieldController.text = teacher.designation;
    courseName = teacher.course;
    _fromDay = teacher.dateofbirth.toDate();
    mobilefieldController.text = teacher.mobileno;
    optionalNofieldController.text = teacher.optionalno;
    addressfieldController.text = teacher.optionalno;
    salaryfieldController.text = teacher.salary;
    thumbnail = teacher.imageurl;
    timingfieldController.text = teacher.timing;
    addDate = teacher.addDate.toDate();
    aadharfieldController.text = teacher.aadhar;
    emailfieldController.text = teacher.email;
    val=teacher.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageView(thumbnail)));
              },
              child: SizedBox(
                height: 280,
                width: double.infinity,
                child: _imageFile == null
                    ? CachedNetworkImage(
                        imageUrl: teacher.imageurl,
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
                                      errorText: !validator1
                                          ? "Name Should be greater than 3 characters"
                                          : null,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      labelText: "Name",
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
                                      children: <Widget>[
                                        Chip(
                                          label: Text(
                                            courseName,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor:
                                              Colors.deepOrangeAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // Chip(
                                        //   label: Text(
                                        //     record.status
                                        //         ? 'Active'
                                        //         : 'Inactive',
                                        //     style:
                                        //         TextStyle(color: Colors.white),
                                        //   ),
                                        //   backgroundColor: Colors.green,
                                        // )
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Switch(
                                          activeColor: Colors.green,
                                          inactiveTrackColor: Colors.red,
                                          activeTrackColor: Colors.green,
                                          value: val,
                                          onChanged: (bool st) {
                                            val = st;
                                          },
                                        ),
                                      ],
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
                                      DateTimePicker(
                                        labelText: 'DOB',
                                        selectedDate: _fromDay,
                                        selectDate: (DateTime date) {
                                          setState(() {
                                            _fromDay = date;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Text(teacher.addDate
                                              .toDate()
                                              .day
                                              .toString() +
                                          ' / ' +
                                          teacher.addDate
                                              .toDate()
                                              .month
                                              .toString() +
                                          ' / ' +
                                          teacher.addDate
                                              .toDate()
                                              .year
                                              .toString()),
                                      Text("Joined")
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
                                imageUrl: teacher.imageurl,
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
                            controller: mobilefieldController,
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
                            controller: optionalNofieldController,
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
                            controller: timingfieldController,
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
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: 0,
                                    left: 20,
                                  ),
                                  child: Text(
                                    "Course Name :",
                                    style: TextStyle(fontSize: 15),
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 0,
                                  left: 30,
                                ),
                                child: DropdownButton(
                                  hint: Text('Please Choose Course  '),
                                  value: courseName,
                                  onChanged: (newValue) {
                                    setState(() {
                                      courseName = newValue;
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
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                editCont
                    ? Row(
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
                            onPressed: () async =>
                                await _pickImageFromGallery(),
                          ),
                          processing
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  child: processing
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
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
                                      if (flag == true) {
                                        update();
                                      } else {
                                        _uploadFile();
                                      }
                                    });
                                  },
                                )
                        ],
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            editCont = true;
                          });
                        },
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
