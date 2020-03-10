////
////import 'dart:async';
////import 'package:firebase_auth/firebase_auth.dart';
////import 'package:google_sign_in/google_sign_in.dart';
////import 'package:flutter/material.dart';
////import 'home.dart';
////import 'main_time.dart';
////import 'record.dart' as variable;
////import 'package:cloud_firestore/cloud_firestore.dart';
////import 'globals.dart' as global;
////
////
////class LoginPage extends StatefulWidget {
////  @override
////  _LoginPageState createState() => _LoginPageState();
////}
////
////class _LoginPageState extends State<LoginPage> {
////  final FirebaseAuth _auth = FirebaseAuth.instance;
////  final GoogleSignIn _googleSignIn = GoogleSignIn();
////
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      backgroundColor: Colors.white,
////      body: SafeArea(
////        child: ListView(
////          padding: EdgeInsets.symmetric(horizontal: 24.0),
////          children: <Widget>[
////            SizedBox(height: 80.0),
////            Column(
////              children: <Widget>[
////                Image.asset('assets/1.png', width: 200.0, height: 200.0,),
////                SizedBox(height: 10.0),
////                Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0,color: Color.fromARGB(255, 10, 30, 107)),),
////                Text('한   동   샘',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0 ,color: Color.fromARGB(255, 10, 30, 107)),),
////                SizedBox(height:50.0),
////                //Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),),
////              ],
////            ),
////
////            SizedBox(height: 50.0),
////            _GooglesignInButton(), //구글 로그인
////
////          ],
////        ),
////      ),
////    );
////  }
////
////  Widget _GooglesignInButton() {
////    return OutlineButton(
////      splashColor: Colors.grey,
////      onPressed: () {
////        _signInWithGoogle().whenComplete(
////            () {
////
////              getData() async {
////                return await Firestore.instance.collection('handongsam').getDocuments();
////              }
////
////              getData().then((val){
////                if(val.documents.length > 0){
////                  int i = 0;
////                  for(i = 0 ; i < val.documents.length; ++ i){
////                    if(val.documents[i].documentID==variable.user.uid){
////                      //print(val.documents[i].data["gender"]);
////                      print(val.documents[i].documentID);
////                      if(val.documents[i].data["diary_time_hh"] != null){
////                        global.takeInHour = val.documents[i].data["alarm_time_hh"];
////                      }
////                      if(val.documents[i].data["diary_time_mm"] != null){
////                        global.takeInminute = val.documents[i].data["alarm_time_mm"];
////                      }
////                      if(val.documents[i].data["alarm_time_hh"] != null){
////                        global.diaryHour = val.documents[i].data["diary_time_hh"];
////                      }
////                      if(val.documents[i].data["alarm_time_mm"] != null){
////                        global.diaryMinute = val.documents[i].data["diary_time_mm"];
////                      }
////
////
////                    }
////                  }
////                }
////                else{
////                  print("Not Found");
////                }
////              });
////
////              Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({'dd':'dd'});
////              Navigator.of(context).push(
////                  MaterialPageRoute(
////                      builder: (context) => TimePage())
////              );
////              Firestore.instance
////                  .collection(variable.user.uid)
////                  .getDocuments()
////                  .then((QuerySnapshot snapshot) {
////                snapshot.documents.forEach((f) => print('${f.data}}'));});
////
////            }
////        );
////      },
////      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
////      highlightElevation: 0,
////      borderSide: BorderSide(color: Color.fromARGB(255, 10, 30, 107)),
////      child: Padding(
////        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
////        child: Row(
////          mainAxisSize: MainAxisSize.min,
////          mainAxisAlignment: MainAxisAlignment.center,
////          children: <Widget>[
////            Padding(
////              padding: const EdgeInsets.only(left: 10),
////              child: Text(
////                '구글 아이디로 로그인',
////                style: TextStyle(
////                  fontSize: 20,
////                  color: Color.fromARGB(255, 10, 30, 107),
////                ),
////              ),
////            )
////          ],
////        ),
////      ),
////    );
////  }
////
////
////  Future<FirebaseUser> _signInWithGoogle() async {
////    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
////    final GoogleSignInAuthentication googleAuth =
////    await googleUser.authentication;
////    final AuthCredential credential = GoogleAuthProvider.getCredential(
////      accessToken: googleAuth.accessToken,
////      idToken: googleAuth.idToken,
////    );
////    final FirebaseUser user = await _auth.signInWithCredential(credential);
////    assert(user.email != null);
////    assert(user.displayName != null);
////    assert(!user.isAnonymous);
////    assert(await user.getIdToken() != null);
////
////    final FirebaseUser currentUser = await _auth.currentUser();
////    assert(user.uid == currentUser.uid);
////
////    variable.userUID = user.uid;
////    variable.userEmail = user.email;
////    variable.user = user;
////
////    return user;
////  }
////
////
////
////
////
////}
////
////// TODO: Add AccentColorOverride (103)
//
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications_example/data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'main_time.dart';
import 'record.dart' as variable;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as global;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/1.png', width: 200.0, height: 200.0,),
                SizedBox(height: 10.0),
                Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0,color: Color.fromARGB(255, 10, 30, 107)),),
                Text('한   동   샘',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0 ,color: Color.fromARGB(255, 10, 30, 107)),),
                SizedBox(height:50.0),
                //Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),),
              ],
            ),

            SizedBox(height: 50.0),
            _GooglesignInButton(), //구글 로그인

          ],
        ),
      ),
    );
  }

  Widget _GooglesignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _signInWithGoogle().whenComplete(
                () {

              getData() async {
                return await Firestore.instance.collection('handongsam').getDocuments(); //로그인 성공 시 firebase에서 데이터를 불러온다.
              }

              getData().then((val){
                bool user = false;
                if(val.documents.length > 0){                                    //user id를 돌면서 나의 기록이 있으면 알람 시간들을 불러온다.
                  int i = 0;
                  for(i = 0 ; i < val.documents.length; ++ i){
                    if(val.documents[i].documentID==variable.user.uid){
                      user = true;



                      //print(val.documents[i].data["gender"]);
                      print(val.documents[i].documentID);



                      if(val.documents[i].data["diary_time_hh"] != null){
                        global.takeInHour = val.documents[i].data["alarm_time_hh"];
                      }
                      if(val.documents[i].data["diary_time_mm"] != null){
                        global.takeInminute = val.documents[i].data["alarm_time_mm"];
                      }
                      if(val.documents[i].data["alarm_time_hh"] != null){
                        global.diaryHour = val.documents[i].data["diary_time_hh"];
                      }
                      if(val.documents[i].data["alarm_time_mm"] != null){
                        global.diaryMinute = val.documents[i].data["diary_time_mm"];
                      }
                      if(val.documents[i].data["total_day"] != null){
                        global.day = val.documents[i].data["total_day"];
                      }




                    }



                  }
                }
                else{
                  print("Not Found");
                }
                if(user==false){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DataPage()));
                }
              });

              Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({'dd':'dd'});
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TimePage())
              );
              Firestore.instance
                  .collection(variable.user.uid)
                  .getDocuments()
                  .then((QuerySnapshot snapshot) {
                snapshot.documents.forEach((f) => print('${f.data}}'));});

            }
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Color.fromARGB(255, 10, 30, 107)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '구글 아이디로 로그인',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 10, 30, 107),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    variable.userUID = user.uid;
    variable.userEmail = user.email;
    variable.user = user;

    return user;
  }





}

//// TODO: Add AccentColorOverride (103)

//import 'dart:async';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter/material.dart';
//import 'home.dart';
//import 'main_time.dart';
//import 'data.dart';
//import 'record.dart' as variable;
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'globals.dart' as global;
//
//
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: SafeArea(
//        child: ListView(
//          padding: EdgeInsets.symmetric(horizontal: 24.0),
//          children: <Widget>[
//            SizedBox(height: 80.0),
//            Column(
//              children: <Widget>[
//                Image.asset('assets/1.png', width: 200.0, height: 200.0,),
//                SizedBox(height: 10.0),
//                Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0,color: Color.fromARGB(255, 10, 30, 107)),),
//                Text('한   동   샘',style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0 ,color: Color.fromARGB(255, 10, 30, 107)),),
//                SizedBox(height:50.0),
//                //Text('HANDONGSAM',style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),),
//              ],
//            ),
//
//            SizedBox(height: 50.0),
//            _GooglesignInButton(), //구글 로그인
//
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _GooglesignInButton() {
//    return OutlineButton(
//      splashColor: Colors.grey,
//      onPressed: () {
//        _signInWithGoogle().whenComplete(
//                () {
//
//              getData() async {
//                return await Firestore.instance.collection('handongsam').getDocuments();
//              }
//
//              getData().then((val){
//                if(val.documents.length > 0){
//                  int i = 0;
//                  for(i = 0 ; i < val.documents.length; ++ i){
//                    if(val.documents[i].documentID==variable.user.uid){
//                      //print(val.documents[i].data["gender"]);
//                      print(val.documents[i].documentID);
//
//
//                      if(val.documents[i].documentID==variable.user.uid){
//                        Navigator.of(context).push(
//                            MaterialPageRoute(
//                                builder: (context) => TimePage())
//                        );}
//
//
//
//                      if(val.documents[i].documentID!=variable.user.uid){
//                        Navigator.of(context).push(
//                            MaterialPageRoute(
//                                builder: (context) => DataPage())
//                        );}
//
//                      if(val.documents[i].data["diary_time_hh"] != null){
//                        global.takeInHour = val.documents[i].data["alarm_time_hh"];
//                      }
//                      if(val.documents[i].data["diary_time_mm"] != null){
//                        global.takeInminute = val.documents[i].data["alarm_time_mm"];
//                      }
//                      if(val.documents[i].data["alarm_time_hh"] != null){
//                        global.diaryHour = val.documents[i].data["diary_time_hh"];
//                      }
//                      if(val.documents[i].data["alarm_time_mm"] != null){
//                        global.diaryMinute = val.documents[i].data["diary_time_mm"];
//                      }
//
//
//                    }
//                  }
//                }
//                else{
//                  print("Not Found");
//                }
//              });
//
//              Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({'dd':'dd'});
//
//              //       Navigator.of(context).push(
//              //            MaterialPageRoute(
//              //            builder: (context) => TimePage())
//              //    );
//              Firestore.instance
//                  .collection(variable.user.uid)
//                  .getDocuments()
//                  .then((QuerySnapshot snapshot) {
//                snapshot.documents.forEach((f) => print('${f.data}}'));});
//
//            }
//        );
//      },
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//      highlightElevation: 0,
//      borderSide: BorderSide(color: Color.fromARGB(255, 10, 30, 107)),
//      child: Padding(
//        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//        child: Row(
//          mainAxisSize: MainAxisSize.min,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(left: 10),
//              child: Text(
//                '구글 아이디로 로그인',
//                style: TextStyle(
//                  fontSize: 20,
//                  color: Color.fromARGB(255, 10, 30, 107),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//
//  Future<FirebaseUser> _signInWithGoogle() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//    await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//    final FirebaseUser user = await _auth.signInWithCredential(credential);
//    assert(user.email != null);
//    assert(user.displayName != null);
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);
//
//    variable.userUID = user.uid;
//    variable.userEmail = user.email;
//    variable.user = user;
//
//    return user;
//  }
//
//
//
//
//
//}
//
// TODO: Add AccentColorOverride (103)