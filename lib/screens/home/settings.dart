//import 'package:acctendance/models/user.dart';
//import 'package:acctendance/services/database.dart';
import 'package:acctendance/shared/constants.dart';
//import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentIdNumber;
  String _currentCourse;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Update Profile',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            validator: (val) => val.isEmpty ? 'Enter Name' : null,
            onChanged: (val) => setState(() => _currentName = val ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Id Number'),
            validator: (val) => val.length != 10 ? 'Enter Id Number' : null,
            onChanged: (val) => setState(() => _currentIdNumber = val ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Course' : null,
            onChanged: (val) => setState(() => _currentCourse = val ),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.pink,
            child: Text('Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentIdNumber);
              print(_currentCourse);
            },
          ),
        ],
      ),
    );
  }
}