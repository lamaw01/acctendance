import 'package:acctendance/models/user.dart';
import 'package:acctendance/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  // ignore: unused_element
  User _userFromFireBase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
  
  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFireBase);
  }

  //sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in email and password
  Future signInWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  

  //register with email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(2015103251, 'Janrey Dumaog', 'BS-IT');
      return _userFromFireBase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}