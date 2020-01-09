import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String _markdowndata = '''
# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading
hello
''';

class Markup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Markup();
  }
}

class _Markup extends State<Markup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Scrollbar(child: Markdown(data: _markdowndata))),
    );
  }
}
