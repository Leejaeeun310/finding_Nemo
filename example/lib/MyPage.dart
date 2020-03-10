//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'record.dart';
//
//class MyPages extends StatefulWidget {
//  @override
//  _MyPagesState createState() {
//    return _MyPagesState();
//  }
//}
//
//class _MyPagesState extends State<MyPages> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(
//          icon: new Icon(Icons.arrow_back),
//          onPressed: () {
//            Navigator.pop(context);
//          }, ),//버튼누르면이전페이지로돌아가기
//        title: Text('My Pages'),
//        actions: <Widget>[
//          new IconButton(
//            icon: new Icon(Icons.add),
//            onPressed: () => {}, ), //버튼누르면로그인정보뜨게하기 or 정보입력
//          new IconButton(
//            icon: new Icon(Icons.exit_to_app),
//            onPressed: () => {}, ),//버튼누르면로그아웃
//        ],
//      ),
//      body: _buildBody(context),
//    );
//  }
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('handongsam').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return _buildList(context, snapshot.data.documents);
//      },
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Record.fromSnapshot(data);
//
//    return Padding(
//      key: ValueKey(record.name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        // child: ListTile(
//        //   leading: Icon(Icons.person),
//        //   title: Text(record.name),
//        //   trailing: Text(record.total_day.toString()),
//        //   onTap: () => print(record),
//        // ),//회원정보
//      ),
//    );
//  }
//}
import 'package:flutter/material.dart';
import 'record.dart' as variable;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main_time.dart';
import 'diary.dart';
import 'myinfo.dart';
import 'taskhomepage.dart';
class MyPages extends StatefulWidget {
  @override
  _MypageState createState() => new _MypageState();
}

class _MypageState extends State<MyPages> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   // final myinfo = Myinfo.fromSnapshot(data);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
        SizedBox(height: 10.0,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                FlatButton(
                  onPressed: (){
                    print('취소');
                    Navigator.push(context,
                        MaterialPageRoute<void>(builder: (BuildContext context) {
                          return DiaryPage();
                        })
                    );
                    //Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text('취소',
                        style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 15.0,
                            fontWeight: FontWeight.w500)),
                  ),

                ),

                Center(
                  child: Text('마이 페이지',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),


//                  Text('다이어리 작성',
//                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40.0,color: Color.fromARGB(255, 10, 30, 107),),
//                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _googleSignIn.signOut();
                    Navigator.of(context).pushNamed('/loginPage');

                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text('로그아웃',
                        style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 15.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  //color: Colors.blue[300],
                ),

              ]
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child:
                Image(
                  image: NetworkImage(variable.user.photoUrl),
                  width: 100, height:200,
                ),
              ),

              Column(
                children: <Widget>[
                  Text("Email" ),
                  Center(
                    child:
                    Text(variable.user.email),

                  ),
                ],
              ),]

          ),


          //SizedBox(height: 5.0,),
          FlatButton(
            onPressed: ()=> Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return  TaskHomePage(); // alarm page.//
                },
              ),
            ),
            padding: EdgeInsets.all(0.0),
            child: Image.asset("assets/bar-chart.png",width: 200, height:200),),
          Center(
            child:
            Text("차트 보러 가기 ", style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 15.0,
                fontWeight: FontWeight.w500)),

          ),



          SizedBox(height: 6.0,),
        ]
      )



    );
  }

}



