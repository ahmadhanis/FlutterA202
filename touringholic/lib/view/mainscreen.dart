import 'package:flutter/material.dart';
import 'package:touringholic/model/user.dart';
import 'package:touringholic/view/loginscreen.dart';
import 'mydrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight, screenWidth;
  Material homeText(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(10.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Dashboard'),
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 10.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              homeText(Icons.graphic_eq, "Overall", 0xffed622b),
              homeText(Icons.picture_in_picture, "TouringGrams", 0xff26cb3c),
              homeText(Icons.attach_money, "Preloved", 0xff7297ff),
              homeText(Icons.pedal_bike, "MyTour", 0xff3399fe),
              homeText(Icons.message, "Messaging", 0xffff3266),
              homeText(Icons.settings, "MyProfile", 0xfff4c83f),
              // progressDialog
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0)
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to back to login?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (content) => LoginScreen()));
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
}
