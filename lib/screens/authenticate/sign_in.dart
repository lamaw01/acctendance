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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.arrow_forward_ios),
            label: Text('Register'),
            textColor: Colors.white,
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Enter email' : null,
                onChanged: (val){
                  setState(()=> email = val.trim());
                }
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 7 ? 'Enter password 6+ characters' : null,
                obscureText: true,
                onChanged: (val){
                  setState(()=> password = val);
                }
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.green[300],
                child: Text('Sign in', 
                  style: TextStyle(color: Colors.white, fontSize: 18.0)
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
              SizedBox(height: 10.0),
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