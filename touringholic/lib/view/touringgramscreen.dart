import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';
import 'package:touringholic/view/tabnewgram.dart';
import 'package:touringholic/view/tabyourgrams.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'mainscreen.dart';
import 'tablatestgrams.dart';

class TouringGramScreen extends StatefulWidget {
  final User user;

  const TouringGramScreen({Key key, this.user}) : super(key: key);

  @override
  _TouringGramScreenState createState() => _TouringGramScreenState();
}

class _TouringGramScreenState extends State<TouringGramScreen> {
  int _currentIndex = 1;
  List<Widget> tabchildren;
  String maintitle = "TouringGram";

  @override
  void initState() {
    super.initState();
    tabchildren = [TabLatestGrams(), TabNewGram(user: widget.user), TabYourGrams(user: widget.user)];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
            style: TabStyle.flip,
            initialActiveIndex: _currentIndex, //
            onTap: onTabTapped,
            backgroundColor: Theme.of(context).accentColor,
            items: [
              TabItem(icon: Icons.new_releases),
              TabItem(icon: Icons.camera),
              TabItem(icon: Icons.list),
            ]),
        appBar: AppBar(
          title: Text('Touring Gram'),
        ),
        drawer: MyDrawer(user: widget.user),
        body: tabchildren[_currentIndex],
      ),
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

  Future<bool> _onBackPressed() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (content) => MainScreen(
                  user: widget.user,
                )));
    return false;
  }
}
