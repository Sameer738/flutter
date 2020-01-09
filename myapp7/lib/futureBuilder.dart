import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp7/question.dart';

class FutureBuilderDemo extends StatefulWidget {
  @override
  _FutureBuilderDemoState createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  String url = 'http://static.cricinfo.com/rss/livescores.xml';
  String st;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: url != null
              ? http.get(url).then((response) => response.body)
              : null,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Input a URL to start');
              case ConnectionState.waiting:
                return new Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return new Text('Active');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  st = snapshot.data.toString();
                    fetchxml();

                  return ListView(
                    children: <Widget>[
                      Text(snapshot.data),
                    ],
                  );
                }
                break;
              default:
            }
          },
        ),
      ),
    );
  }

  void fetchxml() async {
    List<Question> questions = new List();

    String link = "https://raw.githubusercontent.com/chetan2469/ccc_practice/master/data.json";

    final response = await http.get(link);
    if (response.statusCode == 200) {
      questions = (json.decode(response.body) as List)
          .map((data) => new Question.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load');
    }

    print('----------' + questions.length.toString());
    for (var item in questions) {
      print(item.question);
    }
  }
}
