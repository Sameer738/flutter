import 'package:flutter/material.dart';

class FriendList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendList();
  }
}

class _FriendList extends State<FriendList> {
  List<String> l = new List();

  @override
  void initState() {
 
    super.initState();

    l.add("rames");
    l.add("suresh");
    l.add("amit");
    l.add("sameer");
    l.add("djlsa");
    l.add("fsafcsa");
    l.add("trete");

    l.add("rames");
    l.add("suresh");
    l.add("amit");
    l.add("sameer");
    l.add("djlsa");
    l.add("fsafcsa");
    l.add("trete");

    l.add("rames");
    l.add("suresh");
    l.add("amit");
    l.add("sameer");
    l.add("djlsa");
    l.add("fsafcsa");
    l.add("trete");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text(
                l[i],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
