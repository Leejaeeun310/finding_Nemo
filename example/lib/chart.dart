import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String name = userUID;
class ChartPage extends StatefulWidget{
  ChartPage({Key key}) : super(key: key);
  _ChartPageState createState() => _ChartPageState();

}
class _ChartPageState extends State<ChartPage>{

  List<charts.Series<Record, String>> _seriesBarData;
  List<Record> myData;
  _generateData(myData){
    _seriesBarData.add(
      charts.Series(
        domainFn: (Record day,_) =>  day.day.toString(), // 예시에서는 이게 year인데,, 우리는 여기서 다이어리 아이디임...
        measureFn: (Record day,_) => day.stress,
        colorFn: (Record day,_) => charts.ColorUtil.fromDartColor(Colors.white),
        id:  'Record',
        data: myData,
        labelAccessorFn :(Record row,_)=>"${row.stress}"
      )
    );
  }

  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title : Text('stress'),),
      body:  _buildBody(context),
    );
  }
  Widget _buildBody(context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('handongsam').document(name).collection('diary').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }
        else{
          List<Record> record = snapshot.data.documents.map((documentSnapshot) => Record.fromMap(documentSnapshot.data, documentSnapshot.documentID)).toList();
          return _buildCart(context, record);
        }
      },
    );
  }
  Widget _buildCart(BuildContext context, List<Record> record){
    myData = record;
    _generateData(myData);
    return Padding(
      padding: EdgeInsets.all(9.0),
      child: Container(
        child:  Center(
          child: Column(
            children: <Widget>[
              Text("stress"),
            SizedBox(height : 10.0),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                animate: true,
                animationDuration: Duration(seconds : 5),
                ),
              )

            ],
          ),
        ),
      ),
    );

  }
}