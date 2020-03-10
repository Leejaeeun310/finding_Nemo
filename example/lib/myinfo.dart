
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

File image;
File profile;
String userUID;
FirebaseUser user;
String userEmail;





class Myinfo {

//final String currentTime;


  String dd;
  final String gender;
  final int height;
  final String name;
  int total_day;
  final int weight;

  String documentID;
  final DocumentReference reference;


  Myinfo.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['name'] != null),
        gender = map['gender'],
        height = map['height'],
        total_day = map['total_day'],
        dd = map['dd'],
        weight = map['weight'],
        name = map['name'],
        documentID = docID;


  Myinfo.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID,reference: snapshot.reference);

  @override
  String toString() => "Record<$name>";
}



