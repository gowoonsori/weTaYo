import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class StationScreen extends StatefulWidget {
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  String _buttonState = 'OFF';
  String _text = '현재 위치 : 모름';

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
    _checkPermissions();
    _refresh();
  }

  _checkPermissions() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  _refresh() async {
    print('refresh current location');

    String _newText;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String result = "(${position.latitude}, ${position.longitude})";
      _newText = '현재 위치는 $result ';
    } on PlatformException {
      _newText = '현재 위치는 사용할 수 없습니다.';
    }
    setState(() {
      _text = _newText;
    });

    print(_text);
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
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 30.0),
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                '한국산업기술대 \n (이마트 방향) \n 정류소 선택하기',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              color: Color(0xff184C88),
              onPressed: _refresh,
              padding: const EdgeInsets.all(20.0),
            ),
          ),
          Container(
            alignment: Alignment(-0.5, 0),
            child: Text(
              '내 주변의 가장 가까운 정류소',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(_text),
          )
        ],
      ),
    )));
  }
}
