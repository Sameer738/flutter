
import 'package:flutter/material.dart';
import 'package:myapp3/profile.dart';

import 'dataTypes/student.dart';

void main() => runApp(Profiles());

class Profiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profiles();
  }
}

class _Profiles extends State<Profiles> {
  String str = "Hello Android";

  List<Student> studs = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    studs.add(new Student("Chedo", "assets/men2.jpg", 12));
    studs.add(new Student("Saloni", "assets/women19.jpg", 24));
    studs.add(new Student("Rahul", "assets/men12.jpg", 22));
    studs.add(new Student("Sanjana", "assets/women90.jpg", 14));
    studs.add(new Student("Preeti", "assets/women11.jpg", 19));
    studs.add(new Student("Rakshanda", "assets/women91.jpg", 16));
    studs.add(new Student("Akshaya", "assets/women56.jpg", 20));
    studs.add(new Student("Geeta", "assets/women11.jpg", 21));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: studs.length,
          itemBuilder: (BuildContext contxt, int i) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            i, studs)));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(studs[i].imag),
                  ),
                  title: Text(
                    studs[i].name,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



/*

Container(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(studs[i].imag),
                  ),
                  title: Text(
                    studs[i].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: FloatingActionButton(
                    onPressed: (){},
                    child: Text(studs[i].age.toString()),
                    backgroundColor: studs[i].age<18?Colors.green:Colors.orange,
                  ),
                ),
              )

*/
