import 'package:flutter/material.dart';

class TabLatestGrams extends StatefulWidget {
  @override
  _TabLatestGramsState createState() => _TabLatestGramsState();
}

class _TabLatestGramsState extends State<TabLatestGrams>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("Init tab 1");
  }

  @override
  void dispose() {
    print("in dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          child: Text('Latest Grams'),
        ),
      ),
    );
  }
}
