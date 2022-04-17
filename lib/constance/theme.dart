import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './color.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color.fromRGBO(45, 136, 255, 1),
    unselectedItemColor: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: Color.fromRGBO(36, 37, 38, 1),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Color.fromRGBO(221, 223, 227, 1),
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleSpacing: 20.0,
    backgroundColor: Color.fromRGBO(36, 37, 38, 1),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color.fromRGBO(45, 136, 255, 1),
    backgroundColor: Color.fromRGBO(36, 37, 38, 1),
    unselectedItemColor: Color.fromRGBO(132, 137, 140, 1),
  ),
);
