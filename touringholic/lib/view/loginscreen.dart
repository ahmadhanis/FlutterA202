import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touringholic/config.dart';
import 'package:touringholic/model/user.dart';
import 'mainscreen.dart';
import 'registrationscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  SharedPreferences prefs;
  double screenHeight, screenWidth;
  ProgressDialog pr;
  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Login...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
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
                          //color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email)),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.red,
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
                          minWidth: screenWidth,
                          height: 50,
                          child: Text('Login',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: _onLogin,
                          color: Colors.red),
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

  Future<void> _onLogin() async {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();

    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    http.post(Uri.parse(CONFIG.SERVER + "/touringholic/php/login_user.php"),
        body: {"email": _email, "password": _password}).then((response) {
      print(response.body);
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      } else {
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        List userdata = response.body.split(",");
        User user = User(
            email: _email,
            password: _password,
            name: userdata[1],
            datereg: userdata[2],
            rating: userdata[3],
            credit: userdata[4],
            status: userdata[5]);
        pr.hide().then((isHidden) {
          print(isHidden);
        });

        Navigator.push(context,
            MaterialPageRoute(builder: (content) => MainScreen(user: user)));
      }
    });
  }

  void _registerNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => RegistrationScreen()));
  }

  void _forgotPassword() {
    TextEditingController _useremailcontroller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Forgot Your Password?"),
            content: new Container(
                height: 100,
                child: Column(
                  children: [
                    Text("Enter your recovery email"),
                    TextField(
                      controller: _useremailcontroller,
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email)),
                    )
                  ],
                )),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  print(_useremailcontroller.text);
                  _resetPassword(_useremailcontroller.text.toString());
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  child: Text("Cancel", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _onChange(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    setState(() {
      _rememberMe = value;
      storePref(value, _email, _password);
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to exit this app?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }

  Future<void> storePref(bool value, String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString("email", email);
      await prefs.setString("password", password);
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
          msg: "Preferences stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      await prefs.setString("email", '');
      await prefs.setString("password", '');
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
          msg: "Preferences removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        _rememberMe = false;
      });
      return;
    }
  }

  Future<void> loadPref() async {
    prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString("email") ?? '';
    String _password = prefs.getString("password") ?? '';
    _rememberMe = prefs.getBool("rememberme") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  }

  void _resetPassword(String emailreset) {
    http.post(
        Uri.parse(CONFIG.SERVER +"/touringholic/php/insert_gram.php"),
        body: {"email": emailreset}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Password reset completed. Please check your email for further instruction",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Password reset failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
