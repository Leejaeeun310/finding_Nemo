
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:async';
//import 'package:path/path.dart';
import 'diary.dart';
import 'record.dart';
import 'package:date_format/date_format.dart';
import 'globals.dart' as globals;
//import 'dart:io';
//import 'package:image_picker/image_picker.dart';
//File _image;


enum Type { Type1, Type2, Type3,Type4,Type5,Type6,Type7 } //배변 활동 type
String name = userUID;

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage>{

  String url = 'http://handong.edu/site/handong/res/img/logo.png';
  FirebaseStorage storage = FirebaseStorage.instance ;

  bool withwater1 = false;
  bool drink1 = false;
  bool bowelM = false;
  String breakfast = '안먹음';
  String dinner = '안먹음';
  String lunch = '안먹음';
  int type=0; //배변타입//음.... Type 데이터 타입을 어떻게 파이어베이스에 저장할 지 아직 모르겠음 그래서 대충이렇게 해놓고 만약에 배변활동을 안했으면 - 0
  int stress = 1;
  int feeling = 1;
  int sleep = 1;
  bool _isExpanded1 = false; // true로 하기 //각 listView를 접고 열기 위해서
  Type bowelType = Type.Type1;
  String c_time; //작성시간
  final _sleephours  = TextEditingController(); //수면시간
  int day=globals.day+1; // 이거는 1일차 2일차 3일차를 나타내는 건데, total_day를 update해서 적용 하면 된다. 이미 합해진 차수에서 +1해야함.

  void _withwaterChanged1(bool value) => setState(() => withwater1 = value);
  void _drinkChanged1(bool value) => setState(() => drink1 = value);
  void __bowelMChanged1(bool value) => setState(() => bowelM = value);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

//                Center(
//                  child: Text('다이어리 작성',
//                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 10, 30, 107),),
//                  ),
//                ),
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
                  //padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
//                  child: GestureDetector(
////                    onTap: (){
////                      print('취소');
////                      Navigator.push(context,
////                          MaterialPageRoute<void>(builder: (BuildContext context) {
////                            return DiaryPage();
////                          })
////                      );
////                      //Navigator.of(context).pop();
////                    },
//                    child: Container(
//                        child: Text('취소',
//                            style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 14.0,
//                                fontWeight: FontWeight.w500))),
//                  ),
                ),

                Center(
                 child: Text('다이어리 작성',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),

//                  Text('다이어리 작성',
//                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40.0,color: Color.fromARGB(255, 10, 30, 107),),
//                  ),
                ),
                FlatButton(
                  onPressed: () {


                    print(name);

                    //print('_day : $record.day');

                    Map<String, dynamic> product = {
                      'withwater': withwater1, //bool
                      'drink' : drink1, //bool
                      'bowelMovement' : bowelM, //bool
                      'breakfast' : breakfast,
                      'lunch' : lunch,
                      'dinner' :dinner,
                      'bowelType' : type,
                       'stress' : stress,
                      'feeling' : feeling,
                      'sleephours' : sleep,//int.parse(_sleephours.text),//sleep,//int.parse(_sleephours.text),
                      'day' : globals.day,
                      'currentTime': c_time = formatDate(DateTime.now(), [yyyy,'.', mm,'.', dd, '.', hh, ':', nn, ':', ss]),



                    };
                    Firestore.instance.collection('handongsam').document(name).collection('diary').document('day$day').setData(product);
                    print(name+name);
                    // Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DiaryPage();
                          },
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text('저장',
                        style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 15.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  //color: Colors.blue[300],
                ),

              ]
          ),




          Center(
              child:
              Image.asset("assets/1.png"),
          ),

          Padding(
            padding:EdgeInsets.fromLTRB(300, 0, 0, 0),
            child: IconButton(
              icon: Icon(Icons.photo_camera),
              color: Color.fromARGB(255, 10, 30, 107),
              onPressed: (){
                print('hi');


              },
            ),
          ),

          SizedBox (height: 20.0),

          Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new SwitchListTile(
                    value: withwater1,
                    activeColor: Color.fromARGB(255, 10, 30, 107),
                    onChanged: _withwaterChanged1,
                    title: new Text('유산균 ', style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                  ),

                  new SwitchListTile(
                    value: drink1,
                    onChanged: _drinkChanged1,
                    activeColor: Color.fromARGB(255, 10, 30, 107),
                    title: new Text('음주 ', style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                  ),
                  new SwitchListTile(
                    value: bowelM,
                    onChanged: __bowelMChanged1,
                    activeColor: Color.fromARGB(255, 10, 30, 107),
                    title: new Text('배변활동 ', style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('아침 식사',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: breakfast,
                            //icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
//                            style: TextStyle(
//                                color: Colors.deepPurple
//                            ),
//                            underline: Container(
//                              height: 2,
//                              color: Colors.deepPurpleAccent,
//                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                breakfast = newValue;
                                //_buildBody(context);
                                //if(dropdownValue=='Asc') print('Asc');
                              });
                            },
                            items: <String>['안먹음', '시리얼 또는 선식', '패스트 푸드', '채식 위주 반찬', '탄수화물 위주 반찬','지방 위주 반찬','단백질 위주 반찬']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                              );
                            })
                                .toList(),
                          ),
                        ),


                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('점심 식사',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: lunch,
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                lunch = newValue;
                 
                              });
                            },
                            items: <String>['안먹음', '시리얼 또는 선식', '패스트 푸드', '채식 위주 반찬', '탄수화물 위주 반찬','지방 위주 반찬','단백질 위주 반찬']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                              );
                            })
                                .toList(),
                          ),
                        ),


                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('저녁 식사',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: dinner,
                            iconSize: 24,
                            elevation: 16,
//                        
                            onChanged: (String newValue) {
                              setState(() {
                                dinner = newValue;
                              });
                            },
                            items: <String>['안먹음', '시리얼 또는 선식', '패스트 푸드', '채식 위주 반찬', '탄수화물 위주 반찬','지방 위주 반찬','단백질 위주 반찬']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                              );
                            })
                                .toList(),
                          ),
                        ),


                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('스트레스 지수',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        ),
                        Text('적음'),
                        Expanded(
                            child:Slider(
                              value: stress.toDouble(),
                              min: 1.0,
                              max: 5.0,
                              //divisions: 4,
                              activeColor: Color.fromARGB(255, 10, 30, 107),
                              inactiveColor: Colors.black,
                              onChanged: (double newStress) {
                                setState(() {
                                  stress = newStress.round();
                                });

                              },
                              label: '$stress',
                            )
                        ),
                        Text('많음'),
                        Text(' = ${(stress*1).round()}',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        
                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('수면시간',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        ),
//                        Expanded(
//                            child: TextField(
//                              decoration: InputDecoration(
//                                //border: OutlineInputBorder(),
//                                labelText: '수면시간',
//                              ),
//                              controller:_sleephours,
//                            ),
//                        ),
                        Text('1시간'),
                        Expanded(
                            child:Slider(
                              value: sleep.toDouble(),
                              min: 1.0,
                              max: 24.0,
                              //divisions: 4,
                              activeColor: Color.fromARGB(255, 10, 30, 107),
                              inactiveColor: Colors.black,
                              onChanged: (double newStress) {
                                setState(() {
                                  sleep = newStress.round();
                                });
                              },
                              label: '$sleep',
                            )
                        ),
                        Text('24시간'),
                        Text(' ${(sleep*1).round()}',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),





                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('배변감',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)), //feeling
                        ),
                        Text('불편함',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        Expanded(
                            child:Slider(
                              value: feeling.toDouble(),
                              min: 1.0,
                              max: 5.0,
                              //divisions: 4
                              activeColor: Color.fromARGB(255, 10, 30, 107),
                              inactiveColor: Colors.black,

                              onChanged: (double newStress) {
                                setState(() {
                                  feeling = newStress.round();
                                });
                              },
                              label: '$feeling',
                            )
                        ),
                       Text('편함',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),
                        Text(' = ${(feeling*1).round()}',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),




                      ]
                  ),
                  Text('배변타입',style: new TextStyle( color: Colors.black,fontWeight: FontWeight.w500)),

                  Row(
                      children: <Widget>[
                      Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type1.png"),
                            value: Type.Type1,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                            setState(() {
                                type = 1;
                                bowelType = value;
                        });
                      },
                    ),
                  ),
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type2.png"),
                            value: Type.Type2,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 2;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type3.png"),
                            value: Type.Type3,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 3;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type4.png"),
                            value: Type.Type4,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 4;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type5.png"),
                            value: Type.Type5,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 5;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type6.png"),
                            value: Type.Type6,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 6;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type7.png"),
                            value: Type.Type7,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 7;
                                bowelType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title:  Image.asset("assets/type7.png"),
                            value: Type.Type7,
                            groupValue: bowelType,
                            onChanged: (Type value) {
                              setState(() {
                                type = 7;
                                bowelType = value;
                              });
                            },
                          ),
                        ),

                      ]),


                ],

              )
          )
        ],

      ),

    );
  }
}



//appBar: AppBar(
//        backgroundColor: Colors.white,//fromARGB(255, 10, 30, 107),
//        //brightness: Brightness.light,
//        title: Center(
//          child: Text('다이어리 작성',
//            textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 10, 30, 107),),
//          ),
//        ),
//        leading:Padding(
//          padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
//          child: GestureDetector(
//            onTap: (){
//              print('취소');
//              Navigator.push(context,
//                  MaterialPageRoute<void>(builder: (BuildContext context) {
//                    return DiaryPage();
//                  })
//              );
//              //Navigator.of(context).pop();
//            },
//            child: Container(
//                child: Text('취소',
//                    style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 14.0,
//                        fontWeight: FontWeight.w500))),
//          ),
//        ),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//
//
//              print(name);
//
//              //print('_day : $record.day');
//
//              Map<String, dynamic> product = {
//                'withwater': withwater1, //bool
//                'drink' : drink1, //bool
//                'bowelMovement' : bowelM, //bool
//                'breakfast' : breakfast,
//                'lunch' : lunch,
//                'dinner' :dinner,
//                'bowelType' : type,
//                'stress' : stress,
//                'feeling' : feeling,
//                'sleephours' : sleep,//int.parse(_sleephours.text),//sleep,//int.parse(_sleephours.text),
//                'day' : globals.day,
//                'currentTime': c_time = formatDate(DateTime.now(), [yyyy,'.', mm,'.', dd, '.', hh, ':', nn, ':', ss]),
//
//
//
//              };
//              Firestore.instance.collection('handongsam').document(name).collection('diary').document().setData(product);
//              print(name+name);
//             // Navigator.of(context).pop();
//            },
//            child: Padding(
//              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//              child: Text('저장',
//                  style: TextStyle(color: Color.fromARGB(255, 10, 30, 107), fontSize: 15.0,
//                      fontWeight: FontWeight.w500)),
//            ),
//            //color: Colors.blue[300],
//          ),
//        ],
//      ),

