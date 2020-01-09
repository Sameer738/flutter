import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dog.dart';
import 'dogListView.dart';

class DogAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DogAdd();
  }
}

class _DogAdd extends State<DogAdd> {
  List<Dog> dogList;
  int age = 40;
  String city;
  Future<Database> database;
  Database db;
  TextEditingController nameController = new TextEditingController();
  Random r = new Random();

  void dbref() async {
    database = openDatabase(join(await getDatabasesPath(), 'pet.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    }, version: 1);
    dogList = await dogs();
  }

  Future<void> insertDog(Dog dog) async {
    db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  final String columnId = 'id';

  Future<int> update(Dog dog) async {
    return await db
        .update('dogs', dog.toMap(), where: '$columnId=?', whereArgs: [dog.id]);
  }

  void deleteDog(int id) async{
    db=await database;
    await db.rawDelete('DELETE FROM dogs WHERE id =?',[id]);
    dogList=await dogs();
  }

  void addDog(Dog dog) async {
    await insertDog(dog);
    dogList = await dogs();
  }

  @override
  void initState() {
    super.initState();
    dbref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Add"),
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Icon(Icons.save),
            ),
            onTap: () {
              int rand = r.nextInt(100);
              String name = nameController.text;
              int age = this.age.toInt();
              final dog = Dog(
                id: rand,
                name: name,
                age: age,
              );
              if (name.length > 3) {
                addDog(dog);
                nameController.text = "";
              }
              /* setState(() {
                for(int i=0;i<dogList.length;i++)
                {
                  print(dogList[i].name);
                }
              });
              */
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pets),
                  border: OutlineInputBorder(),
                  hintText: 'Pet name'),
            ),
          ),
          Slider(
            min: 0.0,
            max: 100.0,
            divisions: 100,
            activeColor: Colors.orange,
            label: age.toString(),
            value: age.toDouble(),
            onChanged: (double d) {
              setState(() {
                age = d.toInt();
              });
            },
          ),
          RaisedButton(
            child: Text("Dog List"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DogListView(dogList,deleteDog, update)));
            },
          )
        ],
      ),
    );
  }
}
