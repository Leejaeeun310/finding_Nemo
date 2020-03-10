
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

File image;
File profile;
String userUID;
FirebaseUser user;
String userEmail;

class Record {
  final String name;
  final String location;
  final String detail;
  final String other;
  final String url;
  final String phonum;
  final String writer;
  String date;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['location'] != null),
        assert(map['detail'] != null),
        assert(map['url'] != null),
        assert(map['other'] != null),
        assert(map['phonum'] != null),
        assert(map['writer'] != null),
        url = map['url'],
        name = map['name'],
        location = map['location'],
        detail = map['detail'],
        other = map['other'],
        phonum = map['phonum'],
        date = map['date'],
        writer = map['writer'];


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$location$detail$other$phonum$writer>";
}


