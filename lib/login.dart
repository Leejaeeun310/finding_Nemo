
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'record.dart' as variable;


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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/slelogo.png'),
                SizedBox(height: 16.0),
                Text('니모를 찾아서',style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: 120.0),
            _GooglesignInButton(), //구글 로그인

            SizedBox(height: 12.0),


//            ButtonBar(
//              children: <Widget>[
//
//                RaisedButton(
//                  child: Text('NEXT'),
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }

  Widget _GooglesignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstPage();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue[300]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue[300],
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

// TODO: Add AccentColorOverride (103)
