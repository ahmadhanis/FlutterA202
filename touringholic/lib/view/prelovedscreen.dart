import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/mydrawer.dart';
import 'package:touringholic/view/tabgrams/tablatestgrams.dart';
import 'package:touringholic/view/tabgrams/tabnewgram.dart';
import 'package:touringholic/view/tabgrams/tabyourgrams.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:touringholic/view/tabpreloved/tabprelovedall.dart';
import 'mainscreen.dart';
import 'tabpreloved/tabprelovednew.dart';

class PrelovedScreen extends StatefulWidget {
  final User user;
  final int curtab;
  const PrelovedScreen({Key key, this.user, this.curtab}) : super(key: key);

  @override
  _PrelovedScreenState createState() => _PrelovedScreenState();
}

class _PrelovedScreenState extends State<PrelovedScreen> {
  int currentIndex ;
  List<Widget> tabchildren;
  String maintitle = "Preloved";
  TabController controller;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.curtab;
    tabchildren = [
      TabPrelovedAll(),
      TabPrelovedNew(),
      TabPrelovedAll()
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
              TabItem(icon: Icons.shopping_cart),
              TabItem(icon: Icons.camera),
              TabItem(icon: Icons.list),
            ]),
        appBar: AppBar(
          title: Text('Preloved'),
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
        maintitle = "Recent Preloved";
      }
      if (currentIndex == 1) {
        maintitle = "Post Preloved";
      }
      if (currentIndex == 2) {
        maintitle = "Your Preloved";
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
