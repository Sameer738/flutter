import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  String name = '';
  String fat = '';

  TextEditingController namefieldController = TextEditingController();
  TextEditingController fatfieldController = TextEditingController();
  TextEditingController proteinfieldController = TextEditingController();
  TextEditingController carbonfieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: ListView(
            children: [
              TextField(
                controller: namefieldController,
                onChanged: (String str1) {
                  setState(() {
                    name = str1;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Name",
                ),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: fatfieldController,
                onChanged: (String str1) {
                  setState(() {
                    fat = str1;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "fat",
                ),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: carbonfieldController,
                onChanged: (String str1) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "carbon",
                ),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: proteinfieldController,
                onChanged: (String str1) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Protein",
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                child: Text(name),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(fat),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
