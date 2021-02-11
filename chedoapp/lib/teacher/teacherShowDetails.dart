import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chedoapp/imageView.dart';
import 'package:chedoapp/student/studentShowDetails.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as Math;
import 'package:chedoapp/data/course.dart';
import 'package:chedoapp/data/teacher.dart';

class TeacherShowDetails extends StatefulWidget {
  final Teacher teacher;
  TeacherShowDetails(this.teacher);
  @override
  _TeacherShowDetails createState() => _TeacherShowDetails(teacher);
}

class _TeacherShowDetails extends State<TeacherShowDetails> {
  final Teacher teacher;
  _TeacherShowDetails(this.teacher);
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

  bool status = true, flag = true;

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
                child: PNetworkImage(teacher.imageurl, fit: BoxFit.cover),
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
                                  Text(
                                    teacher.name,
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Teacher"),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Chip(
                                          label: Text(
                                            teacher.course,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor:
                                              Colors.deepOrangeAccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Chip(
                                          label: Text(
                                            teacher.status
                                                ? 'Active'
                                                : 'Inactive',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.green,
                                        )
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
                                  child: Column(
                                    children: <Widget>[
                                      Text(teacher.dateofbirth
                                              .toDate()
                                              .day
                                              .toString() +
                                          ' / ' +
                                          teacher.dateofbirth
                                              .toDate()
                                              .month
                                              .toString() +
                                          ' / ' +
                                          teacher.dateofbirth
                                              .toDate()
                                              .year
                                              .toString()),
                                      Text("DOB")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[Text("_________")],
                                  ),
                                ),
                                Expanded(
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    teacher.imageurl),
                                fit: BoxFit.cover)),
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
                          title: Text("Email"),
                          subtitle: Text(teacher.email),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(teacher.mobileno),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Optional Number"),
                          subtitle: Text(teacher.optionalno),
                          leading: Icon(Icons.call),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle: Text(teacher.address),
                          leading: Icon(Icons.confirmation_number),
                        ),
                        ListTile(
                          title: Text("Aadhar Number"),
                          subtitle: Text(teacher.aadhar),
                          leading: Icon(Icons.confirmation_number),
                        ),
                        ListTile(
                          title: Text("Batch Timing"),
                          subtitle: Text(teacher.timing),
                          leading: Icon(Icons.person),
                        ),
                        ListTile(
                          title: Text("Salary"),
                          subtitle: Text(teacher.salary),
                          leading: Icon(Icons.monetization_on),
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
            )
          ],
        ),
      ),
    );
  }
}

//--------------------------------------------------    Date Picker -------------------------------

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
          child: Container(
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
          child: Container(
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
