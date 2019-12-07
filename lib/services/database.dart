import 'package:acctendance/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userData = Firestore.instance.collection('users');

  Future updateUserData(int idNumber, String name, String course) async {
    return await userData.document(uid).setData({
      'idNumber' : idNumber,
      'name' : name,
      'course' : course,
    });
  }

  //users list from snapshot
  // ignore: unused_element
  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Users(
        idNumber: doc.data['idNumber'] ?? 0,
        name: doc.data['name'] ?? '',
        course: doc.data['course'] ?? '',
      );
    }).toList();
  }

  //get user stream
  Stream<List<Users>> get users {
    return userData.snapshots()
      .map(_usersListFromSnapshot);
  }

}