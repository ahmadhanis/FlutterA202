import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = new TextEditingController();
  String yourString = "got value";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: pressMe,
                  child: Text("Press ME"),
                ),
                SizedBox(height: 30),
                Text(
                  "You entered $yourString",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pressMe() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
