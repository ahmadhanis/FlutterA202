import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";
  TextEditingController _namecontroller = new TextEditingController();

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
            child: Column(
              children: [
                Text("Please enter your name"),
                Container(
                    width: 200,
                    child: TextField(
                      controller: _namecontroller,
                    )),
                RaisedButton(
                  child: Text("Press ME"),
                  onPressed: printmyName,
                ),
                Text("Your Name " + name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  printmyName() {
    setState(() {
      name = _namecontroller.text.toString();
      print(name);
    });
  }
}
