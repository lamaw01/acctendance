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

  String _currentIdNumber;
  String _currentName;
  String _currentCourse;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return SingleChildScrollView (
              scrollDirection: Axis.vertical,
              child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.idNumber,
                      decoration: textInputDecoration.copyWith(hintText: 'Id number').copyWith(labelText: 'Id number'),
                      validator: (val) => val.length != 10 ? 'Id number needs 10 digits' : null,
                      onChanged: (val) => setState(() => _currentIdNumber = val ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(hintText: 'Name').copyWith(labelText: 'Name'),
                      validator: (val) => val.isEmpty ? 'Enter name' : null,
                      onChanged: (val) => setState(() => _currentName = val ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.course,
                      decoration: textInputDecoration.copyWith(hintText: 'Course').copyWith(labelText: 'Course'),
                      validator: (val) => val.length > 6 ? 'Enter 6 characters' : null,
                      onChanged: (val) => setState(() => _currentCourse = val ),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.orange,
                      child: Text('Update',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentIdNumber ?? userData.idNumber,
                            _currentName ?? userData.name, 
                            _currentCourse ?? userData.course,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
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