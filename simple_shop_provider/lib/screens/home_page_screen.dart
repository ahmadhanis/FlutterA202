import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/screens/newproduct_screen.dart';
import 'package:midtermstiw2044myshop/models/product.dart';
import 'package:midtermstiw2044myshop/widget/product_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getProducts();
    print('hi');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<ProductProvider>(builder: (context, product, _) {
          List<Product> productList = product.productList;
          // productList.forEach((element) => print(element.productName));
          return GridView.builder(
            itemCount: product.productList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product: productList[index],
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewProductScreen()));
        },
      ),
    );
  }
}
