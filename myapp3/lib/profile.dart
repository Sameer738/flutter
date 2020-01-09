import 'package:flutter/material.dart';

import 'dataTypes/student.dart';

class Profile extends StatefulWidget {
  final int i;
  final List<Student> studs;
  Profile(this.i, this.studs);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  TextEditingController nameController, ageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController =
        new TextEditingController(text: widget.studs[widget.i].name.toString());
    ageController =
        new TextEditingController(text: widget.studs[widget.i].age.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            child: Text("Save"),
            onPressed: () {
              widget.studs[widget.i].setName(nameController.text);
              widget.studs[widget.i].setAge(int.parse(ageController.text));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(widget.studs[widget.i].imag),
          Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                controller: nameController,
              )),
          Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                controller: ageController,
              )),
        ],
      ),
    );
  }
}
