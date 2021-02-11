import 'package:flutter/material.dart';

class ListWheelsDemo extends StatefulWidget {
  @override
  _ListWheelsDemoState createState() => _ListWheelsDemoState();
}

class _ListWheelsDemoState extends State<ListWheelsDemo> {
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  List<String> stud = new List();

  List<Widget> studentName = new List();
  

  List<Widget> list = [
    ListTile(
      leading: Icon(Icons.add_a_photo),
      title: Text('Add Photo'),
      subtitle: Text("For Profile "),
      trailing: Icon(Icons.arrow_right),
    ),

    ListTile(
      leading: Icon(Icons.delete_forever),
      title: Text('Delete photo'),
      subtitle: Text("not in use "),
      trailing: Icon(Icons.arrow_right),
    ),
    ListTile(
      leading: Icon(Icons.camera_enhance),
      title: Text('Add photo from camera'),
      subtitle: Text("not in use "),
      trailing: Icon(Icons.arrow_right),
    ),


    ListTile(
      leading: Icon(Icons.settings),
      title: Text('Setting'),
      subtitle: Text(" user sertting "),
      trailing: Icon(Icons.arrow_right),
    ),

    ListTile(
      leading: Icon(Icons.notifications),
      title: Text('Notification'),
      subtitle: Text("user notification "),
      trailing: Icon(Icons.arrow_right),
    ),


    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
      subtitle: Text("india map "),
      trailing: Icon(Icons.arrow_right),
    ),

    ListTile(
      leading: Icon(Icons.games),
      title: Text('Games'),
      subtitle: Text("play Game"),
      trailing: Icon(Icons.arrow_right),
    ),

    ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text("See Email"),
      trailing: Icon(Icons.arrow_right),
    ),

    ListTile(
      leading: Icon(Icons.alarm),
      title: Text('Alarm'),
      subtitle: Text("For Profile "),
      trailing: Icon(Icons.arrow_right),
    ),
    
     ListTile(
      leading: Icon(Icons.android),
      title: Text('Android'),
      subtitle: Text("For Profile "),
      trailing: Icon(Icons.arrow_right),
    ),
    
  ];

  @override
  void initState() {
    super.initState();
    stud = ["Tejas","Shumbham","Chinni","Sagar","Sam"];

    for (var item in stud) {
      studentName.add(Container(child: Text(item.toString()),));      
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Wheels Demo"),
      ),
      body: ListWheelScrollView(
        controller: _controller,
        offAxisFraction: -.4,
        itemExtent: 80,
        useMagnifier: true,
        magnification: 0.2,
        diameterRatio: 2,
        physics: FixedExtentScrollPhysics(),
        children: list,
      ),
    );
  }
}