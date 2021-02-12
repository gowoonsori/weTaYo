import 'package:flutter/material.dart';

class StationScreen extends StatefulWidget {
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
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
            alignment: Alignment(-0.7, 0),
            child: Text(
              '나와 가장 가까운 정류소',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                '한국산업기술대 \n (이마트 방향) \n 정류소 선택하기',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              color: Color(0xff184C88),
              onPressed: onClick,
              padding: const EdgeInsets.all(20.0),
            ),
          )
        ],
      ),
    )));
  }
}
