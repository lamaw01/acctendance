import 'package:acctendance/models/user.dart';
import 'package:acctendance/services/database.dart';
import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersTile extends StatelessWidget {

  final User users;
  UsersTile({this.users});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);



    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Card(
                  child: ListTile(
                    leading:CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.brown[400],
                      child: Text("${userData.course}"),
                    ),
                    title: Text("${userData.name}"),
                    subtitle: Text('${userData.idNumber}'),
                    //trailing: Text('${users.course}'),
                  ),
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