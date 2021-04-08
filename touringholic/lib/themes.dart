import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Color.fromRGBO(191, 30, 46, 50),
      // ignore: deprecated_member_use
      cursorColor: Color.fromRGBO(191, 30, 46, 50),
      focusColor: Color.fromRGBO(191, 30, 46, 50),
      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}