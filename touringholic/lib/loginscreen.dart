import 'package:flutter/material.dart';
import 'registrationscreen.dart';
import 'theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.darktheme,
      title: 'Touring Holic',
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
                        'Login',
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
                          child: Text('Login',
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
                child: Text("Register New Account",
                    style: TextStyle(fontSize: 16)),
                onTap: _registerNewUser,
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text("Forgot Password", style: TextStyle(fontSize: 16)),
                onTap: _forgotPassword,
              )
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

  void _registerNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => RegistrationScreen()));
  }

  void _forgotPassword() {
     TextEditingController phoneController = TextEditingController();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Forgot Password?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Text(
                  "Enter your recovery email",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ))
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                print(
                  phoneController.text,
                );
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
