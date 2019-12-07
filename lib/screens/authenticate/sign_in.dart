import 'package:acctendance/services/auth.dart';
import 'package:acctendance/shared/constants.dart';
import 'package:acctendance/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            textColor: Colors.white,
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Enter email' : null,
                onChanged: (val){
                  setState(()=> email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter password 6+ chars' : null,
                obscureText: true,
                onChanged: (val){
                  setState(()=> password = val);
                }
              ),
              SizedBox(height: 20.0
              ),
              RaisedButton(
                color: Colors.pink,
                child: Text('Sign in', 
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailandPassword(email, password);
                     if(result == null){
                       error = 'error something is wrong';
                       setState(() => loading = false);
                     }
                  }
                }
              ),
              SizedBox(
                height: 20.0
              ),
              Text(error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
            ],
          ),
        ),
      ),
    );
  }
}