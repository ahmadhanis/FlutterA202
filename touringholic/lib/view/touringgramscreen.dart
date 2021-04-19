import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';
import 'package:touringholic/view/tabnewgram.dart';
import 'package:touringholic/view/tabyourgrams.dart';

import 'tablatestgrams.dart';

class TouringGramScreen extends StatefulWidget {
  final User user;

  const TouringGramScreen({Key key, this.user}) : super(key: key);

  @override
  _TouringGramScreenState createState() => _TouringGramScreenState();
}

class _TouringGramScreenState extends State<TouringGramScreen> {
  int _currentIndex = 0;
  List<Widget> tabchildren;
  String maintitle = "TouringGram";

  @override
  void initState() {
    super.initState();
    tabchildren = [TabLatestGrams(), TabNewGram(), TabYourGrams()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.red.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _currentIndex, //
          onTap: onTabTapped,
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
      body:tabchildren[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "TouringGram";
      }
      if (_currentIndex == 1) {
        maintitle = "New Gram";
      }
      if (_currentIndex == 2) {
        maintitle = "Your Grams";
      }
    });
  }
}
