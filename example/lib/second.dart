//import 'dart:async';
//import 'dart:io';
//import 'dart:typed_data';
//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
//import 'globals.dart' as globals;
//import 'main_time.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'record.dart' as variable;
//
//FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
///// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
///// Please download the complete example app from the GitHub repository where all the setup has been done
//
//class PaddedRaisedButton extends StatelessWidget {
//  final String buttonText;
//  final VoidCallback onPressed;
//  const PaddedRaisedButton(
//      {@required this.buttonText, @required this.onPressed});
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
//      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
//    );
//  }
//}
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  var platform = MethodChannel('crossingthestreams.io/resourceResolver');
//  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//  launchURL() {
//    launch('https://handongsam.com/probiotics');}
//  @override
//  initState() {
//    super.initState();
//    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//    var initializationSettingsAndroid =
//        AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//  }
//
//
//  double takeInHour =0 ;
//  double takeInMinute = 0;
//  int takeInHour_noti =0;
//  int takeInMinute_noti = 0;
//
//  int diaryHour_noti =0;
//  int diaryMinute_noti = 0;
//
//
//
//  static DateTime now = DateTime.now();
//  Timer _everySecond;
//
//  Text takeIn = Text(globals.takeInHour.toString() +  " 시 " + globals.takeInminute.toString()+ " 분 ",
//    style: TextStyle(fontSize: 44), );
//
//  Text diary = Text(globals.diaryHour.toString() +  " 시 " + globals.diaryMinute.toString()+ " 분 ",
//    style: TextStyle(fontSize: 44), );
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      bottomNavigationBar: ButtonBar(
//        alignment: MainAxisAlignment.center,
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.shopping_cart), color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
//            launchURL();
//          },
//          ),
//          IconButton(icon: Icon(Icons.favorite_border,color: Color.fromARGB(255, 10, 30, 107),),),
//          IconButton(icon: Image(image: AssetImage("assets/1.png"))
//    , onPressed: () {
//    Navigator.push(context, MaterialPageRoute(
//    builder: (context) => TimePage()));
//    }),
//          IconButton(icon: Icon(Icons.person, color: Color.fromARGB(255, 10, 30, 107)),),
//          //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
//          IconButton(icon: Icon(Icons.alarm,
//              color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {
//
//
//          },),
//        ],),
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            SizedBox(height: 70.0,),
//
//            Text("댕댕댕 매일 매일 울리는", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//            Text('알람 설정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),
//
//
////            Row(
////                mainAxisSize: MainAxisSize.min,
////                children: <Widget>[
////                  Text("댕댕댕 매일 매일 울리는", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
////
////                  Text('알람 설정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),
////
////
////
////
////                ]
////
////            ),
//
//
//            SizedBox(height: 60,),
//
//           //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//
//            Text("유산균 마시는 시간", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.w500),)//style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.bold),
//            ,
//            //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//            SizedBox(height: 20,),
//            RaisedButton(
//              child: takeIn,
//              onPressed: () async {
//                TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now() );
//                if(selectedTime != null) {
//                  globals.takeInminute = selectedTime.minute;
//                  globals.takeInHour = selectedTime.hour;
//                  alarm_takeIn(); takeIn_noti();
//                  await Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({
//                    'alarm_time_hh':globals.takeInHour,
//                    'alarm_time_mm':globals.takeInminute
//                  });
//                }
//
//                setState(() {
//                  takeIn = Text(globals.takeInHour.toString() +  " : " + globals.takeInminute.toString(),
//                    style: TextStyle(fontSize: 50), );
//                });
//              },
//            ),
//            SizedBox(height: 60,),
//            //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//
//            Text("다이어리 쓰는 시간", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.w500),)
//            ,
//            SizedBox(height: 20,),
//            RaisedButton(
//              child: diary,
//              onPressed: () async {
//                TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now() );
//                if(selectedTime != null){
//                  globals.diaryMinute = selectedTime.minute;
//                  globals.diaryHour = selectedTime.hour;
//                  alarm_diary(); diary_noti();
//                  await Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({
//                    'diary_time_hh':globals.diaryHour,
//                    'diary_time_mm':globals.diaryMinute
//                  });
//                }
//
//                setState(() {
//                  diary = Text(globals.diaryHour.toString() +  " : " + globals.diaryMinute.toString(),
//                    style: TextStyle(fontSize: 50), );
//                });
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//
//  Future<void> _showNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithNoBody() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', null, platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _cancelNotification() async {
//    await flutterLocalNotificationsPlugin.cancel(0);
//  }
//
//  /// Schedules a notification that specifies a different icon, sound and vibration pattern
//  Future<void> _scheduleNotification() async {
//    var scheduledNotificationDateTime =
//        DateTime.now().add(Duration(seconds: 5));
//    var vibrationPattern = Int64List(4);
//    vibrationPattern[0] = 0;
//    vibrationPattern[1] = 1000;
//    vibrationPattern[2] = 5000;
//    vibrationPattern[3] = 2000;
//
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your other channel id',
//        'your other channel name',
//        'your other channel description',
//        icon: 'secondary_icon',
//        sound: 'slow_spring_board',
//        largeIcon: 'sample_large_icon',
//        largeIconBitmapSource: BitmapSource.Drawable,
//        vibrationPattern: vibrationPattern,
//        enableLights: true,
//        color: const Color.fromARGB(255, 255, 0, 0),
//        ledColor: const Color.fromARGB(255, 255, 0, 0),
//        ledOnMs: 1000,
//        ledOffMs: 500);
//    var iOSPlatformChannelSpecifics =
//        IOSNotificationDetails(sound: "slow_spring_board.aiff");
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.schedule(
//        0,
//        'scheduled title',
//        'scheduled body',
//        scheduledNotificationDateTime,
//        platformChannelSpecifics);
//  }
//
//  Future<void> _showNotificationWithNoSound() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'silent channel id',
//        'silent channel name',
//        'silent channel description',
//        playSound: false,
//        styleInformation: DefaultStyleInformation(true, true));
//    var iOSPlatformChannelSpecifics =
//        IOSNotificationDetails(presentSound: false);
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, '알람이 설정되었습니다.',
//        globals.takeInHour.toString() + " : "  + globals.takeInminute.toString(), platformChannelSpecifics);
//  }
//
//  Future<void> _cancel_message() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'silent channel id',
//        'silent channel name',
//        'silent channel description',
//        playSound: false,
//        styleInformation: DefaultStyleInformation(true, true));
//    var iOSPlatformChannelSpecifics =
//    IOSNotificationDetails(presentSound: false);
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, '알람이 지워졌습니다.',
//       '', platformChannelSpecifics);
//  }
//
//  Future<String> _downloadAndSaveImage(String url, String fileName) async {
//    var directory = await getApplicationDocumentsDirectory();
//    var filePath = '${directory.path}/$fileName';
//    var response = await http.get(url);
//    var file = File(filePath);
//    await file.writeAsBytes(response.bodyBytes);
//    return filePath;
//  }
//
//  Future<void> _checkPendingNotificationRequests() async {
//    var pendingNotificationRequests =
//        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//    for (var pendingNotificationRequest in pendingNotificationRequests) {
//      debugPrint(
//          'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
//    }
//    return showDialog<void>(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          content: Text(
//              '${pendingNotificationRequests.length} pending notification requests'),
//          actions: [
//            FlatButton(
//              child: Text('OK'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  Future<void> _cancelAllNotifications() async {
//    await flutterLocalNotificationsPlugin.cancelAll();
//  }
//
//  Future<void> onSelectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
//
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
//  }
//
//  Future<void> _showOngoingNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max,
//        priority: Priority.High,
//        ongoing: true,
//        autoCancel: false);
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
//        'ongoing notification body', platformChannelSpecifics);
//  }
//
//  Future<void> _repeatNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'repeating channel id',
//        'repeating channel name',
//        'repeating description');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
//        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
//  }
//
//  Future<void> _showDailyAtTime() async {
//    var time = Time(globals.takeInHour, globals.takeInminute, 0);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'repeatDailyAtTime channel id',
//        'repeatDailyAtTime channel name',
//        'repeatDailyAtTime description');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.showDailyAtTime(
//        0,
//        '유산균 먹으실 시간입니다!!',
//        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//        time,
//         platformChannelSpecifics);
//  }
//
//  Future<void> alarm_takeIn() async {
//    var time = Time(globals.takeInHour, globals.takeInminute, 0);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'repeatDailyAtTime channel id',
//        'repeatDailyAtTime channel name',
//        'repeatDailyAtTime description');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.showDailyAtTime(
//        0,
//        '유산균 먹으실 시간입니다!!',
//        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//        time,
//        platformChannelSpecifics);
//  }
//
//  Future<void> alarm_diary() async {
//    var time = Time(globals.diaryHour, globals.diaryMinute, 0);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'repeatDailyAtTime channel id',
//        'repeatDailyAtTime channel name',
//        'repeatDailyAtTime description');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.showDailyAtTime(
//        0,
//        '다이어리 작성 시간입니다!!',
//        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//        time,
//        platformChannelSpecifics);
//  }
//
//
//
//  Future<void> takeIn_noti() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, '유산균 알람 설정', globals.takeInHour.toString() + ":" + globals.takeInminute.toString(), platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//
//
//
//  Future<void> diary_noti() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, '다이어리 알람 설정', globals.diaryHour.toString() + ":" + globals.diaryMinute.toString(), platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//
//
//  Future<void> _showWeeklyAtDayAndTime() async {
//    var time = Time(10, 0, 0);
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'show weekly channel id',
//        'show weekly channel name',
//        'show weekly description');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//        0,
//        'show weekly title',
//        'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//        Day.Monday,
//        time,
//        platformChannelSpecifics);
//  }
//
//  Future<void> _showNotificationWithNoBadge() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'no badge channel', 'no badge name', 'no badge description',
//        channelShowBadge: false,
//        importance: Importance.Max,
//        priority: Priority.High,
//        onlyAlertOnce: true);
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'no badge title', 'no badge body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showProgressNotification() async {
//    var maxProgress = 5;
//    for (var i = 0; i <= maxProgress; i++) {
//      await Future.delayed(Duration(seconds: 1), () async {
//        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//            'progress channel',
//            'progress channel',
//            'progress channel description',
//            channelShowBadge: false,
//            importance: Importance.Max,
//            priority: Priority.High,
//            onlyAlertOnce: true,
//            showProgress: true,
//            maxProgress: maxProgress,
//            progress: i);
//        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//        var platformChannelSpecifics = NotificationDetails(
//            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//        await flutterLocalNotificationsPlugin.show(
//            0,
//            'progress notification title',
//            'progress notification body',
//            platformChannelSpecifics,
//            payload: 'item x');
//      });
//    }
//  }
//
//  Future<void> _showIndeterminateProgressNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'indeterminate progress channel',
//        'indeterminate progress channel',
//        'indeterminate progress channel description',
//        channelShowBadge: false,
//        importance: Importance.Max,
//        priority: Priority.High,
//        onlyAlertOnce: true,
//        showProgress: true,
//        indeterminate: true);
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'indeterminate progress notification title',
//        'indeterminate progress notification body',
//        platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithUpdatedChannelDescription() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id',
//        'your channel name',
//        'your updated channel description',
//        importance: Importance.Max,
//        priority: Priority.High,
//        channelAction: AndroidNotificationChannelAction.Update);
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'updated notification channel',
//        'check settings to see updated channel description',
//        platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  String _toTwoDigitString(int value) {
//    return value.toString().padLeft(2, '0');
//  }
//
//  Future<void> onDidReceiveLocalNotification(
//      int id, String title, String body, String payload) async {
//    // display a dialog with the notification details, tap ok to go to another page
//    await showDialog(
//      context: context,
//      builder: (BuildContext context) => CupertinoAlertDialog(
//        title: title != null ? Text(title) : null,
//        content: body != null ? Text(body) : null,
//        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
//            },
//          )
//        ],
//      ),
//    );
//  }
//}
//
//class SecondScreen extends StatefulWidget {
//  SecondScreen(this.payload);
//
//  final String payload;
//
//  @override
//  State<StatefulWidget> createState() => SecondScreenState();
//}
//
//class SecondScreenState extends State<SecondScreen> {
//  String _payload;
//  @override
//  void initState() {
//    super.initState();
//    _payload = widget.payload;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Second Screen with payload: ${(_payload ?? '')}'),
//      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
//      ),
//    );
//  }
//}
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'globals.dart' as globals;
import 'main_time.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart' as variable;
import 'diary.dart';
import 'MyPage.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
/// Please download the complete example app from the GitHub repository where all the setup has been done

class PaddedRaisedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const PaddedRaisedButton(
      {@required this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var platform = MethodChannel('crossingthestreams.io/resourceResolver');
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  launchURL() {
    launch('https://handongsam.com/probiotics');}
  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }


  double takeInHour =0 ;
  double takeInMinute = 0;
  int takeInHour_noti =0;
  int takeInMinute_noti = 0;

  int diaryHour_noti =0;
  int diaryMinute_noti = 0;



  static DateTime now = DateTime.now();
  Timer _everySecond;

  Text takeIn = Text(globals.takeInHour.toString() +  " 시 " + globals.takeInminute.toString()+ " 분 ",
    style: TextStyle(fontSize: 44), );

  Text diary = Text(globals.diaryHour.toString() +  " 시 " + globals.diaryMinute.toString()+ " 분 ",
    style: TextStyle(fontSize: 44), );

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart), color: Color.fromARGB(255, 10, 30, 107), onPressed: () {
            launchURL();
          },
          ),
          IconButton(icon: Icon(Icons.favorite_border,color: Color.fromARGB(255, 10, 30, 107),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DiaryPage()));
            },),
          IconButton(icon: Image(image: AssetImage("assets/1.png"))
              , onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TimePage()));
              }),
          IconButton(icon: Icon(Icons.person, color: Color.fromARGB(255, 10, 30, 107)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyPages()));
            },),
          //IconButton(icon: Icon(Icons.alarm, color: Color.fromARGB(100, 13, 26, 113)),),
          IconButton(icon: Icon(Icons.alarm,
              color: Color.fromARGB(255, 10, 30, 107)), onPressed: () {

          },),
        ],),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70.0,),

            Text("댕댕댕 매일 매일 울리는", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
            Text('알람 설정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),


//            Row(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text("댕댕댕 매일 매일 울리는", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
//
//                  Text('알람 설정',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,color: Color.fromARGB(255, 10, 30, 107)),),
//
//
//
//
//                ]
//
//            ),


            SizedBox(height: 60,),

            //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),

            Text("유산균 마시는 시간", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.w500),)//style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.bold),
            ,
            //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),
            SizedBox(height: 20,),
            FlatButton(
                child: takeIn,


                //textColor: Colors.white,



              onPressed: () async {
                TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now() );
                if(selectedTime != null) {
                  globals.takeInminute = selectedTime.minute;
                  globals.takeInHour = selectedTime.hour;
                  alarm_takeIn(); takeIn_noti();
                  await Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({
                    'alarm_time_hh':globals.takeInHour,
                    'alarm_time_mm':globals.takeInminute
                  });
                }

                setState(() {
                  takeIn = Text(globals.takeInHour.toString() +  " : " + globals.takeInminute.toString(),
                    style: TextStyle(fontSize: 50), );
                });
              },
              //textColor: Colors.white,
//              child: Container(
//                decoration: const BoxDecoration(
//                  gradient: LinearGradient(
//                    colors: <Color>[
//                      Color(0xFF0D47A1),
//                      Color(0xFF1976D2),
//                      Color(0xFF42A5F5),
//                    ],
//                  ),
//                ),
//                padding: const EdgeInsets.all(10.0),
//                child: takeIn,
//              ),
//              child: takeIn,
//              padding: const EdgeInsets.all(0.0),
//



            ),
            SizedBox(height: 60,),
            //Text('매일', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.normal),),

            Text("다이어리 쓰는 시간", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 30, 107), fontWeight: FontWeight.w500),)
            ,
            SizedBox(height: 20,),
            FlatButton(
              child: diary,
              onPressed: () async {
                TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now() );
                if(selectedTime != null){
                  globals.diaryMinute = selectedTime.minute;
                  globals.diaryHour = selectedTime.hour;
                  alarm_diary(); diary_noti();
                  await Firestore.instance.collection('handongsam').document(variable.user.uid).updateData({
                    'diary_time_hh':globals.diaryHour,
                    'diary_time_mm':globals.diaryMinute
                  });
                }

                setState(() {
                  diary = Text(globals.diaryHour.toString() +  " : " + globals.diaryMinute.toString(),
                    style: TextStyle(fontSize: 50), );
                });
              },
//              child: Container(
//                decoration: const BoxDecoration(
//                  gradient: LinearGradient(
//                    colors: <Color>[
//                      Color(0xFF0D47A1),
//                      Color(0xFF1976D2),
//                      Color(0xFF42A5F5),
//                    ],
//                  ),
//                ),
//                padding: const EdgeInsets.all(10.0),
//                child: diary,
//              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showNotificationWithNoBody() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', null, platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  /// Schedules a notification that specifies a different icon, sound and vibration pattern
  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'secondary_icon',
        sound: 'slow_spring_board',
        largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> _showNotificationWithNoSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'silent channel id',
        'silent channel name',
        'silent channel description',
        playSound: false,
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '알람이 설정되었습니다.',
        globals.takeInHour.toString() + " : "  + globals.takeInminute.toString(), platformChannelSpecifics);
  }

  Future<void> _cancel_message() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'silent channel id',
        'silent channel name',
        'silent channel description',
        playSound: false,
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '알람이 지워졌습니다.',
        '', platformChannelSpecifics);
  }

  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _checkPendingNotificationRequests() async {
    var pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var pendingNotificationRequest in pendingNotificationRequests) {
      debugPrint(
          'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              '${pendingNotificationRequests.length} pending notification requests'),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    );
  }

  Future<void> _showOngoingNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ongoing: true,
        autoCancel: false);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
        'ongoing notification body', platformChannelSpecifics);
  }

  Future<void> _repeatNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }

  Future<void> _showDailyAtTime() async {
    var time = Time(globals.takeInHour, globals.takeInminute, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        '유산균 먹으실 시간입니다!!',
        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> alarm_takeIn() async {
    var time = Time(globals.takeInHour, globals.takeInminute, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        '유산균 먹으실 시간입니다!!',
        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> alarm_diary() async {
    var time = Time(globals.diaryHour, globals.diaryMinute, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        '다이어리 작성 시간입니다!!',
        '현재 시간: ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }



  Future<void> takeIn_noti() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '유산균 알람 설정', globals.takeInHour.toString() + ":" + globals.takeInminute.toString(), platformChannelSpecifics,
        payload: 'item x');
  }




  Future<void> diary_noti() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '다이어리 알람 설정', globals.diaryHour.toString() + ":" + globals.diaryMinute.toString(), platformChannelSpecifics,
        payload: 'item x');
  }



  Future<void> _showWeeklyAtDayAndTime() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        Day.Monday,
        time,
        platformChannelSpecifics);
  }

  Future<void> _showNotificationWithNoBadge() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'no badge channel', 'no badge name', 'no badge description',
        channelShowBadge: false,
        importance: Importance.Max,
        priority: Priority.High,
        onlyAlertOnce: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'no badge title', 'no badge body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showProgressNotification() async {
    var maxProgress = 5;
    for (var i = 0; i <= maxProgress; i++) {
      await Future.delayed(Duration(seconds: 1), () async {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'progress channel',
            'progress channel',
            'progress channel description',
            channelShowBadge: false,
            importance: Importance.Max,
            priority: Priority.High,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0,
            'progress notification title',
            'progress notification body',
            platformChannelSpecifics,
            payload: 'item x');
      });
    }
  }

  Future<void> _showIndeterminateProgressNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'indeterminate progress channel',
        'indeterminate progress channel',
        'indeterminate progress channel description',
        channelShowBadge: false,
        importance: Importance.Max,
        priority: Priority.High,
        onlyAlertOnce: true,
        showProgress: true,
        indeterminate: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'indeterminate progress notification title',
        'indeterminate progress notification body',
        platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showNotificationWithUpdatedChannelDescription() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your updated channel description',
        importance: Importance.Max,
        priority: Priority.High,
        channelAction: AndroidNotificationChannelAction.Update);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'updated notification channel',
        'check settings to see updated channel description',
        platformChannelSpecifics,
        payload: 'item x');
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(payload),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen(this.payload);

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen with payload: ${(_payload ?? '')}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
