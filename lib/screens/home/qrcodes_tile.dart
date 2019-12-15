import 'package:acctendance/models/qrcode.dart';
//import 'package:acctendance/services/database.dart';
//import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class QRCodesTile extends StatelessWidget {
  final QRcode qrcode;
  QRCodesTile({this.qrcode});

  @override
  Widget build(BuildContext context) {
    //final qrcodes = Provider.of<QRcode>(context);

    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Card(
        child: ListTile(
          title: Text('${qrcode.qrcodedata}'),
        ),
      ),
    );
  }
}
