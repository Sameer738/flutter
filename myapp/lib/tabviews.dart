import 'package:flutter/material.dart';

void main() => runApp(TabViews());

class TabViews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabViews();
  }
}

class _TabViews extends State<TabViews> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: "Admin",
                ),
                Tab(
                  icon: Icon(Icons.mode_edit),
                  text: "Data",
                ),
              ],
            ),
            title: Text("Tab Example"),
          ),

          body: TabBarView(
            children:[
              Container(margin: EdgeInsets.all(30),alignment: Alignment.center, child: Text("sddvsvsdvdsvv"),),
              Container(margin: EdgeInsets.all(30),alignment: Alignment.center,child: Text("sdfgsgsfg"),),
              Container(margin: EdgeInsets.all(30),alignment: Alignment.center,child: Text("asfafjsaf"),),
            ],
          ),
        ),
      ),
    );
  }
}
