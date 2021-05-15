import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:touringholic/config.dart';
import 'loginscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ProgressDialog pr;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordControllera = new TextEditingController();
  TextEditingController _passwordControllerb = new TextEditingController();
  double screenHeight, screenWidth;
  bool _isChecked = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Registration...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(70, 50, 70, 10),
                child: Image.asset('assets/images/touringholic.png', scale: 2)),
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
                        //color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Name', icon: Icon(Icons.person)),
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email)),
                    ),

                    TextField(
                      controller: _passwordControllera,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: _togglePass,
                          child: Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),

                    TextField(
                      controller: _passwordControllerb,
                      decoration: InputDecoration(
                        labelText: 'Enter Password Again',
                        icon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: _togglePass,
                          child: Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: _showEULA,
                            child: Text('I Agree to Terms  ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]), //

                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: screenWidth,
                        height: 50,
                        child: Text('Register',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: _onRegister,
                        color: Colors.red),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Text("Already Register?", style: TextStyle(fontSize: 16)),
              onTap: _alreadyRegister,
            ),
            SizedBox(height: 15),
          ],
        ),
      )),
    );
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _alreadyRegister() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _name = _nameController.text.toString();
    String _email = _emailController.text.toString();
    String _passworda = _passwordControllera.text.toString();
    String _passwordb = _passwordControllerb.text.toString();

    if (_name.isEmpty ||
        _email.isEmpty ||
        _passworda.isEmpty ||
        _passwordb.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (!validateEmail(_email)) {
      Fluttertoast.showToast(
          msg: "Check your email format",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (_passworda != _passwordb) {
      Fluttertoast.showToast(
          msg: "Please use the same password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (_passworda.length < 5) {
      Fluttertoast.showToast(
          msg: "Password should atleast 5 characters long ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (!validatePassword(_passworda)) {
      Fluttertoast.showToast(
          msg:
              "Password should contain atleast contain capital letter, small letter and number ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept terms",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    //checking the data integrity

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Register new user"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_name, _email, _passworda);
                },
              ),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _registerUser(String name, String email, String password) async {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    http.post(
        Uri.parse(CONFIG.SERVER +"/touringholic/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": password
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Registration Success. Please check your email for verification link",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        // FocusScope.of(context).unfocus();
        // _passwordControllerb.clear();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      }
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Slumberjer This EULA agreement governs your acquisition and use of our TOURINGHOLIC software (Software) directly from Slumberjer or indirectly through a Slumberjer authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the TOURINGHOLIC software. It provides a license to use the TOURINGHOLIC software and contains warranty information and liability disclaimers. If you register for a free trial of the TOURINGHOLIC software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the TOURINGHOLIC software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Slumberjer herewith regardless of whether other software is referred to or described herein. The terms also apply to any Slumberjer updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for TOURINGHOLIC. Slumberjer shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Slumberjer. Slumberjer reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{5,}$';
    RegExp regExp = new RegExp(pattern);
    print(regExp.hasMatch(value));
    return regExp.hasMatch(value);
  }

  String titleCase(str) {
    var retStr = "";
    List userdata = str.toLowerCase().split(' ');
    print(userdata[0].toString());
    for (int i = 0; i < userdata.length; i++) {
      retStr += userdata[i].charAt(0).toUpperCase + " ";
    }
    print(retStr);
    return retStr;
    // var splitStr = str.toLowerCase().split(' ');
    // for (var i = 0; i < splitStr.length; i++) {
    //   // You do not need to check if i is larger than splitStr length, as your for does that for you
    //   // Assign it back to the array
    //   splitStr[i] =
    //       splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
    // }
    // // Directly return the joined string
    // return splitStr.join(' ');
  }

  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
