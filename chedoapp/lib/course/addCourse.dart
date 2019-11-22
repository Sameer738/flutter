import 'dart:io';
import 'dart:math' as Math;
import 'package:chedoapp/data/teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController courseController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController syllabusController = TextEditingController();
  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true,
      validator5 = true;
  int duration = 10;

  bool processing = false;

  String thumbnail;
  File _imageFile;

  Future<Null> _pickImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
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

  Future<void> _uploadFile() async {
    setState(() {
      processing = true;
    });

    String nm = courseController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("Course_$nm $rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    thumbnail = downurl.toString();
    print(thumbnail);
    insert();
  }

  //////////////////////////////////////////////////////////////////Fetching teacher Data //////////////////

  List<String> nameList = new List();
  String teacherName;

  getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('teacher').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((data) {
      final teacher = Teacher.fromSnapshot(data);
      nameList.add(teacher.name);
    });
    setState(() {
      //selected = nameList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD COURSE"),
        actions: <Widget>[
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
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
                      if (courseController.text != "" &&
                          feesController.text != "" &&
                          syllabusController.text != "") {
                        _uploadFile();
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                      "Please fill out all required fields "),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ));
                      }
                    });
                  },
                )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(18),
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 120,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _pickImageFromGallery();
                        });
                      },
                      child: Container(
                        height: 120,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile)
                              : AssetImage("asset/placeholderImage.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 120,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: courseController,
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
                  errorText: !validator1
                      ? "Course name Should be greater than 3 characters"
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Course Name",
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Duration",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Slider(
                        min: 10.0,
                        max: 90.0,
                        divisions: 8,
                        activeColor: Colors.orange,
                        label: duration.toString(),
                        value: duration.toDouble(),
                        onChanged: (double d) {
                          setState(() {
                            duration = d.toInt();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        duration.toString() + " Hrs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(
                            top: 0,
                            left: 8,
                          ),
                          child: Text(
                            "Teacher Name :",
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 0, left: 10, right: 5),
                        child: DropdownButton(
                          hint: Text('Please Choose Teacher  '),
                          value: teacherName,
                          onChanged: (newValue) {
                            setState(() {
                              teacherName = newValue;
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
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: feesController,
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
                  errorText:
                      !validator2 ? "Fees Should be greater than 99rs" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Fees",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                maxLines: 11,
                controller: syllabusController,
                onChanged: (String str3) {
                  if (str3.length < 3) {
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
                  errorText: !validator3
                      ? "Syllabus Should be greater than 3 characters"
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  labelText: "Syllabus",
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insert() async {
    CircularProgressIndicator();
    Firestore.instance.collection('course').document().setData({
      'coursename': courseController.text,
      'duration': duration.toInt(),
      'fees': feesController.text,
      'syllabus': syllabusController.text,
      'teachername': teacherName,
      'imageurl': thumbnail,
    });
    Navigator.pop(context);
  }
}
