//import 'package:classofc/webViewContainer.dart';
import 'package:myapp2/webviewcontainer.dart';
import 'package:flutter/material.dart';

class WebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebView();
  }
}

class _WebView extends State<WebView> {
  String url = 'https://chedo.in';
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Go Now', style: TextStyle(color: Colors.black, fontSize: 25)),
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: TextField(
                controller: urlController,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.blue[900],
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewContainer(url)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
