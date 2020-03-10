import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seek.dart';
import 'record.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
    ),
    title: '네비게이션',
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('시작화면')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(height: 150, width: 300, decoration: BoxDecoration(border: Border.all(color: Colors.lightGreen,)),
              child: RaisedButton(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('분실물 등록', style: TextStyle(fontSize: 27, color: Colors.lightGreen, fontWeight: FontWeight.bold)),
                    Text('잃어버린 물건을 습득하셨나요?', style: TextStyle(color: Colors.lightGreen),)
                  ],
                ),
                color: Colors.white,
                onPressed: () {
                  // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return BoonSilMool();
                      })
                  );
                },
              ),
            ),
            Container(height: 150, width: 300,
              child: RaisedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('분실물 찾기', style: TextStyle(fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('잃어버린 물건이 있으신가요?', style: TextStyle(color: Colors.white),),
                  ],
                ),
                color: Colors.lightGreen,
                onPressed: () {
                  // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return MyseekPage();
                      })
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class BoonSilMool extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Enroll('분실물 등록')
    );
  }
}

class Enroll extends StatefulWidget {
  final String title;
  Enroll(this.title) : super();

  @override
  _EnrollState createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  File _image;

  String _date = "선택해주세요";
  String _time = "선택해주세요";

  @override
  void initState() {
    super.initState();
  }

  final thing = TextEditingController();
  final explain = TextEditingController();
  final etc = TextEditingController();
  final name = TextEditingController();
  final phone_number = TextEditingController();

  getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('분실물 등록'),
            content: Text('물건을 분실물로 등록하시겠습니까?'),
            actions: <Widget>[
              FlatButton(child: Text("No"),
                onPressed: () {
                  // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return FirstPage();
                      })
                  );
                },
              ),
              FlatButton(child: Text("Yes"),
                onPressed: () {
                  // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return FirstPage();
                      })
                  );
                }, // save
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.title,
            style: TextStyle(color: Colors.white),)
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          new SizedBox(height: 20,),
          new Text("분실물 정보 입력>", style: TextStyle(fontSize: 20)),
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(
              children: [
                new SizedBox(width:20.0,),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Container(height: 160, width: 140,
                      decoration: BoxDecoration(border: Border.all()),
                      child: new FlatButton(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        onPressed: getCameraImage,
                        child: _image == null
                            ? Icon(Icons.add_a_photo)
                            : Image.file(_image, height: 160, width: 140),)
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(13.0),
                  child:
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('물건명'),
                      new SizedBox(height: 25, width: 165,
                        child: new TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller:thing,
                        ),
                      ),
                      new SizedBox(height: 5,),
                      new Text('습득 장소'),
                      new Container(decoration: BoxDecoration(border: Border.all()), height: 17, width: 165,
                        child: new FlatButton(
                          onPressed: () => getCameraImage, //goToMap
                          padding: EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: new Text(''),),
                      ),
                      new SizedBox(height: 5,),
                      new Text('물건 설명'),
                      new SizedBox(height: 50, width: 165,
                        child: new TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller:explain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(left: 45.0, bottom: 5.0,),
                  child: new Text('기타 전달 사항')),
            ],
          ),
          new SizedBox(height: 50.0, width: 320,
              child: new TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller:etc,
              )
          ),
          new SizedBox(height: 10,),
          new Text('ㅡ'*29),
          new SizedBox(height: 10,),
          new Text("작성자 정보 입력>", style: TextStyle(fontSize: 20)),
          new Padding(
            padding: const EdgeInsets.only(top:10.0,left: 30.0, right: 30.0),
            child: new SizedBox(height: 40.0,
              child: new TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.perm_identity),
                  labelText: '작성자 이름',
                ),
                controller:name,
              ),
            ),
          ),
          new SizedBox(height: 5,),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: new SizedBox(height: 40.0,
              child: new TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.phone),
                  labelText: '작성자 연락처',
                ),
                controller:phone_number,
              ),
            ),
          ),
          new SizedBox(height: 5,),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: new SizedBox(height: 40.0,
              child: Row(
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(containerHeight: 210.0,),
                            showTitleActions: true,
                            minTime: DateTime(2019,1,1),
                            maxTime: DateTime(2022,12,31), onConfirm: (date){
                              print('confirm $date');
                              _date= '${date.year} 년 ${date.month} 월 ${date.day} 일';
                              setState(() {});
                            }, currentTime: DateTime.now(), locale: LocaleType.ko);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(child: Row(
                                children: <Widget>[
                                  Icon(Icons.date_range, size: 22.0, color: Colors.grey,),
                                  Text("  $_date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.0),)
                                ],
                              ),)
                            ],),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    new FlatButton(onPressed: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                            print('confirm $time');
                            _time = '  ${time.hour} 시 ${time.minute}분';
                            setState(() {});
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                      setState(() {});
                    },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.access_time, size: 22.0, color: Colors.grey,
                                        ),
                                        Text(
                                          "  $_time",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          color: Colors.white,)
                    ),
                  ]
              ),
            ),
          ),
          new SizedBox(height: 10.0,),
          new RaisedButton(onPressed: _showDialog,
              padding: EdgeInsets.all(10.0),
              color: Colors.lightGreen,
              child: new Text('분실물 등록', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
