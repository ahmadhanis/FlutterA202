import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';

class TouringGramScreen extends StatefulWidget {
  final User user;

  const TouringGramScreen({Key key, this.user}) : super(key: key);

  @override
  _TouringGramScreenState createState() => _TouringGramScreenState();
}

class _TouringGramScreenState extends State<TouringGramScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.red.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Latest Grams',
              icon: Icon(Icons.new_releases),
            ),
            BottomNavigationBarItem(
              label: 'New Gram',
              icon: Icon(Icons.camera),
            ),
            BottomNavigationBarItem(
                label: 'Your Gram', icon: Icon(Icons.favorite_rounded)),
          ]),
      appBar: AppBar(
        title: Text('Touring Gram'),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
