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
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
        ),
        body: QRcodeList(),
    );
  }
}

