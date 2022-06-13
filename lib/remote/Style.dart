import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData light =  ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
    backgroundColor: Colors.white ,
    elevation: 0.0 ,
    titleTextStyle: TextStyle(
      color: Colors.black ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.w600 ,
    ),
    iconTheme: IconThemeData(
      color: Colors.black ,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white ,
    unselectedItemColor: Colors.grey ,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black ,
      fontSize: 18.0 ,
    ),
    subtitle1:  TextStyle(
      color: Colors.black ,
      fontSize: 14.0,
      height: 1.4
    ),
  ),
  fontFamily: 'jannah',
);
ThemeData dark =  ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme:  AppBarTheme(
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0 ,
    titleTextStyle: TextStyle(
      color: Colors.white ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.w600 ,
    ),
    iconTheme: IconThemeData(
      color: Colors.white ,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey ,
    selectedItemColor: Colors.deepOrange ,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white ,
      fontSize: 18.0 ,
    ),
    subtitle1:  TextStyle(
      color: Colors.white ,
        fontSize: 14.0,
        height: 1.4
    ),
  ),
);