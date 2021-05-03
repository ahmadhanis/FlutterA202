import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:touringholic/model/user.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TabYourGrams extends StatefulWidget {
  final User user;

  const TabYourGrams({Key key, this.user}) : super(key: key);

  @override
  _TabYourGramsState createState() => _TabYourGramsState();
}

class _TabYourGramsState extends State<TabYourGrams> {
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
                                                        Text(widget.user.name),
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
                                                            if (newValue == 1) {
                                                              _deleteDialog(
                                                                  index);
                                                            }
                                                            if (newValue == 0) {
                                                              _editDialog(
                                                                  index);
                                                            }
                                                          },
                                                          child:
                                                              Icon(Icons.menu),
                                                          itemBuilder:
                                                              (context) => [
                                                                    PopupMenuItem(
                                                                      child: Text(
                                                                          "Edit"),
                                                                      value: 0,
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child: Text(
                                                                          "Delete"),
                                                                      value: 1,
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
                                                          Icon(
                                                            Icons.comment,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
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
          "email": widget.user.email,
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

  void _deleteDialog(int index) {
    print(_userlistgrams[index]['gramid']);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Delete this gram?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteGram(index);
                },
              ),
              TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _deleteGram(int index) async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Deleting gram...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();

    http.post(
        Uri.parse(
            "https://slumberjer.com/touringholic/php/delete_usergram.php"),
        body: {
          "gramid": _userlistgrams[index]['gramid'],
        }).then((response) {
      if (response.body == "success") {
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        Fluttertoast.showToast(
            msg: "Delete Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadGrams();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _editDialog(int index) {
    TextEditingController editdescCtrl = new TextEditingController();
    editdescCtrl.text = _userlistgrams[index]['gramdesc'];
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Edit Your Gram ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        content: Container(
          height: screenHeight / 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: editdescCtrl,
                  minLines: 5,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor, // background
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      String gramdesc = editdescCtrl.text.toString();
                      _updateGram(index, gramdesc);
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateGram(int index, String newgram) async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Updating gram...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    http.post(
        Uri.parse(
            "https://slumberjer.com/touringholic/php/update_usergram.php"),
        body: {
          "gramid": _userlistgrams[index]['gramid'],
          "newgram": newgram
        }).then((response) {
      if (response.body == "success") {
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        Fluttertoast.showToast(
            msg: " Update Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadGrams();
      } else {
        Fluttertoast.showToast(
            msg: "Update Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
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
}
