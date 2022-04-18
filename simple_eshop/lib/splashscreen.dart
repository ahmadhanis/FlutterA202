import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_eshop/main.dart';
import 'package:simple_eshop/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        title: 'Simple EShop',
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/groceries.jpg'),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text("E-SHOP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold))),
      ),
    ]));
  }
}
