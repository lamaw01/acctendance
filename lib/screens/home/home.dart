import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/pages/profile.dart';
import 'package:acctendance/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:acctendance/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
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
                new Divider(),
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
          title: Text('Acttendance'),
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
        body: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}