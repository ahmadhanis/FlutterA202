import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'mydrawer.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen'),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
