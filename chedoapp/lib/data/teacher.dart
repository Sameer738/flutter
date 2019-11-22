import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String name,
      aadhar,
      address,
      mobileno,
      optionalno,
      education,
      designation,
      course,
      salary,
      timing,
      email,
      imageurl;
  final bool status;
  Timestamp dateofbirth,addDate;

  final DocumentReference reference;

  Teacher.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        address = map['address'],
        mobileno = map['mobileno'],
        optionalno = map['optionalno'],
        education = map['education'],
        designation = map['designation'],
        course = map['course'],
        salary = map['salary'],
        dateofbirth = map['dateofbirth'],
        imageurl = map['imageurl'],
        status = map['status'],
        aadhar = map['aadharNo'],
        email = map['email'],
        addDate=map['addDate'],
        timing = map['timing'];

  Teacher.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
