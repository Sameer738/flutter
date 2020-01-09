import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class RiveDemo extends StatefulWidget {
  @override
  _RiveDemoState createState() => _RiveDemoState();
}

class _RiveDemoState extends State<RiveDemo> {
  String anim = "toHappy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          setState(() {
            if (anim == "toHappy") {
              anim = "toSad";
            } else {
              anim = "toHappy";
            }
          });
        },
        child: Container(
          height: 300,
          child: FlareActor("assets/Smiley.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: anim),
        ),
      ),
    );
  }
}
