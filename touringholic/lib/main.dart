import 'package:flutter/material.dart';
import 'package:touringholic/view/loginscreen.dart';
import 'package:touringholic/view/mainscreen.dart';
import 'package:touringholic/view/registrationscreen.dart';
import 'package:touringholic/view/touringgramscreen.dart';

import 'model/themes.dart';
import 'view/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.lighttheme,
        routes: <String, WidgetBuilder>{
          '/loginscreen': (BuildContext context) => new LoginScreen(),
          '/registerscreen': (BuildContext context) => new RegistrationScreen(),
          '/mainscreen': (BuildContext context) => new MainScreen(),
          '/gramscreen': (BuildContext context) => new TouringGramScreen(),
        },
        title: 'TouringHolic',
        home: SplashScreen());
  }
}
