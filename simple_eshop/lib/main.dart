import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cartpage.dart';
import 'config.dart';
import 'package:nanoid/nanoid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Eshop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple EShop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _titlecenter = "Loading...";
  List _productList = [];
  late double screenHeight, screenWidth;
  late SharedPreferences prefs;
  String email = "";

  @override
  void initState() {
    super.initState();
    _loadPref();
    _loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple ESHOP'),
        actions: [
          TextButton.icon(
              onPressed: () => {_goToCart()},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
              label: Text(
                "5",
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search product",
                        suffixIcon: IconButton(
                          onPressed: () => null,
                          icon: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                      ),
                    )
                  ],
                )),
            if (_productList.isEmpty)
              Flexible(child: Center(child: Text(_titlecenter)))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: _productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: orientation == Orientation.portrait
                            ? screenWidth / screenHeight * 1.2
                            : screenHeight / screenWidth * 1.1,
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 3,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0),
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: orientation ==
                                                  Orientation.portrait
                                              ? 100
                                              : 150,
                                          width: orientation ==
                                                  Orientation.portrait
                                              ? 100
                                              : 150,
                                          child: Image.network(CONFIG.SERVER +
                                              _productList[index]['picture']),
                                        ),
                                        Text(
                                          titleSub(_productList[index]
                                              ['productName']),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            _productList[index]['productType']),
                                        Text("Qty:" +
                                            _productList[index]['quantity']),
                                        Text("RM " +
                                            double.parse(_productList[index]
                                                    ['price'])
                                                .toStringAsFixed(2)),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                {_addtocart(index)},
                                            child: Text("Add to Cart"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }))
          ],
        ),
      ),
    );
  }

  String titleSub(String title) {
    if (title.length > 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? '';
    print(email);
    if (email == '') {
      _loademaildialog();
    }
  }

  _loadProduct() {
    http.post(Uri.parse(CONFIG.SERVER + "/myshopweb/mobile/loadproducts.php"),
        body: {"test": "abc"}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No product";
        _productList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _productList = jsondata["products"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }

  _addtocart(int index) {
    _loademaildialog();
    // int qty = int.parse(_productList[index]['quantity']);
    // if (qty == 0) {
    //   Fluttertoast.showToast(
    //       msg: "Quantity not available",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Added to cart",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  _goToCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }

  void _loademaildialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: new Text(
                  'Your Email',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  SingleChildScrollView(
                    child: Card(
                      child: Column(
                        children: [
                          TextFormField(
                              decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white24)
                                ),
                          )),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Proceed"))
                        ],
                      ),
                    ),
                  )
                ]),
        context: context);
  }
}
