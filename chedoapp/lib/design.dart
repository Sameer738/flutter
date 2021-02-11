import 'dart:async';
import 'package:chedoapp/student/addmissionNew.dart';
import 'package:flutter/material.dart';
import 'package:chedoapp/data/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewDesign extends StatefulWidget {
  @override
  _NewDesignState createState() => _NewDesignState();
}

class _NewDesignState extends State<NewDesign> {
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
                        color: Colors.grey[300],
                        height: 160,
                        width: 160,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            padding: EdgeInsets.all(20),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    filteredStudentList[i]
                                                        .imageurl)),
                                          )),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: filteredStudentList[i]
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Colors.red,
                                                    )),
                                                TextSpan(
                                                    text: ' #342562',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200)),
                                                TextSpan(
                                                    text:
                                                        '\nSoftware Eng - Graduate',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                                TextSpan(
                                                    text:
                                                        '\n29 years , 5ft 11in',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                                TextSpan(
                                                    text:
                                                        '\nHindu \t Pune,India',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: EdgeInsets.only(top: 16),
                                              alignment: Alignment.topCenter,
                                              child: Icon(
                                                FontAwesomeIcons.ellipsisH,
                                                size: 25,
                                              )))
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 1,
                            ),

                            //  !!!!!!!!!!!!!!!!     Row
                            Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.redAccent,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.redAccent,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    FontAwesomeIcons.comment,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.redAccent,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.red),
                                          child: Center(
                                              child: Text(
                                            "Send Interest",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 6,
                            ),
                          ],
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
