import 'package:acctendance/models/users.dart';
import 'package:acctendance/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:acctendance/services/database.dart';
import 'package:provider/provider.dart';
import 'package:acctendance/screens/home/users_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Users>>.value(
        value: DatabaseService().users,
        child: Scaffold(
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
        body: UserList(),
      ),
    );
  }
}