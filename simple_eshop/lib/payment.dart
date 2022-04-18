import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_eshop/user.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayScreen extends StatefulWidget {
  final User user;

  const PayScreen({Key? key, required this.user}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Container(

          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://slumberjer.com/myshopweb/mobile/generate_bill.php?email=' +
                          widget.user.email +
                          '&mobile=' +
                          widget.user.phone +
                          '&name=' +
                          widget.user.name +
                          '&amount=' +
                          widget.user.amount,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
