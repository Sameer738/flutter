import 'package:flutter/material.dart';

class AddRecipesPage extends StatefulWidget {
  @override
  _AddRecipesPageState createState() => _AddRecipesPageState();
}

class _AddRecipesPageState extends State<AddRecipesPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  String name;
  int grams, carbon, fats, protiens, calories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Recipes'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Grams'),
                      ),
                      Expanded(
                        child: Container(
                          height: 80,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 45,
                          child: TextField(
                              controller: gramsController,
                              onChanged: (String val) {
                                grams = int.parse(val);
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                        ),
                      )
                    ],
                  ),
                  ListTile(
                      leading: Text(' Grams'),
                      title: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: TextField(
                            controller: gramsController,
                            onChanged: (String val) {
                              grams = int.parse(val);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                  ListTile(
                      leading: Text('Carbon'),
                      title: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: TextField(
                            controller: carbonController,
                            onChanged: (String val) {
                              carbon = int.parse(val);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                  ListTile(
                      leading: Text('Fat'),
                      title: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: TextField(
                            controller: fatsController,
                            onChanged: (String val) {
                              fats = int.parse(val);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                  ListTile(
                      leading: Text('Protiens'),
                      title: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: TextField(
                            controller: protiensController,
                            onChanged: (String val) {
                              protiens = int.parse(val);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                  ListTile(
                      leading: Text('Calories'),
                      title: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: TextField(
                            controller: caloriesController,
                            onChanged: (String val) {
                              calories = int.parse(val);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(name);
        },
      ),
    );
  }
}
