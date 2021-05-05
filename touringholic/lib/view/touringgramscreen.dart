import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';
import 'package:touringholic/view/tabgrams/tablatestgrams.dart';
import 'package:touringholic/view/tabgrams/tabnewgram.dart';
import 'package:touringholic/view/tabgrams/tabyourgrams.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'mainscreen.dart';

class TouringGramScreen extends StatefulWidget {
  final User user;
  final int curtab;
  const TouringGramScreen({Key key, this.user, this.curtab}) : super(key: key);

  @override
  _TouringGramScreenState createState() => _TouringGramScreenState();
}

class _TouringGramScreenState extends State<TouringGramScreen> {
  int currentIndex ;
  List<Widget> tabchildren;
  String maintitle = "TouringGram";
  TabController controller;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.curtab;
    tabchildren = [
      TabLatestGrams(user: widget.user),
      TabNewGram(user: widget.user),
      TabYourGrams(user: widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
            style: TabStyle.flip,
            initialActiveIndex: currentIndex, //
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
        body: tabchildren[currentIndex],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        maintitle = "TouringGram";
      }
      if (currentIndex == 1) {
        maintitle = "New Gram";
      }
      if (currentIndex == 2) {
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
