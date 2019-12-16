//import 'package:acctendance/models/qrcode.dart';
import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/pages/activities.dart';
import 'package:acctendance/screens/pages/profile.dart';
import 'package:acctendance/services/auth.dart';
//import 'package:acctendance/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:acctendance/services/database.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String result = '';

  Future _scanQR() async {
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch(e){
      if(e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          result ="Camera Access Denied";
        });
      }else{
        setState(() {
          result = "Unknown Error $e";
        });
      }
    } on FormatException{
      setState(() {
        result = "You Pressed the back button before scanning";
      });
    }catch(e){
      setState(() {
          result = "Unknown Error $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Profile'
                  ),
                  trailing: Icon(Icons.person),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Activities'
                  ),
                  trailing: Icon(Icons.person),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ActivitiesPage()));
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Cancel'
                  ),
                  trailing: Icon(Icons.cancel),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              textColor: Colors.white,
              onPressed: () async{
                await _auth.signOut();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Text(result),
                ),
                SizedBox(height: 5.0),
                RaisedButton(
                  color: Colors.orange[400],
                  child: Text('Upload QRcode data', 
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async{
                    await _auth.insertQRCodeDataAuth(result);
                    print(result);
                  }
                ),
              ],
            ),
          ),
        ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          label: Text('Scan'),
          onPressed: _scanQR,
          backgroundColor: Colors.orange[400],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

}



  
