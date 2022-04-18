import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtermstiw2044myshop/screens/editproduct_screen.dart';
import 'package:midtermstiw2044myshop/models/product.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product.pictureUrl,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 0) {
                      _editProduct(context);
                    }
                    if (value == 1) {
                      _deleteProduct(context);
                    }
                  },
                  child: Center(
                      child: Icon(
                    Icons.more_vert,
                  )),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Edit'),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 1,
                    )
                  ],
                ),
              ],
            ),
            Text(
              widget.product.productName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text('type: ${widget.product.productType}'),
            Text('RM ${widget.product.price.toString()}'),
            Text(
              'qty: ${widget.product.quantity.toString()}',
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _deleteProduct(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    bool isSuccess = await Provider.of<ProductProvider>(context, listen: false)
        .deleteProduct(widget.product.productId);
    if (isSuccess) {
      Fluttertoast.showToast(
          msg: "${widget.product.productName} deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "failed to delete ${widget.product.productName}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _editProduct(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: widget.product,
        ),
      ),
    );
  }
}
