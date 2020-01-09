import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontsDemo extends StatefulWidget {
  @override
  _GoogleFontsDemoState createState() => _GoogleFontsDemoState();
}

class _GoogleFontsDemoState extends State<GoogleFontsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        child: Text(
          'Font',
          style: GoogleFonts.rockSalt(fontSize: 30),
        ),
      )),
    );
  }
}
