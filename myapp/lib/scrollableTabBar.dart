import 'package:flutter/material.dart';

void main() => runApp(ScrollableTabBar());

class ScrollableTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollableTabBar();
  }
}

class _ScrollableTabBar extends State<ScrollableTabBar> {
  List<int> l = new List();

  void initState() {
    super.initState();
    for (int i = 1; i < 30; i++) {
      l.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: l.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: l.map<Tab>((int i){
                return Tab(text: i.toString(),);
              }).toList(),
            ),
            title: Text("Tab Example"),
          ),
          body: TabBarView(children: l.map<Widget>((int i){
            return Center(child: Text(i.toString(),style: TextStyle(fontSize: 40),));
          }).toList(),),
        ),
      ),
    );
  }
}
