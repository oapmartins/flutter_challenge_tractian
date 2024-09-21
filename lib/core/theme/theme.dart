import 'package:flutter/material.dart';

class ThemeDefault {
  ThemeDefault._();

  static AppBarTheme appBarTheme = const AppBarTheme(
    backgroundColor: Color(0xff17192D),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );

  static ThemeData themeData = ThemeData(
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: Colors.white,
  );
}
