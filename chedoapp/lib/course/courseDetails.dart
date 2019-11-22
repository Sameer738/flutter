import 'dart:io';
import 'dart:math' as Math;
import 'package:chedoapp/data/teacher.dart';
import 'package:chedoapp/imageView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chedoapp/data/course.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CourseDetail extends StatefulWidget {
  final DocumentSnapshot data;
  CourseDetail(this.data);
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController syllabusController = TextEditingController();

  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      validator4 = true,
      validator5 = true;
  int duration = 10;

  bool processing = false, editCont = false, flag = true;

  String thumbnail;

  String photourl;
  File _imageFile;

  Course course;

  Future<Null> _pickImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
      flag = false;
    });
  }

  Future<Null> _pickImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = await compressFile(imageFile, imageFile.path);
    setState(() {
      this._imageFile = imageFile;
      flag = false;
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

  Future<String> _uploadFile() async {
    setState(() {
      processing = true;
    });
    String nm = courseNameController.text;
    int rand = new Math.Random().nextInt(10000);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child("Course_$nm _$rand.jpg");

    final StorageUploadTask uploadTask = ref.putFile(_imageFile);

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    thumbnail = downurl.toString();
    photourl = downurl.toString();
    return photourl;
    // update();
  }

  void update() async {
    setState(() {
      processing = true;
    });
    Firestore.instance
        .collection('course')
        .document(widget.data.documentID)
        .setData({
      'coursename': courseNameController.text,
      'duration': duration.toInt(),
      'fees': feesController.text,
      'syllabus': syllabusController.text,
      'teachername': teacherName,
      'imageurl': thumbnail,
    });
    Navigator.pop(context);
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
    course = Course.fromSnapshot(widget.data);

    courseNameController.text = course.coursename;
    duration = course.duration;
    teacherName = course.teachername;
    feesController.text = course.fees;
    syllabusController.text = course.syllabus;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromARGB(162, 106, 99, 245),
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageView(course.imageurl)));
                        });
                      },
                      child: Image(
                        image: CachedNetworkImageProvider(course.imageurl),
                      ))),
            ),
            actions: <Widget>[
              editCont
                  ? Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 30,
                          ),
                          tooltip: 'Camera',
                          onPressed: () async => await _pickImageFromCamera(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.camera,
                            color: Colors.black,
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
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : SizedBox(),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.save,
                                  color: Colors.black,
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
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          editCont = true;
                        });
                      },
                    )
            ],
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextField(
                  enabled: editCont,
                  controller: courseNameController,
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
              ),
              Container(
                margin: EdgeInsets.all(15),
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
                          onChanged: editCont
                              ? (double d) {
                                  setState(() {
                                    duration = d.toInt();
                                  });
                                }
                              : null),
                    ),
                    Expanded(
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
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(
                            top: 0,
                            left: 7,
                          ),
                          child: Text(
                            "Teacher Name :",
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 0,
                          left: 20,
                        ),
                        child: DropdownButton(
                          hint: Text('Please Choose Teacher  '),
                          value: teacherName,
                          onChanged: (newValue) {
                            setState(() {
                              if (editCont == true) {
                                teacherName = newValue;
                              }
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
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextField(
                  enabled: editCont,
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
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextField(
                  enabled: editCont,
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
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
