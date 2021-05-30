import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:touringholic/config.dart';
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
  String commenttxt = "Loading...";
  List listComments;

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
                        Center(
                            child: Text(
                          "LATEST GRAMS",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        Flexible(
                            flex: 9,
                            child: ListView.builder(
                                itemCount: _userlistgrams.length,
                                itemBuilder: (BuildContext ctxt, int index) {
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
                                                                  CONFIG.SERVER +
                                                                      "/touringholic/images/profileimages/default.png")))),
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
                                                imageUrl: CONFIG.SERVER +
                                                    "/touringholic/images/gram_pictures/${_userlistgrams[index]['gramid']}.png",
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
                                                            _userlistgrams[
                                                                        index][
                                                                    'numcomments']
                                                                .toString(),
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
                                                            '',
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
                                })),
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
    http.post(Uri.parse(CONFIG.SERVER + "/touringholic/php/load_usergrams.php"),
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
    listComments = await loadComment(index);

    TextEditingController txtCommentCtrl = new TextEditingController();
    print(index);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, newSetState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: new Text("Comments"),
            content: SingleChildScrollView(
              child: new Container(
                height: screenHeight / 2,
                width: screenWidth,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Container(
                            child: Column(
                          children: [
                            listComments == null
                                ? Flexible(
                                    child: Center(child: Text(commenttxt)))
                                : Flexible(
                                    child: ListView.builder(
                                        itemCount: listComments.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("by " +
                                                      listComments[index]
                                                          ['user_name']),
                                                  Text(listComments[index]
                                                      ['gram_comment']),
                                                  Text("at " +
                                                      df.format(DateTime.parse(
                                                          listComments[index][
                                                              'gram_datepost'])))
                                                ],
                                              ),
                                            ),
                                          );
                                        }))
                          ],
                        ))),
                    Expanded(
                        flex: 2,
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
                                  onPressed: () async {
                                    sendComment(txtCommentCtrl.text, index,
                                        newSetState);
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
        });
      },
    );
  }

  void sendComment(String comment, int index, newSetState) {
    print(comment);
    print(_userlistgrams[index]['user_email']);
    print(widget.user.email);
    print(_userlistgrams[index]['gramid']);

    http.post(Uri.parse(CONFIG.SERVER + "/touringholic/php/insert_comment.php"),
        body: {
          "gram_id": _userlistgrams[index]['gramid'],
          "gram_owner": _userlistgrams[index]['user_email'],
          "gram_reply": widget.user.email,
          "gram_comment": comment,
        }).then((response) async {
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        listComments = await loadCommentInner(index, newSetState);
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

  Future<List> loadComment(int index) async => http.post(
          Uri.parse(CONFIG.SERVER + "/touringholic/php/load_comments.php"),
          body: {
            "gramid": _userlistgrams[index]['gramid'],
          }).then((response) {
        List listComments;
        if (response.body == "nodata") {
          commenttxt = "No Comment";
          print("no data");
          return null;
        } else {
          var jsondata = json.decode(response.body);
          print(jsondata);
          return listComments = jsondata["comments"];
        }
      });

  Future<List> loadCommentInner(int index, newSetState) async => http.post(
          Uri.parse(CONFIG.SERVER + "/touringholic/php/load_comments.php"),
          body: {
            "gramid": _userlistgrams[index]['gramid'],
          }).then((response) {
        List listComments;
        if (response.body == "nodata") {
          commenttxt = "No Comment";
          print("no data");
          return null;
        } else {
          var jsondata = json.decode(response.body);
          print(jsondata);
          listComments = jsondata["comments"];
          newSetState(() {});
          return listComments;
        }
      });
}
