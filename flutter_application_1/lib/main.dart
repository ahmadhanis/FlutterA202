import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController numaTextEditingController = new TextEditingController();
  TextEditingController numbTextEditingController = new TextEditingController();
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: SingleChildScrollView(
            
            child: 
            Center(
              child: Container(
                color: Colors.red,
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        "assets/images/calc.png",
                        scale: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("First Number"),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: numaTextEditingController,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Second Number"),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: numbTextEditingController,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text("+"),
                          onPressed: () => calculateMe(1),
                        ),
                        RaisedButton(
                          child: Text("-"),
                          onPressed: () => calculateMe(2),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text("*"),
                          onPressed: () => calculateMe(3),
                        ),
                        RaisedButton(
                          child: Text("/"),
                          onPressed: () => calculateMe(4),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Result " + result.toStringAsFixed(2)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void calculateMe(int op) {
    setState(() {
      double numa = double.parse(numaTextEditingController.text);
      double numb = double.parse(numbTextEditingController.text);
      switch (op) {
        case 1:
          result = numa + numb;
          break; // The switch statement must be told to exit, or it will execute every case.
        case 2:
          result = numa - numb;
          break;
        case 3:
          result = numa * numb;
          break;
        case 4:
          result = numa / numb;
          break;
        default:
          print('choose a different number!');
      }

      print(result);
    });
  }
}
