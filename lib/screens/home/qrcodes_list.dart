import 'package:acctendance/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QRcodeList extends StatefulWidget {
  @override
  _QRcodeListState createState() => _QRcodeListState();
}

class _QRcodeListState extends State<QRcodeList> {

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    yield* Firestore.instance.collection('qrcodes').document(user.uid).collection('qrdata').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    try{
      return StreamBuilder(
        stream: getUsersTripsStreamSnapshots(context),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) =>
              buildTripCard(context, snapshot.data.documents[index]));
        });
    }catch(e){
      return Loading();
    }
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot qrdata) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            Text(
              qrdata['qrcodedata'],
            ),
            Spacer(),
          ]),
        ),
      ),
    );
  }
}