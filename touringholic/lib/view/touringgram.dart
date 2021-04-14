import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';

class TouringGram extends StatefulWidget {
  final User user;

  const TouringGram({Key key, this.user}) : super(key: key);

  @override
  _TouringGramState createState() => _TouringGramState();
}

class _TouringGramState extends State<TouringGram> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Touring Gram'),
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
