import 'package:acctendance/models/users.dart';
import 'package:flutter/material.dart';

class UsersTile extends StatelessWidget {

  final Users users;
  UsersTile({this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: ListTile(
          leading:Text("${users.course}"),
          title: Text("${users.name}"),
          subtitle: Text('${users.idNumber}'),
          //trailing: Text('${users.course}'),
        ),
      ),
    );
  }
}