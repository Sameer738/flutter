import 'dart:io';
import 'package:chedoapp/data/course.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:math' as Math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chedoapp/data/record.dart';
import 'package:chedoapp/imageView.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StudentDetails extends StatefulWidget {
  final Record record;

  StudentDetails(this.record);
  @override
  _StudentDetails createState() => _StudentDetails(this.record);
}

class _StudentDetails extends State<StudentDetails> {
  final Record record;

  _StudentDetails(this.record);

  
  TextEditingController namefieldController = TextEditingController();
  TextEditingController emailfieldController = TextEditingController();
  TextEditingController addressfieldController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController optionalNoController = TextEditingController();
  TextEditingController aadharfieldController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true,
      validator5 = true,
      validator6 = true,
      validator7 = true,
      togg = false,
      editCont = false;
  bool processing = false, status, val = true;
  DateTime dob, addDate;
  DateTime _fromDay = new DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  String thumbnail;
  File _imageFile;
  String photourl;
  bool flag = true;

  Future<Null> _pickImageFromGallery() async {
    print("___________________________________________");
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
      flag = false;
    });
  }

  Future<Null> _pickImageFromCamera() async {
    print("___________________________________________");
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
      flag = false;
    });
  }

  Future<File> compressFile(File file, String targetPath) async {
    print(file.lengthSync().toString() + "________________FILE______________");

    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 60, minHeight: 400, minWidth: 400);

    print(result.lengthSync().toString() +
        "________________COMPRESS FILE______________");

    return result;
  }

  Future<void> _uploadFile() async {
    setState(() {
      processing = true;
      print("uploading");
    });
    String nm = namefieldController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("Student_$nm _$rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    thumbnail = downurl.toString();
    photourl = downurl.toString();
    print(thumbnail);
    update();
  }

  List<String> nameList = new List();
  String courseName;

  getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('course').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((data) {
      final course = Course.fromSnapshot(data);
      //print(course.coursename);
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
    namefieldController.text = record.name;
    emailfieldController.text = record.email;
    addressfieldController.text = record.address;
    mobileController.text = record.mobileno;
    optionalNoController.text = record.optionalno;
    aadharfieldController.text = record.aadharno;
    batchController.text = record.batchtime;
    photourl = record.imageurl;
    _fromDay = record.dateofbirth.toDate();
    addDate = record.addDate.toDate();
    status = record.status;
    courseName = record.coursename;
    emailfieldController.text = record.email;
    val = record.status;
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
                        builder: (context) => ImageView(photourl)));
              },
              child: SizedBox(
                height: 280,
                width: double.infinity,
                child: _imageFile == null
                    ? CachedNetworkImage(
                        imageUrl: record.imageurl,
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
                                      Text(record.addDate
                                              .toDate()
                                              .day
                                              .toString() +
                                          ' / ' +
                                          record.addDate
                                              .toDate()
                                              .month
                                              .toString() +
                                          ' / ' +
                                          record.addDate
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
                                imageUrl: record.imageurl,
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

  void update() async {
    setState(() {
      processing = true;
    });
    Firestore.instance
        .collection('admission')
        .document(record.reference.documentID)
        .setData({
      'name': namefieldController.text,
      'address': addressfieldController.text,
      'mobileNo': mobileController.text,
      'optNumber': optionalNoController.text,
      'aadharNo': aadharfieldController.text,
      'courseName': courseName,
      'batchTime': batchController.text,
      'imageUrl': photourl,
      'dateOfBirth': _fromDay,
      'status': val,
      'addDate': addDate,
      'email': emailfieldController.text,
    });
    Navigator.pop(context);
  }
}

// date picker ====================================================================

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
      lastDate: DateTime(2002),
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
          child: InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
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
          contentPadding: EdgeInsets.all(13),
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
            Text(valueText, style: TextStyle(fontSize: 15)),
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
