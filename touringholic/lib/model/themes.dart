import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.red[400],
      // ignore: deprecated_member_use
      focusColor: Colors.red,
      // Define the default font family.
      fontFamily: 'Georgia',
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.red,
          cursorColor: Colors.red),
      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }

  static ThemeData get lighttheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      accentColor: Colors.red[400],
      // ignore: deprecated_member_use
      focusColor: Colors.red,
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.red,
          cursorColor: Colors.red),
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
