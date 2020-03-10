//import 'dart:async';
//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'globals.dart' as globals;
//import 'diary.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'record.dart' as variables;
//import 'second.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'MyPage.dart';
//
//
//
//class TimePage extends StatefulWidget {
//  @override
//  _TimePageState createState() => _TimePageState();
//}
//
//class _TimePageState extends State<TimePage> {
//
//
//  launchURL() {
//    launch('https://handongsam.com/probiotics');}
//
//  static DateTime now = DateTime.now();
//  Timer _everySecond;
//
//
//  Text tt;
//  Text ttt;
//  String xxx = "00:00:00";
//
//  String time_calc(int now, int target){
//    int hour = 0;
//    int minute = 0;
//    int second = 0;
//    if(target > now){ // prior target time
//      int temp = target - now;
//
//      hour = (temp/3600).toInt();
//      minute = ((temp%3600)/60).toInt();
//      second = temp % 60;
//
//
//    } else { // post target time
//      int temp = target - now + 3600*24;
//
//      hour = (temp/3600).toInt();
//      minute = ((temp%3600)/60).toInt();
//      second = temp % 60;
//    }
//
//    String hour_ = hour <10 ? "0" + hour.toString(): hour.toString();
//    String minute_ = minute < 10 ? "0" + minute.toString() : minute.toString();
//    String second_  = second < 10 ? "0" + second.toString() : second.toString();
//
//    return hour_ + ":" + minute_ + ":" + second_;
//  }
//
//  void initState()  {
//
//
//
//
//    super.initState();
//
//    // sets first value
//    now = DateTime.now();
//
//    // defines a timer
//    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
//      setState(() {
//        now = DateTime.now();
//        //tt = Text(now.toString(),textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),);
//
//        int now_ = now.hour * 3600 + now.minute * 60 + now.second;
//        int c = globals.takeInHour * 3600 + globals.takeInminute * 60;
//
//        xxx = time_calc(now_, c);
//
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child:
//            Column(
//              //mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SizedBox(height: 80,),
//                Row(
//                  //mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    //SizedBox(height: 200,),
//                    //하드 코딩 되어있는 3일치를
//                    //14를 기준으로 남은 일차를 계산해서 보여 줄 수 있도록 하고
//                    //
//                    Text("         "),
//                    SizedBox(child: Icon(Icons.notifications_active, size: 35.0,color: Color.fromARGB(255, 10, 30, 107)),),
//                    Column(children: <Widget>[
//                      Text(" 유산균 3일치가 남았습니다!", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),),
//                      Text("      위드워터 재구매를 신청하세요!", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),),
//                    ]),
//                  ],
//                ),
//
//                SizedBox(height: 140,),
//               // Icon(Icons.notifications_active, size: 20.0,color: Color.fromARGB(255, 10, 30, 107)),
//                Text("잊지말고 마시자", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//            Text("유 산 균", style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.bold),),
//                Text("먹기까지 남은 시간", style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//            SizedBox(height: 10,),
//            Text(  xxx , style: TextStyle(fontSize: 45,decoration: TextDecoration.underline,) ),
//                SizedBox(height: 40,),
//                RaisedButton(
//                  child: Text("다이어리 작성하기"),
//                  shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(18.0),
//                  ),
//                  textColor: Colors.black,
//                  splashColor: Colors.black,
//                  onPressed: () { //DiaryPage
//                    Navigator.of(context).push(
//                        MaterialPageRoute(
//                          builder: (context) {
//                            return DiaryPage();
//                          },
//                        ));
//                  },
//                )
//          ],)
//      ),
//
//      bottomNavigationBar: ButtonBar(
//        alignment: MainAxisAlignment.center,
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.shopping_cart),color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
//              launchURL();
//              },),
//          IconButton(icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 10, 30, 107),),
//          onPressed: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) {
//                  return  DiaryPage(); // alarm page.
//                },
//              ),
//            );
//          },),
//          IconButton(icon: Image(image: AssetImage("assets/1.png")), onPressed: () {
//
//          },),
//          IconButton(icon: Icon(Icons.person, color: Color.fromARGB(255, 10, 30, 107)),onPressed: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) {
//                  return  MyPages(); // alarm page.
//                },
//              ),
//            );
//          },),
//          //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
//          IconButton(icon: Icon(Icons.alarm,
//              color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) {
//                  return HomePage(); // alarm page.
//                },
//              ),
//            );
//
//          },),
//        ],),
//    );
//  }
//
//}
import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_example/chart.dart';
import 'globals.dart' as globals;
import 'diary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart' as variables;
import 'second.dart';
import 'package:url_launcher/url_launcher.dart';
import 'MyPage.dart';



class TimePage extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {


  launchURL() {
    launch('https://handongsam.com/probiotics');}

  static DateTime now = DateTime.now();
  Timer _everySecond;


  Text tt;
  Text ttt;
  String xxx = "00:00:00";

  String time_calc(int now, int target){
    int hour = 0;
    int minute = 0;
    int second = 0;
    if(target > now){ // prior target time
      int temp = target - now;

      hour = (temp/3600).toInt();
      minute = ((temp%3600)/60).toInt();
      second = temp % 60;


    } else { // post target time
      int temp = target - now + 3600*24;

      hour = (temp/3600).toInt();
      minute = ((temp%3600)/60).toInt();
      second = temp % 60;
    }

    String hour_ = hour <10 ? "0" + hour.toString(): hour.toString();
    String minute_ = minute < 10 ? "0" + minute.toString() : minute.toString();
    String second_  = second < 10 ? "0" + second.toString() : second.toString();

    return hour_ + ":" + minute_ + ":" + second_;
  }

  void initState()  {




    super.initState();

    // sets first value
    now = DateTime.now();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
        //tt = Text(now.toString(),textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),);

        int now_ = now.hour * 3600 + now.minute * 60 + now.second;
        int c = globals.takeInHour * 3600 + globals.takeInminute * 60;

        xxx = time_calc(now_, c);

      });
    });
  }

  int temp = 14 - globals.day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //SizedBox(height: 200,),
                  //하드 코딩 되어있는 3일치를
                  //14를 기준으로 남은 일차를 계산해서 보여 줄 수 있도록 하고
                  //
                  Text("         "),
                  SizedBox(child: Icon(Icons.notifications_active , size: 35.0,color: Color.fromARGB(255, 10, 30, 107)),),
                  Column(children: <Widget>[
                    Text(globals.day  > 10? "유산균 \"$temp일치\"가 남았습니다!": "", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),),
                    Text(globals.day  > 10?"    위드워터 재구매를 신청하세요!": "", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),),
                  ]),
                ],
              ),

              SizedBox(height: 140,),
              // Icon(Icons.notifications_active, size: 20.0,color: Color.fromARGB(255, 10, 30, 107)),
              Text("잊지말고 마시자", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
              Text("유 산 균", style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.bold),),
              Text("먹기까지 남은 시간", style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
              SizedBox(height: 10,),
              Text(  xxx , style: TextStyle(fontSize: 45,decoration: TextDecoration.underline,) ),
              SizedBox(height: 40,),
              RaisedButton(
                child: Text("다이어리 작성하기"),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                textColor: Colors.black,
                splashColor: Colors.black,
                onPressed: () { //DiaryPage
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiaryPage();
                        },
                      ));
                },
              )
            ],)
      ),

      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
            launchURL();
          },),
          IconButton(icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 10, 30, 107),),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return  DiaryPage(); // alarm page.
                  },
                ),
              );
            },),
          IconButton(icon: Image(image: AssetImage("assets/1.png")), onPressed: () {

          },),
          IconButton(icon: Icon(Icons.person, color: Color.fromARGB(255, 10, 30, 107)),onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return  MyPages(); // alarm page.
                },
              ),
            );
          },),
          //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
          IconButton(icon: Icon(Icons.alarm,
              color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                  //return HomePage(); // alarm page.ChartPage
                },
              ),
            );

          },),
        ],),
    );
  }

}
