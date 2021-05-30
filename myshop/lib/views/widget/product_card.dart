import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/product.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({this.product});

  BuildContext get context => null;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => {_deleteProduct()},
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://192.168.0.137/" + product.pictureUrl,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              product.productName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('type: ${product.productType}'),
            Text('RM ${product.price.toString()}'),
            Text(
              'qty: ${product.quantity.toString()}',
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  _deleteProduct() {
    print(product.productName);
    Provider.of<ProductProvider>(context, listen: false)
        .deleteProduct(product.productId);
  }
}
