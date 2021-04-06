import 'package:flutter/material.dart';
import 'package:touringholic/theme.dart';
import 'splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TouringHolic',
        theme: CustomTheme.darktheme,
        home: SplashScreen());
  }
}
