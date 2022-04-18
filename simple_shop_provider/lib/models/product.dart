import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'config.dart';

class Product {
  String productName, productType, pictureUrl, image64;
  double price;
  int productId, quantity;

  Product({this.productName, this.productType, this.price, this.quantity});

  Product.fromJson(json) {
    productId = json['productId'];
    productName = json['productName'];
    productType = json['productType'];
    price = json['price'].toDouble();
    quantity = json['quantity'];
    pictureUrl = CONFIG.SERVER+json['picture'];
  }
}

class ProductProvider with ChangeNotifier {
  List<Product> productList = [];
  getProducts() async {
    var url = Uri.parse(CONFIG.SERVER+'/myshop/php/loadproducts.php');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['products'];

      productList =
          data.map<Product>((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<bool> addProduct(Product product, File imageFile) async {
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    var url = Uri.parse(CONFIG.SERVER+'/myshop/php/newproduct.php');
    var response = await http.post(url, body: {
      'productName': product.productName,
      'productType': product.productType,
      'price': product.price.toString(),
      'quantity': product.quantity.toString(),
      'encoded_base64string': base64Image,
    });
    if (response.body == 'success') {
      print('adding product is successfull');
      getProducts();
      return true;
    }
    return false;
  }

  Future<bool> deleteProduct(int productId) async {
    var url = Uri.parse(CONFIG.SERVER+'/myshop/php/deleteproduct.php');
    var response = await http.post(url, body: {
      'productId': productId.toString(),
    });
    if (response.body == 'success') {
      print('deleting product is successfull');

      getProducts();
      return true;
    }
    return false;
  }

  Future<bool> updateProduct(
      int productId, Product product, File imageFile) async {
    var url = Uri.parse(CONFIG.SERVER+'/myshop/php/updateproduct.php');
    Map body = {
      'productId': productId.toString(),
      'productName': product.productName,
      'productType': product.productType,
      'price': product.price.toString(),
      'quantity': product.quantity.toString(),
    };

    // if image is updated
    if (imageFile != null) {
      String base64Image = base64Encode(imageFile.readAsBytesSync());
      // add base64string to body
      body['encoded_base64string'] = base64Image;
    }

    var response = await http.post(url, body: body);
    if (response.body == 'success') {
      print('updating product is successfull');

      getProducts();
      return true;
    }
    return false;
  }
}
