import 'dart:io';
import 'package:flutter/material.dart';

class TabNewGram extends StatefulWidget {
  @override
  _TabNewGramState createState() => _TabNewGramState();
}

class _TabNewGramState extends State<TabNewGram> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    File _image;
    String pathAsset = 'assets/images/profilea.png';

    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      height: screenHeight / 2.5,
                      width: screenWidth / 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                10.0) //         <--- border radius here
                            ),
                      )),
                  SizedBox(height: 5),
                  Text("Click image to take your gram picture",
                      style: TextStyle(fontSize: 10.0, color: Colors.black)),
                  SizedBox(height: 5),
                  TextFormField(
                    minLines: 7,
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Whats your gram?',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Post',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () => {},
                      color: Colors.black),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      ),
    );
  }
}
