import 'package:flutter/material.dart';

class StudList extends StatefulWidget {
  final List l;
  final Function(int) studDel;

  StudList(this.l, this.studDel);

  @override
  State<StatefulWidget> createState() {
    return _StudList();
  }
}

class _StudList extends State<StudList> {
  List<String> l = new List();

  TextEditingController nameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.l.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onLongPress: () {
                print("Pressed" + i.toString());
                setState(() {
                  widget.studDel(i);
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  widget.l[i],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
