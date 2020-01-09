import 'package:flutter/material.dart';

import 'dog.dart';

class DogListView extends StatefulWidget {
  final List<Dog> dogs;
  final void Function(int) deleteDog;
  final void Function(Dog) update;

  const DogListView(this.dogs, this.deleteDog, this.update);

  @override
  State<StatefulWidget> createState() {
    return _DogListView();
  }
}

class _DogListView extends State<DogListView> {
  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dog List')),
      body: Container(
        child: ListView.builder(
          itemCount: widget.dogs.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              margin: EdgeInsets.all(1),
              child: InkWell(
                onTap: (){
                  print(i);
                },
                child: ListTile(
                  leading: Text(" "),
                  title: Text(
                    widget.dogs[i].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        print(i);
                        widget.dogs.removeAt(i);
                        print('hi');
                        widget.deleteDog(widget.dogs[i].id);
                      });
                      print("Deleted ");
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
