import 'package:flutter/material.dart';

class myTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Color(0xFFDFECDB),
      textTheme: TextTheme(
          titleSmall: (TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
          labelSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedItemColor: Colors.grey,
      ));
  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Color(0xFF060E1E),
      textTheme: TextTheme(
          titleSmall: (TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
          labelSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedItemColor: Colors.white,
      ));
}
