import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'task.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'record.dart';
String name = userUID;
class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() {
    return _TaskHomePageState();
  }
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<charts.Series<Task, String>> _seriesPieData;
  List<Task> mydata;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.day.toString()+'일차',
        measureFn: (Task task, _) => task.stress,

        id: 'day',
        data: mydata,
        labelAccessorFn: (Task row, _) => "${row.stress}",
      ),
    );
  }
// Firestore.instance.collection('handongsam').document(name).collection('diary').document('day$day').setData(product);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('스트레스 지수 변화 ',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('handongsam').document(name).collection('diary').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Task> task = snapshot.data.documents
              .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, task);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<Task> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('배변활동은 스트레스 영향을 받아요!!', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),


              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                        new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
//                    defaultRenderer: new charts.ArcRendererConfig(
//                        arcWidth: 100,
//                        arcRendererDecorators: [
//                          new charts.ArcLabelDecorator(
//                              labelPosition: charts.ArcLabelPosition.inside)
//                        ])
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}