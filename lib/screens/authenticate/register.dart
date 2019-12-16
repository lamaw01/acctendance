import 'package:acctendance/services/auth.dart';
import 'package:acctendance/shared/constants.dart';
import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String idNumber = '';
  String name = '';
  String course = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            textColor: Colors.white,
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Enter email' : null,
                  onChanged: (val){
                    setState(()=> email = val);
                  }
                ),
                SizedBox(height: 5.0),
                TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter password 6+ characters' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(()=> password = val);
                  }
                ),
                SizedBox(height: 5.0),
                TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Enter Name' : null,
                  onChanged: (val){
                    setState(()=> name = val);
                  }
                ),
                SizedBox(height: 5.0),
                TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Id Number'),
                  validator: (val) => val.length != 10 ? 'Id Number needs 10 digits' : null,
                  onChanged: (val){
                    setState(()=> idNumber = val);
                  }
                ),
                SizedBox(height: 5.0),
                TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'College'),
                  validator: (val) => val.isEmpty ? 'Enter College' : null,
                  onChanged: (val){
                    setState(()=> course = val);
                  }
                ),
                SizedBox(height: 5.0
                ),
                RaisedButton(
                  color: Colors.orange[400],
                  child: Text('Register', 
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.registerWithEmailandPassword(email, password, name, idNumber, course);
                      if(result == null){
                        setState(() => error = 'error something is wrong');
                      }
                    }
                  }
                ),
                SizedBox(
                  height: 5.0
                ),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}