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
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg.png'
                ),
                fit: BoxFit.cover,
              ),  
            ),
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Id number').copyWith(labelText: 'Id number'),
                  validator: (val) => val.length != 10 ? 'Id number needs 10 digits' : null,
                  onChanged: (val){
                    setState(()=> idNumber = val);
                  }
                ),
                SizedBox(height: 10.0),  
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name').copyWith(labelText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Enter name' : null,
                  onChanged: (val){
                    setState(()=> name = val);
                  }
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'College').copyWith(labelText: 'College'),
                  validator: (val) => val.isEmpty ? 'Enter college' : null,
                  onChanged: (val){
                    setState(()=> course = val);
                  }
                ),
                SizedBox(height: 10.0),
                SizedBox( 
                    width: 322.0,
                    height: 46.0,
                    child: OutlineButton(
                    borderSide: BorderSide(color: Colors.deepPurple,width: 3),
                    shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.white,
                    style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(14.0)),
                    child: Text('Register', 
                      style: TextStyle(color: Colors.white, fontSize: 18.0,)
                    ),
                    onPressed: () async{
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.registerWithEmailandPassword(email, password, idNumber, name,  course);
                      if(result == null){
                        setState(() => error = 'error something is wrong');
                      }
                    }
                  }
                ),
              ),
 
                FlatButton(
                    child: Text('Sign in', 
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
      ),
    );
  }
}