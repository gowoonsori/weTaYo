import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _buttonState = 'OFF';

  void onClick() {
    print("onClick()");
    setState(() {
      if (_buttonState == 'OFF') {
        _buttonState = 'ON';
      } else {
        _buttonState = 'OFF';
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                width: double.infinity,
                height: 480.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    '정류소 \n 선택하기!!!',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  color: Color(0xff184C88),
                  onPressed: onClick,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      '즐겨찾기',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    color: Color(0xff184C88),
                    onPressed: onClick,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
