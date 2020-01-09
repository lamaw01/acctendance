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
          flexibleSpace: Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color.fromARGB(150, 202, 103, 1),
              Colors.orange[200]
                ])          
              ),        
            ),
          elevation: 0.0,
        ),
        body: SettingsForm(),
    );
  }
  
}

