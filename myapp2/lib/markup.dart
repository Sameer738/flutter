import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

final String markup='''## CatPhotoApp

<main>

Click here to view more [cat photos](#).

<div>

Things cats love:

*   cat nip
*   laser pointers
*   lasagna

Top 3 things cats hate:

1.  flea treatment
2.  thunder
3.  other cats

</div>

<form action="/submit-cat-photo"><label><input type="radio" name="indoor-outdoor" checked=""> Indoor</label> <label><input type="radio" name="indoor-outdoor"> Outdoor</label>  
<label><input type="checkbox" name="personality" checked=""> Loving</label> <label><input type="checkbox" name="personality"> Lazy</label> <label><input type="checkbox" name="personality"> Energetic</label>  
<input type="text" placeholder="cat photo URL" required=""> <button type="submit">Submit</button></form>

</main>''';

class MarkUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MarkUp();
  }

}
class _MarkUp extends State<MarkUp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scrollbar(child: Markdown(data: markup),),
      ),
    );
  }

}