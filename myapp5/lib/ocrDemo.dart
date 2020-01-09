import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class OcrDemo extends StatefulWidget {
  @override
  _OcrDemoState createState() => _OcrDemoState();
}

class _OcrDemoState extends State<OcrDemo> {
  File pickedImage;
  bool isImageLoaded = false;
  String ocrText = '';

  Future pickimage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recongnizedText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recongnizedText.processImage(ourImage);

    print(readText.text);

    setState(() {
      ocrText = readText.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.only(top: 20,right: 30,left: 30),
        children: <Widget>[
          isImageLoaded
              ? Center(
                  child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(pickedImage), fit: BoxFit.cover)),
                ))
              : Container(
                  height: 200.0,
                ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Pick An Image '),
            onPressed: pickimage,
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Read Text '),
            onPressed: () {
              readText();
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Center(child: SelectableText(ocrText)),
          )
        ],
      ),
    );
  }
}
