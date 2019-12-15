import 'package:acctendance/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference user = Firestore.instance.collection('users');


  //insert additional user data parameters
  Future insertUserData(String email, String password, String name, String idNumber, String course) async {
    return await user.document(uid).setData({
      'email' : email,
      'password' : password,
      'name' : name,
      'idNumber' : idNumber,
      'course' : course,
    });
  }

  //update user data
  Future updateUserData(String idNumber, String name, String course) async {
    return await user.document(uid).setData({
      'idNumber' : idNumber,
      'name' : name,
      'course' : course,
    });
  }



  //users list from snapshot
  // ignore: unused_element
  List<UserData> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserData(
        idNumber: doc.data['idNumber'] ?? '',
        name: doc.data['name'] ?? '',
        course: doc.data['course'] ?? '',
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      idNumber: snapshot.data['idNumber'],
      name: snapshot.data['name'],
      course: snapshot.data['course'], 
    );
  }

  //get user stream
  Stream<List<UserData>> get users {
    return user.snapshots()
      .map(_usersListFromSnapshot);
  }
  
  //get user doc stream
  Stream<UserData> get userData{
    return user.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}