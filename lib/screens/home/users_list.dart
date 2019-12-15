import 'package:acctendance/models/user.dart';
import 'package:acctendance/screens/home/users_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<User>(context) ?? [];
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