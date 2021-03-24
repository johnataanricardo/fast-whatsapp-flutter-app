import 'package:flutter/material.dart';
import 'package:whatsapp_start_conversation/constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    fontFamily: 'QuickSand',
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: ThemeData.light().textTheme.copyWith(
      headline5: TextStyle( 
        color: primaryColor,
        fontFamily: 'QuickSand',
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      headline6: TextStyle( 
        color: Colors.grey[600],
        fontFamily: 'QuickSand',
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
      button: TextStyle(
        color: backgroundColor,
        fontSize: 18,
        fontWeight: FontWeight.w800
      )
    ),        
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(          
      fillColor: backgroundColor,
      focusColor: primaryColor
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light
    )
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    fontFamily: 'QuickSand',
    scaffoldBackgroundColor: backgroundColor,
    primaryTextTheme: ThemeData.dark().textTheme.copyWith(
      headline5: TextStyle( 
        color: primaryColor,
        fontFamily: 'QuickSand',
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      headline6: TextStyle( 
        color: Colors.grey[400],
        fontFamily: 'QuickSand',
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
      button: TextStyle(
        color: backgroundColor,
        fontSize: 18,
        fontWeight: FontWeight.w800
      )
    ),        
    inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(          
      fillColor: Colors.white,
      focusColor: primaryColor
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: backgroundColor
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark
    )
  );
}