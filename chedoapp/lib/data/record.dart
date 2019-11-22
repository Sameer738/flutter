import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name,
      address,
      mobileno,
      optionalno,
      aadharno,
      coursename,
      batchtime,
      imageurl,
      email;
  final bool status;
  Timestamp dateofbirth,addDate;

  
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['address'] != null),
        assert(map['mobileNo'] != null),
        assert(map['aadharNo'] != null),
        assert(map['courseName'] != null),
        assert(map['batchTime'] != null),
        assert(map['imageUrl'] != null),
        name = map['name'],
        address = map['address'],
        mobileno = map['mobileNo'],
        optionalno = map['optNumber'],
        aadharno = map['aadharNo'],
        coursename = map['courseName'],
        batchtime = map['batchTime'],
        dateofbirth = map['dateOfBirth'],
        imageurl = map['imageUrl'],
        addDate=map['addDate'],
        status=map['status'],
        email=map['email'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
      
}
