import 'package:acctendance/models/user.dart';
import 'package:acctendance/services/database.dart';
import 'package:acctendance/shared/constants.dart';
import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentIdNumber;
  String _currentCourse;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update Profile',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.idNumber,
                  decoration: textInputDecoration.copyWith(hintText: 'Id Number'),
                  validator: (val) => val.length != 10 ? 'Enter Id Number' : null,
                  onChanged: (val) => setState(() => _currentIdNumber = val ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Enter Name' : null,
                  onChanged: (val) => setState(() => _currentName = val ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.course,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Enter Course' : null,
                  onChanged: (val) => setState(() => _currentCourse = val ),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink,
                  child: Text('Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentIdNumber ?? userData.idNumber,
                        _currentName ?? userData.name, 
                        _currentCourse ?? userData.course)
                      ;
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
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