import 'dart:io';
import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/home/settings.dart';
import 'package:acctendance/screens/pages/activities.dart';
import 'package:acctendance/screens/pages/draw.dart';
import 'package:acctendance/services/auth.dart';
import 'package:acctendance/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:acctendance/services/database.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  File _image;
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
        result = result;
      });
    }catch(e){
      setState(() {
          result = "Unknown Error $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        //print('Path $_image');
      });
    }

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
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.clear),
                  label: Text('Clear'),
                  textColor: Colors.white,
                  onPressed: (){
                    setState(() {
                      _image = null;
                      result = '';
                      error = '';
                    });
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.black26,
                      width: 200.0,
                      height: 200.0,
                      child: (_image!=null) ? Image.file(_image, fit: BoxFit.fill)
                      : null
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        //color: Colors.orange[100],
                        height: 40.0,
                        width: 300.0,
                        child: Text(result,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 16.0)
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                            color: Colors.orange[300],
                            child: Text('Upload', 
                              style: TextStyle(color: Colors.white, fontSize: 18.0)
                            ),
                            onPressed: () async{
                              try{
                                String fileName = basename(_image.path);
                                StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
                                StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
                                // ignore: unused_local_variable
                                StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                                await firebaseStorageRef.getDownloadURL();
                                var imageUrl = await firebaseStorageRef.getDownloadURL() as String;
                                //print('$imageUrl');
                                if(result.isEmpty && imageUrl == null){
                                  error = 'Incomplete data';
                                  setState(() => error);
                                }else if(result.isEmpty && imageUrl != null){
                                  error = 'QRCode empty';
                                  setState(() => error);
                                }
                                else if(result.isNotEmpty && imageUrl == null){
                                  error = 'Empty Signature';
                                  setState(() => error);
                                }else{
                                  if(result != resultold && imageUrl != null){
                                    await _auth.insertQRCodeDataAuth(result, imageUrl);
                                    error = 'Succesfully uploaded';
                                    setState(() => error);
                                    setState(() {
                                      resultold = result;
                                    });
                                  }else if(result == resultold && imageUrl != null){
                                    error = 'Duplicate data';
                                    setState(() => error);
                                  }
                                  else{
                                    error = 'Unkown error';
                                    setState(() => error);
                                  }
                                }
                                //print(result);  
                              }catch(e){
                                //print(e.toString());
                              }                             
                            }
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        RaisedButton(
                          color: Colors.red[300],
                          child: Text('Get Signature', 
                            style: TextStyle(color: Colors.white, fontSize: 18.0)
                          ),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Draw()));
                          },
                        ),
                        SizedBox(height: 5.0),
                        RaisedButton(
                          color: Colors.blue[300],
                          child: Text('Upload Sigature', 
                            style: TextStyle(color: Colors.white, fontSize: 18.0)
                          ),
                          onPressed: (){
                            getImage();
                          },
                        ),
                      ],
                    ),                  
                    SizedBox(height: 5.0),
                    Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
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



  
