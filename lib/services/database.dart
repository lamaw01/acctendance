import 'package:acctendance/models/qrcode.dart';
import 'package:acctendance/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference user = Firestore.instance.collection('users');
  final CollectionReference qrcodes = Firestore.instance.collection('qrcodes');

  //insert additional user data parameters
  Future insertUserData(String idNumber, String name, String course) async {
    return await user.document(uid).setData({
      'idNumber' : idNumber,
      'name' : name,
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

  //insert QRCodedata
  Future insertQRCodeData(String qrcodedata, String signature) async {
    return await qrcodes.document(uid).setData({
      'qrcodedata' : qrcodedata,
      'signature' : signature
    });
  }

  //users list from snapshot
  List<UserData> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserData(
        idNumber: doc.data['idNumber'] ?? '',
        name: doc.data['name'] ?? '',
        course: doc.data['course'] ?? '',
      );
    }).toList();
  }

  //users list from snapshot
  List<QRcode> _qrcodesListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return QRcode(
        qrcodedata: doc.data['qrcode'] ?? '',
        signature: doc.data['signature'] ?? '',
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

  //QRcode data from snapshot
  QRcode _qrcodesDataFromSnapshot(DocumentSnapshot snapshot){
    return QRcode(
      //uid: uid,
      qrcodedata: snapshot.data['qrcode'],
      signature: snapshot.data['signature'],
    );
  }

  //get user stream
  Stream<List<UserData>> get users {
    return user.snapshots()
      .map(_usersListFromSnapshot);
  }

   //get QRcode stream
  Stream<List<QRcode>> get qr {
    return qrcodes.snapshots()
      .map(_qrcodesListFromSnapshot);
  }
  
  //get user doc stream
  Stream<UserData> get userData{
    return user.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  //get QRcode doc stream
  Stream<QRcode> get qrcodesdata{
    return qrcodes.document(uid).snapshots()
      .map(_qrcodesDataFromSnapshot);
  }


}