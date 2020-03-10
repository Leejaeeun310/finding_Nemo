//
//
import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'second.dart';
import 'globals.dart' as globals;
import 'login.dart';
import 'add.dart';
import 'diary.dart';
import 'main_time.dart';
import 'chart.dart';
import 'taskhomepage.dart';



void main() async {

  runApp(
      MaterialApp(
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/HomeScreen': (BuildContext context) => LoginPage() // LoginPage() or TimePage
          ,
          '/loginPage': (context) => LoginPage(), // google login page,  login.dart
          '/DiaryPage': (context) => DiaryPage(),
          '/HomePage' : (context) => HomePage(), // nothing
          '/AddPage' : (context) => AddPage(),
          '/TimePage' : (context) => TimePage() ,
          '/ChartPage' : (context) => ChartPage(),// first page, main_time.dart
          '/TaskHomePage' : (context) => TaskHomePage(),


        },
      ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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

  void initState() {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 250,),
              Text("유산균 먹을 시간", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(xxx + " 남음", style: TextStyle(fontSize: 30,) ),
              SizedBox(height: 40,),
              RaisedButton(
                child: Text("시작하기"),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),

                ),
                textColor: Colors.black,
                splashColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(), //일단 지금은 + 누르면 다이어리 리스트로 감!
                      ));
                },

              )
            ],)
      ),

      bottomNavigationBar:  ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart,),color: Color.fromARGB(255, 10, 30, 107),
          ),
          IconButton(icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 10, 30, 107),),),
          IconButton(icon: Image(image: AssetImage("assets/1.png")),),
          IconButton(icon: Icon(Icons.person,color: Color.fromARGB(255, 10, 30, 107)),),
          //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
          IconButton(icon: Icon(Icons.alarm,
              color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );

          },),
        ],)

      ,
    );
  }


}




class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {

    var _duration = Duration(seconds: 3);

    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  //로딩페이지 3초후 로그인페이지로 이동!!
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
                SizedBox(height:250.0),
                Icon(Icons.wifi,color: Color.fromARGB(255, 10, 30, 107)),
                SizedBox(height:5.0),
                Text('와이파이 사용을 권장합니다',style: new TextStyle(fontWeight: FontWeight.normal, color: Color.fromARGB(255, 10, 30, 107)),),
              ],
            ),

            SizedBox(height: 120.0), //

          ],
        ),
      ),
    );
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Center(
//        child:Text('한동샘'),//Image.asset('assets/1.png'),
//      ),
//    );
  }
}


//import 'package:flutter/material.dart';
//import 'taskhomepage.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Firestore Chart',
//      theme: ThemeData(
//        primaryColor: Color(0xff543B7A),
//      ),
//      home: TaskHomePage(),
//      //home:SalesHomePage(),
//    );
//  }
//}