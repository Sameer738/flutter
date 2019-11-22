import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String coursename, fees, syllabus,imageurl,teachername;
  int duration;

  final DocumentReference reference;

  Course.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['coursename'] != null),
        assert(map['fees'] != null),
        assert(map['syllabus'] != null),
        assert(map['imageurl'] != null),
        assert(map['teachername'] != null),

        coursename = map['coursename'],
        duration = map['duration'],
        fees = map['fees'],
        imageurl=map['imageurl'],
        teachername=map['teachername'],
        syllabus = map['syllabus'];

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
