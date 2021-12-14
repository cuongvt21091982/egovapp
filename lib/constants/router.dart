
import 'package:egovapp/page/home/home-main.dart';
import 'package:egovapp/page/home/login.dart';
import 'package:flutter/material.dart';

class Routers
{
  static Map<String, WidgetBuilder> get statesPage =>{
    "/login": (BuildContext context) => LoginPage(),
    "/home:": (BuildContext context) => HomeMain()

  };
}
