import 'package:flutter/material.dart';
import 'package:myapp/studList.dart';

class AddStud extends StatefulWidget {
  final List l;
  final Function(int) studDel;

  AddStud(this.l, this.studDel);

  @override
  State<StatefulWidget> createState() {
    return _AddStud();
  }
}

class _AddStud extends State<AddStud> {
  TextEditingController nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.blue,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudList(widget.l, widget.studDel)));
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Student List"),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: nameController,
              ),
              leading: Text("name :"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  if (nameController.text.length > 2) {
                    widget.l.add(nameController.text);
                    nameController.text = "";
                  }
                });
              },
              child: Text("OK"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudList(widget.l, widget.studDel)),
                );
              },
              child: Text("data"),
            )
          ],
        ),
      ),
    );
  }
}
