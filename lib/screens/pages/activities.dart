import 'package:acctendance/models/qrcode.dart';
import 'package:acctendance/screens/home/qrcodes_list.dart';
import 'package:acctendance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatefulWidget {
  
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {

  @override
  Widget build(BuildContext context){
    return StreamProvider<List<QRcode>>.value(
        value: DatabaseService().qr,
        child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Activities'),
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
        ),
        body: QRcodeList(),
      ),
    );
  }
}
