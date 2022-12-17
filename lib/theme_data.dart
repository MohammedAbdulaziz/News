import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      textTheme: const TextTheme(
        // Specify the font family and sizes for the different text styles
        headline1: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        headline2: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        headline3: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        headline4: TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        headline5: TextStyle(
            fontSize: 30, fontWeight: FontWeight.normal, color: Colors.black),
        bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        bodyText2: TextStyle(fontSize: 12),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
        accentColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 243, 243, 243));
}
