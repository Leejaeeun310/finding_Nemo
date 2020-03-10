//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'record.dart';
//import 'add.dart';
//import 'globals.dart' as globals;
//import 'package:url_launcher/url_launcher.dart';
//import 'MyPage.dart';
//import 'second.dart';
//String name = userUID;
//
//
//class DiaryPage extends StatefulWidget {
//  @override
//  _MyDiaryPageState createState() {
//    return _MyDiaryPageState();
//  }
//}
//
//class _MyDiaryPageState extends State<DiaryPage> {
//
//
//
//  launchURL() {
//    launch('https://handongsam.com/probiotics');}
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(      bottomNavigationBar: ButtonBar(
//      alignment: MainAxisAlignment.center,
//      children: <Widget>[
//        IconButton(
//          icon: Icon(Icons.shopping_cart), color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
//          launchURL();
//        },),
//        IconButton(icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 10, 30, 107),),
//          onPressed: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) {
//                  return  DiaryPage(); // alarm page.
//                },
//              ),
//            );
//          },),
//        IconButton(icon: Image(image: AssetImage("assets/1.png")), onPressed: () {
//
//        },),
//        IconButton(icon: Icon(Icons.person,color: Color.fromARGB(255, 10, 30, 107)),onPressed: () {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) {
//                return  MyPages(); // alarm page.
//              },
//            ),
//          );
//        },),
//        //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
//        IconButton(icon: Icon(Icons.alarm,
//            color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) {
//                return HomePage(); // alarm page.
//              },
//            ),
//          );
//
//        },),
//      ],),
//      //appBar: AppBar(title: Text('Diary')),
//      body:  Container(
//        child: Center(
//            child: new Column(
//              // crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                SizedBox(height: 70.0,),
//                Text('나의 14일간의 여정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),
//                Text("잊지말고 쓰자", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//                SizedBox(height: 10.0,),
//
//                Expanded(
//                  child:  _buildBody(context),
//                )
//              ],
//            )
//        ),
//      ),//_buildBody(context),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color.fromARGB(255, 10, 30, 107),
//        tooltip: 'Add',
//        child: new Icon(Icons.add,),
//        //backgroundColor: new Color(0xFFF44336),
//        onPressed: () {
//          Firestore.instance.collection('handongsam').document(name).updateData({'total_day': FieldValue.increment(1)});
//          getData() async {
//            return await Firestore.instance.collection('handongsam').getDocuments();
//          }
//
//          getData().then((val){
//            if(val.documents.length > 0){
//              int i = 0;
//              for(i = 0 ; i < val.documents.length; ++ i){
//                if(val.documents[i].documentID==name){
//                  print("toal_day !!!!! "+val.documents[i].documentID);
//                  if(val.documents[i].data["total_day"] != null){
//                    globals.day = val.documents[i].data["total_day"];
//                    print("day : "+globals.day.toString());
//                  }
//                }
//              }
//            }
//            else{
//              print("Not Found");
//            }
//          });
//
//          Navigator.push(context, MaterialPageRoute(
//              builder: (context) => AddPage()));
//        } ,
//        //child: Icon(Icons.navigation),
//        //backgroundColor: Colors.green,
//      ),
//
//    );
//  }
//
//
//  //일단 uid 하드코딩  나중에는 Firebase에서 uid를  받아서 진행 로그인해서 uid보고 다이어리 보여줌
//  // 그냥 userUID로 하는 게 맞는 것인가...?//맞다@@@@@@!!ㅎㅎㅎㅎㅎㅎ 오케잉!!!!!!
//  //int total_day;
//  //= Firestore.instance.collection('handongsam').document(name).total_day;
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('handongsam').document(name).collection('diary').orderBy('day', descending: true).snapshots(), //정
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
//    String wwater='안먹음';
//    if(record.withwater==true){
//      wwater='먹음';
//    }
//    return Padding(
//      key: ValueKey(record.stress.toString()),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//
//
//
//        child: ListTile(
//          leading: Text( record.day.toString()+'일차',style: TextStyle(color: Colors.black, fontSize: 22.0,
//              fontWeight: FontWeight.w500)),
//
//          title: Text('유산균 : '+ wwater),
//          subtitle: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Text('배번 활동 : ' +record.bowelMovement.toString()),
//              Text('배번 타입 : ' + record.bowelType.toString()),
//            ],
//          ),
//          isThreeLine: true,
//          dense: true,
//          onTap:()=> _showInfo(record),
//        ),
//      ),
//    );
//  }
//
//  void _showInfo(record) {
//    String wwater='안 먹었어요';
//    String bowelM='안 했어요';
//    String drinK='술 안 마셨어요!';
//    String bowelType = '없어요';
//
//    //drink
//    if(record.withwater==true){
//      wwater='먹었어요!';
//    }
//    if(record.drink==true){
//      bowelM='했어요!';
//    }
//    if(record.bowelMovement==true){
//      drinK='술 마셨어요!';
//    }
//    if(record.bowelType !=0){
//      bowelType=record.bowelType.toString()+'이에요';
//    }
//
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: new Text('D+' + record.day.toString(),
//              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0) ),
//            content: SingleChildScrollView(
//              child: Column(
//                children: <Widget>[
//                  new Text( '< 상세정보 >',
//                      style: TextStyle(
//                          fontSize: 18, fontWeight: FontWeight.w500)),
//                  SizedBox(height:3),
//                  Row(
//                    children: <Widget>[
//
//                      //Image(image: NetworkImage(record.url),  height: 170, width: 130),
//                      SizedBox(width: 10,),
//                      new Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Text('유산균 : ' +wwater,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('배변활동 : '+bowelM,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//
//                          new Text('배변타입 : '+bowelType,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('배변감 : ' + record.feeling.toString()+'이에요',
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('수면시간 : '+ record.sleephours.toString()+'시간 잤어요! ',
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('스트레스 : 스트레스 지수가 '+ record.stress.toString()+'이에요!',
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('음주 : '+ drinK,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          new Text('식사 : 아침-'+record.breakfast,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//                          Text(' 점심-'+record.lunch+' 저녁-'+record.dinner,
//                            style: TextStyle(fontWeight: FontWeight.w500),),
//
//                        ],),
//                    ],
//                  ),
//                  SizedBox(height: 25,),
//                  new Text('물에 타면 깨어나는 유산균',
//                    style: TextStyle(fontWeight: FontWeight.bold),),
//
//                  //SizedBox(height: 5,),
//                  new Text('___________________________________________'),
//                  Text('작성일 : '+record.currentTime),
//
//
//                ],
//              ),
//            ),
////            actions: <Widget>[
////              FlatButton(child: Text("확인"),
////                onPressed: _showDialog,
////              ),
////            ],
//          );
//        }
//    );
//  }
//
//
//
//}
//
//
//
//
////Text('유산균 먹은지 '+record.day.toString()+'일차~^^'),


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'add.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'MyPage.dart';
import 'main_time.dart';
import 'second.dart';
String name = userUID;


class DiaryPage extends StatefulWidget {
  @override
  _MyDiaryPageState createState() {
    return _MyDiaryPageState();
  }
}

class _MyDiaryPageState extends State<DiaryPage> {



  launchURL() {
    launch('https://handongsam.com/probiotics');}

  @override
  Widget build(BuildContext context) {
    return Scaffold(      bottomNavigationBar: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart), color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
          launchURL();
        },),
        IconButton(icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 10, 30, 107),),
          onPressed: () {
          },),
        IconButton(icon: Image(image: AssetImage("assets/1.png")), onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return  TimePage(); // alarm page.
              },
            ),
          );
        },),
        IconButton(icon: Icon(Icons.person,color: Color.fromARGB(255, 10, 30, 107)),onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return  MyPages(); // alarm page.//
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
                return HomePage(); // alarm page.
              },
            ),
          );

        },),
      ],),
      //appBar: AppBar(title: Text('Diary')),
      body:  Container(
        child: Center(
            child: new Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70.0,),
                Text('나의 14일간의 여정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),
                Text("잊지말고 쓰자", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
                SizedBox(height: 10.0,),

                Expanded(
                  child:  _buildBody(context),
                )
              ],
            )
        ),
      ),//_buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 10, 30, 107),
        tooltip: 'Add',
        child: new Icon(Icons.add,),
        //backgroundColor: new Color(0xFFF44336),
        onPressed: () {
          Firestore.instance.collection('handongsam').document(name).updateData({'total_day': FieldValue.increment(1)});
          getData() async {
            return await Firestore.instance.collection('handongsam').getDocuments();
          }

          getData().then((val){
            if(val.documents.length > 0){
              int i = 0;
              for(i = 0 ; i < val.documents.length; ++ i){
                if(val.documents[i].documentID==name){
                  if(val.documents[i].data["total_day"] != null){
                    globals.day = val.documents[i].data["total_day"];
                    print("day : "+globals.day.toString());
                  }
                }
              }
            }
            else{
              print("Not Found");
            }
          });

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddPage()));
        } ,
        //child: Icon(Icons.navigation),
        //backgroundColor: Colors.green,
      ),

    );
  }


  //일단 uid 하드코딩  나중에는 Firebase에서 uid를  받아서 진행 로그인해서 uid보고 다이어리 보여줌
  // 그냥 userUID로 하는 게 맞는 것인가...?//맞다@@@@@@!!ㅎㅎㅎㅎㅎㅎ 오케잉!!!!!!
  //int total_day;
  //= Firestore.instance.collection('handongsam').document(name).total_day;

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('handongsam').document(name).collection('diary').orderBy('day', descending: true).snapshots(), //정
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }


  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    String wwater='안 먹었어요';
    String bowelMovement = '안 했어요';
    String bowelType = '없어요';
    if(record.bowelType !=0){
      bowelType=' 배변 타입이 \"'+record.bowelType.toString()+'\" 이에요';
    }
    if(record.withwater==true){
      wwater='먹었어요!';
    }
    if(record.bowelMovement==true){
      bowelMovement='했어요!';
    }
    return Padding(
      key: ValueKey(record.stress.toString()),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),



        child: ListTile(
          leading: Text( record.day.toString()+'일차',style: TextStyle(color: Colors.black, fontSize: 24.0,
              fontWeight: FontWeight.w500)),

          title: Text('유산균 : '+ wwater,style: TextStyle(color: Colors.black, fontSize: 19.0,
              fontWeight: FontWeight.w500)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('배번 활동 : ' + bowelMovement,style: TextStyle(color: Colors.black, fontSize: 15.0,
                  fontWeight: FontWeight.w500)),
              Text('배번 타입 : ' + bowelType,style: TextStyle(color: Colors.black, fontSize: 15.0,
                  fontWeight: FontWeight.w500) ),
            ],
          ),
          isThreeLine: true,
          dense: true,
          onTap:()=> _showInfo(record),
        ),
      ),
    );
  }

  void _showInfo(record) {
    String wwater='안 먹었어요';
    String bowelM='안 했어요';
    String drinK='술 안 마셨어요!';
    String bowelType = '없어요';

    //drink
    if(record.withwater==true){
      wwater='먹었어요!';
    }
    if(record.drink==true){
      bowelM='했어요!';
    }
    if(record.bowelMovement==true){
      drinK='술 마셨어요!';
    }
    if(record.bowelType !=0){
      bowelType=record.bowelType.toString()+'이에요';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('D+' + record.day.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0) ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new Text( '< 상세정보 >',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height:3),
                  Row(
                    children: <Widget>[

                      //Image(image: NetworkImage(record.url),  height: 170, width: 130),
                      SizedBox(width: 10,),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('유산균 : ' +wwater,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('배변활동 : '+bowelM,
                            style: TextStyle(fontWeight: FontWeight.w500),),

                          new Text('배변타입 : '+bowelType,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('배변감 : ' + record.feeling.toString()+'이에요',
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('수면시간 : '+ record.sleephours.toString()+'시간 잤어요! ',
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('스트레스 : 스트레스 지수가 '+ record.stress.toString()+'이에요!',
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('음주 : '+ drinK,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          new Text('식사 : 아침-'+record.breakfast,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                          Text(' 점심-'+record.lunch+' 저녁-'+record.dinner,
                            style: TextStyle(fontWeight: FontWeight.w500),),

                        ],),
                    ],
                  ),
                  SizedBox(height: 25,),
                  new Text('물에 타면 깨어나는 유산균',
                    style: TextStyle(fontWeight: FontWeight.bold),),

                  //SizedBox(height: 5,),
                  new Text('_______________________________________'),
                  Text('작성일 : '+record.currentTime),


                ],
              ),
            ),
//            actions: <Widget>[
//              FlatButton(child: Text("확인"),
//                onPressed: _showDialog,
//              ),
//            ],
          );
        }
    );


  }



}




//Text('유산균 먹은지 '+record.day.toString()+'일차~^^'),