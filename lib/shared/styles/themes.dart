import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


Color defaultColor = Colors.blue;


ThemeData lightTheme = ThemeData(
  //fontFamily: 'DanielDavis',
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:const AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      fontFamily: 'jannah'
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    type:BottomNavigationBarType.fixed,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
        fontFamily: 'jannah',
    ),
    subtitle1: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontFamily: 'jannah',height: 1.3

    ),
  ),

);


ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme:const IconThemeData(
        color: Colors.white
    ),
    backgroundColor:HexColor('333739') ,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,fontFamily: 'jannah'
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor:Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739')
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,fontFamily: 'jannah'
    ),
    subtitle1: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w600,fontFamily: 'jannah', height: 1.3

    ),
  ),


);






