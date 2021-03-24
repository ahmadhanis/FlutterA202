import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TextEditingController nameController = new TextEditingController();
  final ValueNotifier<String> nameNotifier = new ValueNotifier('');

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
            width: 350,
            child: Column(
              children: [
                Text("Please enter name "),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text("Press Me"),
                  onPressed: pressMe,
                ),
                ValueListenableBuilder(
                  valueListenable:nameNotifier,
                  builder:(context,name,child){
                    return Text("Welcome "+name);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pressMe() {
    nameNotifier.value = nameController.text;
  }
}
