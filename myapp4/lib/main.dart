import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  TextEditingController textcontroller1 = TextEditingController();
  TextEditingController textcontroller2 = TextEditingController();
  TextEditingController textcontroller3 = TextEditingController();

  static const genderList = <String>['Male', 'Female', 'Other'];

  final List<DropdownMenuItem<String>> _DropdownGender = genderList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  DateTime dob;
  DateTime _fromDay = new DateTime(
      DateTime.now().year - 18,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute);

  TimeOfDay _fromTime = const TimeOfDay(hour: 0, minute: 0);

  String gender = "Male";
  bool validator1 = true,
      validator2 = true,
      validator3 = true,
      togg = false,
      agree = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Form",
            style: TextStyle(fontSize: 25),
          ),
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.account_circle),
          onPressed: () {
            setState(() {
              print("Hello  " + textcontroller1.text);
              print(gender);
              print(togg);
              print(agree);
            });
          },
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: <Widget>[
                TextField(
                  controller: textcontroller1,
                  onChanged: (String str1) {
                    if (str1.length < 3) {
                      setState(() {
                        validator1 = false;
                      });
                    } else {
                      setState(() {
                        validator1 = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText: !validator1
                        ? "Name Should be greater than 3 characters"
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: textcontroller2,
                  onChanged: (String str2) {
                    if (str2.length != 10) {
                      setState(() {
                        validator2 = false;
                      });
                    } else {
                      setState(() {
                        validator2 = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText:
                        !validator2 ? "Number should be of 10 digit" : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Contact No",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textcontroller3,
                  onChanged: (String str3) {
                    if (!(str3.contains("@"))) {
                      setState(() {
                        validator3 = false;
                      });
                    } else {
                      setState(() {
                        validator3 = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText:
                        !validator3 ? "Enter Valid E-mail Address" : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Text("Gender"),
                  trailing: DropdownButton(
                    value: gender,
                    onChanged: (String str) {
                      setState(() {
                        gender = str;
                      });
                    },
                    items: _DropdownGender,
                  ),
                ),
                ListTile(
                  leading: Text("Give Access to mobile data"),
                  trailing: Switch(
                    value: togg,
                    onChanged: (bool value) {
                      setState(() {
                        this.togg = value;
                      });
                    },
                  ),
                ),
                DateTimePicker(
                  labelText: 'Date Time Of Birth Day',
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child:
                          Text("Accept the terms and conditions given above:"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: agree,
                        onChanged: (bool value) {
                          setState(() {
                            this.agree = value;
                          });
                          //
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
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
          child: InputDropdown(
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
          child: InputDropdown(
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

class InputDropdown extends StatelessWidget {
  const InputDropdown({
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
