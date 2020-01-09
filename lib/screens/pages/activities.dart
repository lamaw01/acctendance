import 'package:acctendance/screens/home/qrcodes_list.dart';
import 'package:flutter/material.dart';

class ActivitiesPage extends StatefulWidget {
  
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Activities'),
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
        body: QRcodeList(),
    );
  }
}

