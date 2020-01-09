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
      body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg.png'
                ),
                fit: BoxFit.cover,
              ),  
            ),   
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email').copyWith(labelText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter email' : null,
                    onChanged: (val){
                      setState(()=> email = val.trim());
                    }
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password').copyWith(labelText: 'Password'),
                    validator: (val) => val.length < 7 ? 'Enter password 6+ characters' : null,
                    obscureText: true,
                    onChanged: (val){ 
                      setState(()=> password = val);
                    }
                  ),
                  SizedBox(height: 10.0),
                  SizedBox( 
                    width: 300.0,
                    height: 46.0,
                    child: OutlineButton(
                    borderSide: BorderSide(color: Colors.orange,width: 3),
                    shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.white,
                    style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(14.0)),
                    child: Text('Sign in', 
                      style: TextStyle(color: Colors.white, fontSize: 18.0,)
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
                  ),
                  
                  
                  FlatButton(
                    child: Text('Register', 
                      style: TextStyle(color: Colors.white, fontSize: 16.0)
                    ),
                    onPressed: () {
                      widget.toggleView();
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