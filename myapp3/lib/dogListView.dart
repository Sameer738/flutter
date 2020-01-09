import 'package:flutter/material.dart';

import 'dataTypes/dog.dart';

class DogListView extends StatefulWidget {
  final List<Dog> dogs;
  final void Function(int) deleteDog;

  const DogListView(this.dogs, this.deleteDog);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DogListView();
  }
}

class _DogListView extends State<DogListView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
          itemCount: widget.dogs.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
                margin: EdgeInsets.all(1),
                child: InkWell(
                  onTap: () {
                    print(widget.dogs[i].name);
                  },
                  child: ListTile(
                    leading: Text("  "),
                    title: Text(
                      widget.dogs[i].name,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            widget.dogs.removeAt(i);
                            widget.deleteDog(widget.dogs[i].id);
                          });
                        //  Navigator.pop(context);
                          print("deleted");
                        },
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.orange,
                        )),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
