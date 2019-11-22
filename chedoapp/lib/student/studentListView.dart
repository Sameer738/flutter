import 'dart:async';
import 'package:chedoapp/student/StudentShowDetails.dart';
import 'package:chedoapp/student/addmissionNew.dart';
import 'package:chedoapp/student/studentEditDetail.dart';
import 'package:flutter/material.dart';
import 'package:chedoapp/data/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class StudentListView extends StatefulWidget {
  @override
  _StudentListViewState createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  final Debouncer debouncer = Debouncer(50);
  List<Record> studentList = new List();
  List<Record> filteredStudentList = new List();
  bool processing = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String searchStr = "";
  String searchBy = 'Name';
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("");

  static const searchByItems = <String>[
    'Name',
    'Course',
    'Status',
    'Batch Time',
  ];

  sortBy() {
    if (searchBy == 'Name') {
      filteredStudentList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    } else if (searchBy == 'Course') {
      filteredStudentList.sort((a, b) {
        return a.coursename.toLowerCase().compareTo(b.coursename.toLowerCase());
      });
    } else if (searchBy == 'Status') {
      filteredStudentList.sort((a, b) {
        return a.status
            .toString()
            .toLowerCase()
            .compareTo(b.status.toString().toLowerCase());
      });
    } else if (searchBy == 'Batch Time') {
      filteredStudentList.sort((a, b) {
        return a.batchtime.toLowerCase().compareTo(b.batchtime.toLowerCase());
      });
    }
  }

  final List<DropdownMenuItem<String>> _dropDownMenuItems = searchByItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewAddmission()));
        },
      ),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(192, 106, 99, 245),
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              icon: actionIcon,
              onPressed: () {
                //print(searchStr);
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close);
                    this.appBarTitle = TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (String searchKey) {
                        debouncer.run(() {
                          setState(() {
                            searchStr = searchKey;

                            filteredStudentList = studentList
                                .where((str) => (str.name
                                        .toLowerCase()
                                        .contains(searchKey.toLowerCase()) ||
                                    str.coursename
                                        .toLowerCase()
                                        .contains(searchKey.toLowerCase())))
                                .toList();
                          });
                        });
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.white10,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Search text...",
                          hintStyle: TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text('');
                  }
                });
              },
            ),
            Container(width: 20),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButton(
                hint: Text('sort by'),
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.white,
                ),
                value: searchBy,
                style: TextStyle(color: Colors.black),
                onChanged: ((String str) {
                  setState(() {
                    searchBy = str;
                  });
                  sortBy();
                }),
                items: _dropDownMenuItems,
              ),
            )
          ]),
      body: Center(
        child: processing
            ? CircularProgressIndicator()
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("no more data");
                    } else if (mode == LoadStatus.loading) {
                      body = CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  itemCount: filteredStudentList.length,
                  itemBuilder: (BuildContext cotext, int i) {
                    return Padding(
                      key: ValueKey(filteredStudentList[i].name),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 1),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 5),
                        margin: EdgeInsets.only(
                            top: 5, bottom: 1, left: 5, right: 5),
                        //color: Colors.grey[200],
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 2,
                                color: Colors.black45.withOpacity(0.3)),
                            color: Colors.white.withOpacity(0.2)),
                        //color: Colors.grey[200],,
                        child: Container(
                          height: 80,
                          child: ListTile(
                              leading: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new CachedNetworkImageProvider(
                                        filteredStudentList[i].imageurl),
                                  ),
                                ),
                              ),
                              title: Text(
                                filteredStudentList[i].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Chip(
                                    backgroundColor:
                                        Colors.greenAccent.withOpacity(0.4),
                                    elevation: 6,
                                    label:
                                        Text(filteredStudentList[i].coursename),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Chip(
                                    elevation: 6,
                                    backgroundColor: filteredStudentList[i]
                                                .batchtime
                                                .toString()
                                                .length <
                                            12
                                        ? Colors.greenAccent
                                        : Colors.red[200],
                                    label: filteredStudentList[i]
                                                .batchtime
                                                .toString()
                                                .length <
                                            12
                                        ? Text(filteredStudentList[i]
                                            .batchtime
                                            .toString())
                                        : Text('dynamic'),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentShowDetails(
                                                  filteredStudentList[i])));
                                });
                              },
                              trailing: Column(
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StudentDetails(
                                                          filteredStudentList[
                                                              i])));
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      )),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.donut_small,
                                      color: filteredStudentList[i].status
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  void _onRefresh() async {
    print("____________________onRefreshing______________________");
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    await fetchStudentData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("____________________onLoading______________________");
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //await fetchStudentData();
    _refreshController.loadComplete();
  }

  fetchStudentData() async {
    setState(() {
      processing = true;
      filteredStudentList.clear();
    });
    final QuerySnapshot result =
        await Firestore.instance.collection('admission').getDocuments();

    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((data) {
      final record = Record.fromSnapshot(data);
      studentList.add(record);
      filteredStudentList.add(record);
    });

    setState(() {
      processing = false;
    });

    filteredStudentList.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }
}

class Debouncer {
  final int milliSeconds;
  VoidCallback action;
  Timer _timer;

  Debouncer(this.milliSeconds);

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }
}
