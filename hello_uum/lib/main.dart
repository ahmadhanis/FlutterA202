import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "";
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
                Container(
                    child: RaisedButton(
                  child: Text("Press ME"),
                  onPressed: pressMe,
                )),
                Text("Result " + result)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pressMe() async {
    String _email = "test@email.com";
    String _password = "abc123";
    if (_email.isEmpty){
      
    }
    var url = Uri.parse(
        'https://cors-anywhere.herokuapp.com/http://sopmathpowy2.com/XinYin/hello_website/php/login_user.php');
    var response = await http.post(url, body: {
      'email': _email,
      'password': _password
    }, headers: {
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      result = response.body;
    });
  }
}
