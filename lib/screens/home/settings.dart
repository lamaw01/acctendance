import 'package:flutter/material.dart';
import 'package:acctendance/screens/home/settingsform.dart';

class SettingsPage extends StatefulWidget {
  
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: SettingsForm(),
    );
  }
  
}

