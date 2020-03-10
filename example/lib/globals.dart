library my_prj.globals;
import 'package:flutter/material.dart';

bool isLoggedIn = false;

int takeInHour = 0;
int takeInminute = 0;

int diaryHour = 0;
int diaryMinute = 0;
int day =0;


ButtonBar bottom = ButtonBar(mainAxisSize: MainAxisSize.min,
  alignment: MainAxisAlignment.center,
  children: <Widget>[
    IconButton(
      icon: Icon(Icons.shopping_cart),
    ),
    IconButton(icon: Icon(Icons.favorite_border),),
    IconButton(icon: Image(image: AssetImage("assets/1.png")),),
    IconButton(icon: Icon(Icons.person),),
    IconButton(icon: Icon(Icons.alarm),),
  ],);

