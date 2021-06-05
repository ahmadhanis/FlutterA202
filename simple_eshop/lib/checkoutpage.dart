import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CheckOutPage extends StatefulWidget {
  final String email;
  final double total;

  const CheckOutPage({Key? key, required this.email, required this.total})
      : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int _radioValue = 0;
  String _delivery = "Pickup";
  bool _statusdel = false;
  bool _statuspickup = true;
  String _selectedtime = "09:00 A.M";
  String _curtime = "";
  String _name = "Click to set";
  String _phone = "Click to set";
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String today = DateFormat('dd/MM/yyyy hh:mm a').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Checkout'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    Text(
                      "CUSTOMER DETAILS",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text("Email:")),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        Expanded(
                          flex: 7,
                          child: Text(widget.email),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text("Name:")),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        Expanded(
                          flex: 7,
                          child: GestureDetector(
                              onTap: () => {nameDialog()}, child: Text(_name)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text("Phone:")),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        Expanded(
                          flex: 7,
                          child: GestureDetector(
                              onTap: () => {phoneDialog()},
                              child: Text(_phone)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            Container(
              margin: EdgeInsets.all(2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    Text(
                      "DELIVERY METHOD",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pickup"),
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            _handleRadioValueChange(value);
                          },
                        ),
                        Text("Delivery"),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            _handleRadioValueChange(value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            Visibility(
              visible: _statuspickup,
              child: Container(
                margin: EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Text(
                        "PICKUP TIME",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 300,
                        child: Text(
                            "Pickup time daily from 9.00 A.M to 7.00 P.M from our store. Please allow 15-30 minutes to prepare your order before pickup time"),
                      ),
                      Row(
                        children: [
                          Expanded(flex: 3, child: Text("Current Time: ")),
                          Container(
                              height: 20,
                              child: VerticalDivider(color: Colors.grey)),
                          Expanded(
                            flex: 7,
                            child: Text(today),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(flex: 3, child: Text("Set Pickup Time: ")),
                          Container(
                              height: 20,
                              child: VerticalDivider(color: Colors.grey)),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    _selectedtime,
                                  ),
                                  Container(
                                      child: IconButton(
                                          iconSize: 32,
                                          icon: Icon(Icons.timer),
                                          onPressed: () =>
                                              {_selectTime(context)})),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _statusdel,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text(
                        "DELIVERY ADDRESS",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 6,
                              child: Column(
                                children: [
                                  TextField(
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Search/Enter address'),
                                    keyboardType: TextInputType.multiline,
                                    minLines:
                                        5, //Normal textInputField will be displayed
                                    maxLines:
                                        5, // when user presses enter it will adapt to it
                                  ),
                                ],
                              )),
                          Container(
                              height: 120,
                              child: VerticalDivider(color: Colors.grey)),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () => {},
                                      child: Text("From Location"),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 2,
                                  ),
                                  Container(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () => {},
                                      child: Text("From Map"),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            SizedBox(height: 10),
            Container(
                child: Column(
              children: [
                Text(
                  "TOTAL AMOUNT PAYABLE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "RM " + widget.total.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("PAY NOW"),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      switch (_radioValue) {
        case 0:
          _delivery = "Pickup";
          _statusdel = false;
          _statuspickup = true;

          break;
        case 1:
          _delivery = "Delivery";
          _statusdel = true;
          _statuspickup = false;
          break;
      }
      print(_delivery);
    });
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    final now = new DateTime.now();
    print("NOW: " + now.toString());
    String year = DateFormat('y').format(now);
    String month = DateFormat('M').format(now);
    String day = DateFormat('d').format(now);

    String _hour, _minute, _time = "";
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _selectedtime = _time;
        _curtime = DateFormat("Hm").format(now);

        _selectedtime = formatDate(
            DateTime(int.parse(year), int.parse(month), int.parse(day),
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        int ct = _convMin(_curtime);
        int st = _convMin(_time);
        int diff = st - ct;
        if (diff < 30) {
          Fluttertoast.showToast(
              msg: "Invalid time selection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {});
          return;
        }
      });
  }

  int _convMin(String c) {
    var val = c.split(":");
    int h = int.parse(val[0]);
    int m = int.parse(val[1]);
    int tmin = (h * 60) + m;
    return tmin;
  }

  void nameDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Your Name?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Name'),
                    keyboardType: TextInputType.name,
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _name = nameController.text;
                      setState(() {});
                    },
                  ),
                ]),
        context: context);
  }

  void phoneDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Your Phone?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: phoneController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Name'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _phone = phoneController.text;
                      setState(() {});
                    },
                  ),
                ]),
        context: context);
  }
}
