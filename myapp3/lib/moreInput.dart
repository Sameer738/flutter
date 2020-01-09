
import 'package:flutter/material.dart';
import 'SecondPage.dart';
import 'moreInput.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class MoreInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoreInput();
  }
}

class _MoreInput extends State<MoreInput> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double value = 40;
  String city;

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
        title: Text("MoreInput"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: <Widget>[
              ExpansionTile(
                title: const Text('Agreement'),
                backgroundColor:
                    Theme.of(context).accentColor.withOpacity(0.025),
                children: const <Widget>[
                  ListTile(
                      title: Text(
                          'Lorem Ipsum is slechts een proeftekst uit het drukkerij- en zetterijwezen. Lorem Ipsum is de standaard proeftekst in deze bedrijfstak sinds de 16e eeuw, toen een onbekende drukker een zethaak met letters nam en ze door elkaar')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text('Modal Sheet'),
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              'The standard chunk of Lorem Ipsum used since the 1500s by H. Rackham.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      });
                },
              ),
              RaisedButton(
                child: const Text('ALERT'),
                onPressed: () {
                  showDemoDialog<DialogDemoAction>(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                        'Discart Draft',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.cancel);
                          },
                        ),
                        FlatButton(
                          child: const Text('DISCARD'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              RaisedButton(
                child: const Text('ALERT WITH TITLE'),
                onPressed: () {
                  showDemoDialog<DialogDemoAction>(
                    context: context,
                    child: AlertDialog(
                      title: const Text('Use Google\'s location service?'),
                      content: Text(
                        'This app want your permission to use location',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('DISAGREE'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.disagree);
                          },
                        ),
                        FlatButton(
                          child: const Text('AGREE'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.agree);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              RaisedButton(
                child: const Text('SIMPLE'),
                onPressed: () {
                  showDemoDialog<String>(
                    context: context,
                    child: SimpleDialog(
                      title: const Text('Set backup account'),
                      children: <Widget>[
                        DialogDemoItem(
                          icon: Icons.account_circle,
                          text: 'username@gmail.com',
                          onPressed: () {
                            Navigator.pop(context, 'username@gmail.com');
                          },
                        ),
                        DialogDemoItem(
                          icon: Icons.account_circle,
                          text: 'user02@gmail.com',
                          onPressed: () {
                            Navigator.pop(context, 'user02@gmail.com');
                          },
                        ),
                        DialogDemoItem(
                          icon: Icons.add_circle,
                          text: 'add account',
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                min: 0.0,
                max: 100.0,
                divisions: 5,
                activeColor: Colors.orange,
                label: 'Select Sound',
                value: value,
                onChanged: (double d) {
                  print(d);
                  setState(() {
                    value = d;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text('An item with a sectioned menu'),
                trailing: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  onSelected: (String s) {
                    print(s);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Preview',
                          child: ListTile(
                            leading: Icon(Icons.visibility),
                            title: Text('Preview'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Share',
                          child: ListTile(
                            leading: Icon(Icons.person_add),
                            title: Text('Share'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Get Link',
                          child: ListTile(
                            leading: Icon(Icons.link),
                            title: Text('Get link'),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'Remove',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Remove'),
                          ),
                        ),
                      ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogDemoItem extends StatelessWidget {
  const DialogDemoItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
