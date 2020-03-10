//
//
//// home.dart가 메인페이지로 알람 카운트 다운이 나오는 곳!!
//
//
//import 'package:flutter/material.dart';
//import 'diary.dart';
//
//class HomePage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState(){
//    return new HomePageState();
//  }
//}
//
//
//class HomePageState extends State<HomePage> {
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.blue[300],
//        brightness: Brightness.light,
//        title: Center(
//          child: Text('Main',
//            textAlign: TextAlign.center,
//          ),
//        ),
//        leading: IconButton(
//          icon: Icon(
//              Icons.add,
//          ),
//          onPressed: () {
//            print('profile');
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) => DiaryPage(), //일단 지금은 + 누르면 다이어리 리스트로 감!
//              ),
//            );
//          },
//        ),
//
//      ),
//
//
//      //_buildBody(context)
//      //,
//
//    );
//  }
//
//}
//
//
//
