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
            return Loading();
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) =>
              buildTripCard(context, snapshot.data.documents[index])
          );
        }
      );
    }catch(e){
      return Loading();
    }
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot qrdata) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 300.0,
                    child: Text(
                      qrdata['qrcodedata'],
                      textAlign: TextAlign.center,
                      
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(  
                    height: 140.0,
                    width: 300.0,
                    child: Image.network(qrdata['signature'],
                      scale: 0.1,
                      color: Colors.black,
                      width: 140.0, height: 140.0,
                    ),
                  ),
                ],
              ),
          ]
          ),     
        ),
      ),
    );
  }
  
}