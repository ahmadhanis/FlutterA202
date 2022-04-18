import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/screens/home_page_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midtermstiw2044myshop/models/product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: GoogleFonts.heeboTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
