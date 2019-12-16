import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/home/settings.dart';
import 'package:acctendance/screens/pages/activities.dart';
import 'package:acctendance/services/auth.dart';
import 'package:acctendance/shared/loading.dart';
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

  String result = '';
  String resultold = '';
  String error = '';

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

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return StreamProvider<List<UserData>>.value(
            value: DatabaseService().users,
            child: Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(userData.name),
                      accountEmail: Text(userData.idNumber),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(userData.course),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Activities'
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: (){
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ActivitiesPage()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Settings'
                      ),
                      trailing: Icon(Icons.settings),
                      onTap: (){
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Logout'
                      ),
                      trailing: Icon(Icons.cancel),
                      onTap: () async{
                        await _auth.signOut();
                      }
                    ),
                  ],
                ),
              ),
            backgroundColor: Colors.orange[50],
            appBar: AppBar(       
              title: Text('Home'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(result),
                    ),
                    SizedBox(height: 5.0),
                    RaisedButton(
                      color: Colors.brown[300],
                      child: Text('Upload QRCode', 
                        style: TextStyle(color: Colors.white, fontSize: 18.0)
                      ),
                      onPressed: () async{
                        if(result.isEmpty){
                          error = 'QRCode is empty';
                          setState(() => error);
                        }else{
                          if(result != resultold){
                            await _auth.insertQRCodeDataAuth(result);
                            error = 'Succesfully uploaded';
                            setState(() => error);
                            setState(() {
                              resultold = result;
                            });
                          }else{
                            error = 'Duplicate data';
                            setState(() => error);
                          }
                        }
                        //print(result);   
                      }
                    ),
                    SizedBox(height: 10.0),
                    Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.camera_alt),
              label: Text('Scan', 
                style: TextStyle(color: Colors.white, fontSize: 18.0)
              ),
              onPressed: _scanQR,
              backgroundColor: Colors.green[300]
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }

}



  
