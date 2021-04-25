import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:touringholic/model/user.dart';

class TabYourGrams extends StatefulWidget {
  final User user;

  const TabYourGrams({Key key, this.user}) : super(key: key);

  @override
  _TabYourGramsState createState() => _TabYourGramsState();
}

class _TabYourGramsState extends State<TabYourGrams> {
  double screenHeight, screenWidth;
  List _userlistgrams;
  String _titlecenter = "Loading...";
  @override
  void initState() {
    super.initState();
    _loadGrams();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              _userlistgrams == null
                  ? Flexible(child: Center(child: Text(_titlecenter)))
                  : Flexible(
                      child: Center(
                          child: GridView.count(
                              crossAxisCount: 1,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.5,
                              children:
                                  List.generate(_userlistgrams.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Card(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: screenHeight / 3,
                                          //width: screenWidth / 1.2,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://slumberjer.com/touringholic/images/gram_pictures/${_userlistgrams[index]['gramid']}.png",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(
                                              Icons.broken_image,
                                              size: screenWidth / 2,
                                            ),
                                          ),
                                        ),
                                        Text(_userlistgrams[index]['gramdesc'])
                                      ],
                                    ),
                                  )),
                                );
                              }))))
            ],
          ),
        ),
      ),
    );
  }

  void _loadGrams() {
    http.post(
        Uri.parse("https://slumberjer.com/touringholic/php/load_usergrams.php"),
        body: {
          "email": widget.user.email,
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no gram available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _userlistgrams = jsondata["grams"];

        setState(() {});
        print(_userlistgrams);
      }
    });
  }
}
