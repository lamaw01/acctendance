import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/home/settings.dart';
import 'package:acctendance/screens/home/users_list.dart';
import 'package:acctendance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _showSettingsPanel(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm(),
      );
    });
  }
  
  @override
  Widget build(BuildContext context){
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              textColor: Colors.white,
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
