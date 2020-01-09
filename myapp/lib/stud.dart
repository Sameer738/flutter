import 'package:flutter/material.dart';

class Stud extends StatefulWidget {
  double z;

  @override
  State<StatefulWidget> createState() {
    return _Stud();
  }
}

class _Stud extends State<Stud> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController m1Controller = new TextEditingController();
  TextEditingController m2Controller = new TextEditingController();
  TextEditingController m3Controller = new TextEditingController();
  double p, m1, m2, m3, t, a = 20.00, maths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: nameController,
              ),
              leading: Text("Name :"),
            ),
            ListTile(
                leading: Text("Age"),
                title: Slider(
                  min: 10,
                  max: 40,
                  value: a,
                  onChanged: (double d) {
                    setState(() {
                      a = d;
                    });
                  },
                )),
            ListTile(
              leading: Text("M1"),
              title: TextField(
                controller: m1Controller,
              ),
            ),
            ListTile(
              leading: Text("M2"),
              title: TextField(
                controller: m2Controller,
              ),
            ),
            ListTile(
              leading: Text("M3"),
              title: TextField(
                controller: m3Controller,
              ),
            ),
            RaisedButton(
              onPressed: () {
                print(
                  nameController.text,
                );
                print(
                  ageController.text,
                );
                print(
                  m1Controller.text,
                );
                print(
                  m2Controller.text,
                );
                print(
                  m3Controller.text,
                );

                m1 = double.parse(m1Controller.text);
                m2 = double.parse(m2Controller.text);
                m3 = double.parse(m3Controller.text);
                t = m1 + m2 + m3;
                p = (t / 3);
                print(t);
                print(p);
              },
              child: Text("OK"),
            ),
            Slider(
              min: 10,
              max: 50,
              value: a,
              onChanged: (double d) {
                setState(() {
                  a = d;
                });
              },
            ),
            Text("NAME  :  " + nameController.text,
                style: TextStyle(
                  fontSize: 30,
                )),
            Text("AGE  :  " + ageController.text,
                style: TextStyle(fontSize: 30)),
            Text("MARK 1  :  " + m1.toString(), style: TextStyle(fontSize: 30)),
            Text("MARK 2  :  " + m2.toString(), style: TextStyle(fontSize: 30)),
            Text("MARK 3  :  " + m3.toString(), style: TextStyle(fontSize: 30)),
            Text("TOTAL :  " + t.toString(), style: TextStyle(fontSize: 30)),
            Text("PERCENTAGE  :  " + p.toString(),
                style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
