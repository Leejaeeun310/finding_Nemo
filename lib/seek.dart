import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';

//Image.asset('assets/hgu.png'),

class MyseekPage extends StatefulWidget {
  @override
  _MyseekPageState createState() {
    return _MyseekPageState();
  }
}

class _MyseekPageState extends State<MyseekPage> {
  String url = 'http://handong.edu/site/handong/res/img/logo.png'; // default value
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('분실물 찾기')),
        //body: _buildBody(context)//Column(
      body: Container(
        child: Center(
            child: new Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/hgu.png'),
                SizedBox(height: 10.0,),
                Expanded(
                  child:  _buildBody(context),
                )
              ],
            )
        ),
      ),
//          children: <Widget>[
//            Center(
//              child: Image.asset('assets/hgu.png'),
//
//
//            ),
//            _buildBody(context),
//          ],
//
//        )
      //_buildBody(context),

    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sw_sle_app').snapshots(),
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
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // Image.asset('assets/hgu.png'),
      child: Container(
        decoration: BoxDecoration(


          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(

          leading:  Image(image: NetworkImage(record.url), width: 50.0, height: 50.0, fit: BoxFit.fill,),
          title : Text(record.name,style: TextStyle(color: Colors.black, fontSize: 20.0,
              fontWeight: FontWeight.normal)),
          subtitle :Text(record.detail,style:  TextStyle(color: Colors.black, fontSize: 15.0,
              fontWeight: FontWeight.normal)),
          onTap:()=> _showInfo(record),

    ),
    ),
    );
  }
  void _showInfo(record) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('물건 정보 확인',),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new Text("분실물 정보 >",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height:3),
                  Row(
                    children: <Widget>[

                      Image(image: NetworkImage(record.url),  height: 170, width: 130),
                      SizedBox(width: 10,),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text('물건명',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                          new Container(width:130,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: new Text(record.name),),
                          new Text('습득 장소',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                          new Container(width:130,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: new Text(record.location)),
                        ],),
                    ],
                  ),
                  new Text('물건 설명',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  new Container(width:250,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: new Text(record.detail)),
                  SizedBox(height: 5,),
                  Text('기타 전달 사항'),
                  new Container(width: 250,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: new Text(record.other)),
                  new Text('ㅡ'*19),
                  new Text("작성자 정보 >",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  new SizedBox(height: 40.0,
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.perm_identity),
                        new SizedBox(width: 5.0,),
                        new Text(record.writer)
                      ],
                    ),
                  ),
                  new SizedBox(height: 40.0,
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.phone),
                        new SizedBox(width: 5.0,),
                        new Text(record.phonum),
                      ],
                    ),
                  ),
                  new SizedBox(height: 40.0,
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.calendar_today),
                        new SizedBox(width: 5.0,),
                        new Text(record.date)
                      ],
                    ),
                  ),
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



