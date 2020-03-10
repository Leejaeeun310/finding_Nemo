import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MyPage.dart';
import 'package:gender_selector/gender_selector.dart';
import 'record.dart';
import 'main_time.dart';

String username = userUID;
class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>{
  String name;
  String gender1 = 'male';



  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final gender = GenderSelector();



  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title:  Center(
          child: Text('정보입력',
            textAlign: TextAlign.start,
          ),
        ),
        leading:Padding(
          padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
          child: GestureDetector(
            onTap: (){
              print('cancel');
              Navigator.of(context).pop();
            },
            child: Container(
                child: Text('Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 10, 30, 107),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal))),
          ),
        ),

      ),
      body: ListView(
        children: <Widget>[

          SizedBox (height: 30.0),

          Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: '이름',
                      fillColor: Color(0x00000000),
                    ),
                  ),

                  SizedBox(height: 30.0),

                  Text(
                    '  성별',
                    style: TextStyle(color:Colors.black45, fontSize: 16),
                  ),
                  GenderSelector(
                    onChanged: (gender) {
                      if(gender==Gender.FEMALE){
                        gender1 = 'female';
                      }
                    },
                  ),

                  SizedBox(height: 30.0),

                  TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: '몸무게 (kg)',
                      fillColor: Color(0x00000000),
                    ),
                  ),

                  SizedBox(height: 30.0),

                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: '키 (cm)',
                      fillColor: Color(0x00000000),
                    ),
                  ),

                  SizedBox(height: 30.0),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('저장'),
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          print('save');
                          Map<String, dynamic> handongsam = {
                            'name': _nameController.text,
                            'gender': gender1,
                            'weight': int.parse(_weightController.text),
                            'height': int.parse(_heightController.text),
                            'total_day' : 0,
                          };

                          Firestore.instance.collection('handongsam').document(username).setData(handongsam);
                          print(username+username);
                          // Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TimePage();
                                },
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              )
          )
        ],

      ),

    );
  }

}


