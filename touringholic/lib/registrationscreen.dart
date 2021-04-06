import 'package:flutter/material.dart';
import 'package:touringholic/loginscreen.dart';

import 'theme.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.darktheme,
      title: 'Material App',
      home: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(70, 50, 70, 10),
                  child:
                      Image.asset('assets/images/touringholic.png', scale: 2)),
              SizedBox(height: 5),
              Card(
                margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Enter Password Again',
                            icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                              value: _rememberMe,
                              onChanged: (bool value) {
                                _onChange(value);
                              }),
                          Text("Remember Me")
                        ],
                      ),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: 200,
                          height: 50,
                          child: Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: _onLogin,
                          color: Color.fromRGBO(191, 30, 46, 50)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child:
                    Text("Already Register?", style: TextStyle(fontSize: 16)),
                onTap: _alreadyRegister,
              ),
              SizedBox(height: 5),
            ],
          ),
        )),
      ),
    );
  }

  void _onLogin() {}

  void _onChange(bool value) {
    print(value);
    setState(() {
      _rememberMe = value;
    });
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }
}
