
import 'package:flutter/material.dart';
import 'package:myapp3/webViewContainer.dart';

class WebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebView();
  }
}

class _WebView extends State<WebView> {
  String url = 'https://chedo.in';
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      urlController.text = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: TextField(
                
                controller: urlController,
                onChanged: (String s){
                  setState(() {
                    url=s; 
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
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
        )));
  }
}
