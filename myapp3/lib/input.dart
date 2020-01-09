import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Input();
  }
}

class _Input extends State<Input> {
  TextEditingController textController = TextEditingController();

  static const genderList = <String>['Male', 'Female', 'Other'];
  DateTime dob,
      _fromDay = new DateTime(DateTime.now().year - 18, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  TimeOfDay _fromTime = const TimeOfDay(hour: 0, minute: 00);

  File _imageFile;

  final List<DropdownMenuItem<String>> _dropDownGender = genderList
      .map(
        (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
      )
      .toList();

  String gender = "Male";
  bool togg = false, agreement = false, validater = true;

  Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() => this._imageFile = imageFile);
  }

  Future<Null> _pickImageFromCamera() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => this._imageFile = imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Input Operations "),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera_alt),
              tooltip: 'photo',
              onPressed: () async => await _pickImageFromCamera(),
            ),
            IconButton(
              icon: const Icon(Icons.camera),
              tooltip: 'select',
              onPressed: () async => await _pickImageFromGallery(),
            )
          ],
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          child: Text("click"),
          onPressed: () {
            setState(() {
              print("Hello " + textController.text);
              print("Gender " + gender);
              print("Agree " + togg.toString());
              print("Checkbox " + agreement.toString());
            });
          },
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 400,
                  child: this._imageFile == null
                      ? Image.asset('assets/women91.jpg')
                      : Image.file(
                          this._imageFile,
                        ),
                ),
                SizedBox(height: 20.0),
                TextField(
                    controller: textController,
                    //  keyboardType: TextInputType.number,
                    onChanged: (String str) {
                      if (str.length < 3) {
                        setState(() {
                          validater = false;
                        });
                      } else {
                        setState(() {
                          validater = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      errorText: !validater
                          ? 'Name should greater than 3 characters'
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Name ',
                    )),
                SizedBox(height: 20.0),
                ListTile(
                  leading: Text("Gender"),
                  trailing: DropdownButton(
                    onChanged: ((String str) {
                      setState(() {
                        gender = str;
                      });
                    }),
                    items: _dropDownGender,
                    value: gender,
                  ),
                ),
                SizedBox(height: 20.0),
                ListTile(
                  leading: Text("Switch "),
                  trailing: Switch(
                    onChanged: (bool value) {
                      setState(() => this.togg = value);
                    },
                    value: this.togg,
                  ),
                ),
                SizedBox(height: 20.0),
                ListTile(
                  leading: Text("Aggreed On Terms"),
                  trailing: Checkbox(
                    value: agreement,
                    onChanged: (bool value) {
                      setState(() {
                        agreement = value;
                      });
                    },
                  ),
                ),
                _DateTimePicker(
                  labelText: 'Date Time Of Birth Day*',
                  selectedDate: _fromDay,
                  selectedTime: _fromTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _fromDay = date;
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _fromTime = time;
                      print(time);
                    });
                  },
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2002),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
