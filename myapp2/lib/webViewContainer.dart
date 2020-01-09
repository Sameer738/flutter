import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);

  @override
  State<StatefulWidget> createState() {
    return _WebViewContainer(this.url);
  }
}

class _WebViewContainer extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainer(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _url))
        ],
      ),
    );
  }
}
