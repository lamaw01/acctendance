import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/home/users_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}



class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<User>(context);
    final int userCount = 1;

    /*users.forEach((users){
      print(users.idNumber);
      print(users.name);
      print(users.course);
    });*/

    return ListView.builder(
      itemCount: userCount,
      itemBuilder: (context, index){
        return  UsersTile(users: users);
      },
    );
  }
}