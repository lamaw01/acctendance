import 'package:acctendance/models/qrcode.dart';
import 'package:acctendance/screens/home/qrcodes_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QRcodeList extends StatefulWidget {
  @override
  _QRcodeListState createState() => _QRcodeListState();
}

class _QRcodeListState extends State<QRcodeList> {
  @override
  Widget build(BuildContext context) {

    final qrcodes = Provider.of<List<QRcode>>(context) ?? [];

    return ListView.builder(
      itemCount: qrcodes.length,
      itemBuilder: (context, index){
        return  QRCodesTile(qrcode: qrcodes[index]);
      },  
    );
  }
}