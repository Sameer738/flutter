import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dataTypes/dog.dart';
import 'dogListView.dart';
import 'drawerApp.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Dog> dogList;
  int age = 40;
  String city;
  Future<Database> database;
  Database db;
  TextEditingController nameController = new TextEditingController();
  Random r = new Random();

  // Open the database and store the reference.
  void dbref() async {
    database = openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'pet.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
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

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
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
    return await db.update('dogs', dog.toMap(),
        where: '$columnId = ?', whereArgs: [dog.id]);
  }

  void deleteDog(int id) async {
    db = await database;
    await db.rawDelete('DELETE FROM dogs WHERE id = ?', [id]);
    dogList = await dogs();
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

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        print('You selected: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          InkWell(
            child:
                Container(margin: EdgeInsets.all(20), child: Icon(Icons.save)),
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
            },
          )
        ],
      ),
      drawer: DrawerApp(),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pets),
                  border: OutlineInputBorder(),
                  hintText: 'Pet Name'),
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
            child: Text(
              "Dog List",
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DogListView(dogList, deleteDog)));
            },
          )
        ],
      ),
    );
  }
}
