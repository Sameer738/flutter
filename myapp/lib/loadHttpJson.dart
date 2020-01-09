import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';

class JsonParsor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JsonParsor();
  }
}

class _JsonParsor extends State<JsonParsor> {
  String str, jstr;
  List<Question> q = new List();

  void initState() {
    super.initState();
    str = "";
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  Future loadQuestion() async {
    q = await getQuestions();
    print(q.length);
  }

  static const String url = "https://raw.githubusercontent.com/Sameer738/flutter/master/abc.txt?token=AMY4S2QAMUVRENWI4PTFKPC54EIEI";

  static Future<List<Question>> getQuestions() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Question> list = parseQuestions(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Question> parseQuestions(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Question>((json) => Question.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
              onTap: () {
                loadQuestion();
              },
              child: Container(
                  margin: EdgeInsets.all(20), child: Icon(Icons.refresh))),
          InkWell(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.all(20), child: Icon(Icons.save))),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[Text(str)],
        ),
      ),
    );
  }
}

class Question {
  final String question, op1, op2, op3, op4, ans, language;

  Question(
      {this.question,
      this.op1,
      this.op2,
      this.op3,
      this.op4,
      this.ans,
      this.language});
      
  Question.fromJson(Map<String,dynamic>json)
  : question=json['question'],
    op1=json['op1'],
   op2=json['op2'],  
    op3=json['op3'],
     op4=json['op4'],
     ans=json['ans'],
     language=json['language'];


     Map<String,dynamic>toJson() => {
       'ques':question,
       'op1':op1,
       'op2':op2,
       'op3':op3,
       'op4':op4,
       'ans':ans,
       'language':language,
     };
}
