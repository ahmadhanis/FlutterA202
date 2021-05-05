import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:touringholic/model/user.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TabLatestGrams extends StatefulWidget {
  final User user;

  const TabLatestGrams({Key key, this.user}) : super(key: key);

  @override
  _TabLatestGramsState createState() => _TabLatestGramsState();
}

class _TabLatestGramsState extends State<TabLatestGrams> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  List _userlistgrams;
  String _titlecenter = "Loading...";
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  int _pageno = 1;
  int pagenum = 0;

  @override
  void initState() {
    super.initState();
    _loadGrams();
  }

  @override
  void dispose() {
    print("in dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _userlistgrams == null
                ? Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 9,
                            child: GridView.count(
                                crossAxisCount: 1,
                                // childAspectRatio:
                                //     (screenWidth / screenHeight) / 0.6,
                                //
                                children: List.generate(_userlistgrams.length,
                                    (index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                    child: Card(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration: new BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: new DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: new NetworkImage(
                                                                  "https://slumberjer.com/touringholic/images/profileimages/default.png")))),
                                                ),
                                                Expanded(
                                                    flex: 6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(_userlistgrams[
                                                                index]
                                                            ['user_name']),
                                                        Text(df.format(DateTime
                                                            .parse(_userlistgrams[
                                                                    index]
                                                                ['date_post'])))
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 10, 0),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: PopupMenuButton(
                                                          onSelected:
                                                              (newValue) {
                                                            if (newValue ==
                                                                1) {}
                                                            if (newValue ==
                                                                0) {}
                                                          },
                                                          child:
                                                              Icon(Icons.menu),
                                                          itemBuilder:
                                                              (context) => [
                                                                    PopupMenuItem(
                                                                      child: Text(
                                                                          "Report"),
                                                                      value: 0,
                                                                    ),
                                                                  ]),
                                                    ))
                                              ],
                                            )),
                                            GestureDetector(
                                              onTap: () => _showGram(index),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                alignment: Alignment.centerLeft,
                                                child: Text(checkGramLen(
                                                    _userlistgrams[index]
                                                        ['gramdesc'])),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: screenWidth / 1.8,
                                              width: screenWidth / 0.5,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://slumberjer.com/touringholic/images/gram_pictures/${_userlistgrams[index]['gramid']}.png",
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    new Transform.scale(
                                                        scale: 0.5,
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(
                                                  Icons.broken_image,
                                                  size: screenWidth / 3,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () => {},
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '3',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              loadCommentDialog(
                                                                  index);
                                                            },
                                                            child: Icon(
                                                              Icons.comment,
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {},
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '5',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))),
                        Flexible(
                            flex: 1,
                            child: Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: updatePage,
                                    child: Text(
                                        "Load More (current page $_pageno / $pagenum)"))))
                      ],
                    )),
                  )
          ],
        ),
      ),
    );
  }

  updatePage() {
    pagenum = _userlistgrams[0]['numpage'];
    if (_pageno >= pagenum) {
      _pageno = 1;
      _loadGrams();
      return;
    } else {
      _pageno++;
      _loadGrams();
    }
  }

  _showGram(int index) {
    print(_userlistgrams[index]['gramid']);
    print("HELLO");
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: SingleChildScrollView(
          child: Container(
            height: screenHeight / 3,
            child: Column(
              children: [
                Expanded(flex: 1, child: Text("Gram")),
                Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                        child: Text(_userlistgrams[index]['gramdesc']))),
                Expanded(
                    flex: 2,
                    child: Container(
                      width: screenWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor, // background
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String checkGramLen(String gram) {
    if (gram.length < 35) {
      return gram;
    } else {
      return gram.substring(0, 35) + " ...read more";
    }
  }

  void _loadGrams() {
    print(_pageno);
    http.post(
        Uri.parse("https://slumberjer.com/touringholic/php/load_usergrams.php"),
        body: {
          "pageno": _pageno.toString(),
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no gram available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _userlistgrams = jsondata["grams"];
        pagenum = _userlistgrams[0]['numpage'];
        setState(() {});
        print(_userlistgrams);
      }
    });
  }

  Future<void> loadCommentDialog(int index) async {
    List listComments;

    await loadComment(index, listComments);

    TextEditingController txtCommentCtrl = new TextEditingController();
    print(index);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: new Text("Users Comment"),
          content: SingleChildScrollView(
            child: new Container(
              height: screenHeight / 3,
              width: screenWidth,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 7,
                      child: Container(
                          child: ListView(
                        children: [
                          ListTile(
                            title: Text('Hello sir'),
                          ),
                          ListTile(
                            title: Text('Hello Again...', style: TextStyle()),
                          ),
                        ],
                      ))),
                  Expanded(
                      flex: 3,
                      child: Container(
                          child: Row(
                        children: [
                          Flexible(
                              flex: 9,
                              child: TextField(
                                controller: txtCommentCtrl,
                                decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  labelText: 'Your Comment',
                                ),
                                keyboardType: TextInputType.multiline,
                                minLines:
                                    3, //Normal textInputField will be displayed
                                maxLines:
                                    3, // when user presses enter it will adapt to it
                              )),
                          Flexible(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  sendComment(txtCommentCtrl.text, index);
                                },
                                icon: Icon(Icons.send)),
                          )
                        ],
                      )))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void sendComment(String comment, int index) {
    print(comment);
    print(_userlistgrams[index]['user_email']);
    print(widget.user.email);
    print(_userlistgrams[index]['gramid']);

    http.post(
        Uri.parse("https://slumberjer.com/touringholic/php/insert_comment.php"),
        body: {
          "gram_id": _userlistgrams[index]['gramid'],
          "gram_owner": _userlistgrams[index]['user_email'],
          "gram_reply": widget.user.email,
          "gram_comment": comment,
        }).then((response) {
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  Future loadComment(int index, List listComments) async {
    http.post(
        Uri.parse("https://slumberjer.com/touringholic/php/load_comments.php"),
        body: {
          "gramid": _userlistgrams[index]['gramid'],
        }).then((response) {
      if (response.body == "nodata") {
        print("no data");
        return;
      } else {
        var jsondata = json.decode(response.body);
        listComments = jsondata["comments"];
        print(listComments);
      }
    });
  }
}
