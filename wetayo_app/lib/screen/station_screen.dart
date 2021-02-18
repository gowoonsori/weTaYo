import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/lbs_station.dart';
import '../api/lbs_api.dart' as api;
import 'package:xml2json/xml2json.dart';
import "dart:io";

class StationScreen extends StatefulWidget {
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  String _buttonState = 'OFF';
  String _text = '현재 위치 : 모름';

  final Xml2Json xml2Json = Xml2Json();
  List<lbsStation> _data = [];
  bool _isLoading = false;

  //String _x, _y; // 현재 위치의 위도, 경도 (x, y)
  String _x = '126.7309';
  String _y = '37.3412';

  onClick() {
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
    _getInfo();
  }

  _checkPermissions() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  _refresh() async {
    print('refresh current location');
    String _newText;
    String _newX, _newY;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String result = "(${position.latitude}, ${position.longitude})";
      _newText = '현재 위치는 $result ';
      _newX = position.latitude.toString();
      _newY = position.longitude.toString();
    } on PlatformException {
      _newText = '현재 위치는 사용할 수 없습니다.';
    }
    setState(() {
      _text = _newText;
      _x = _newX;
      _y = _newY;
    });

    print(_text);
  }

  _getInfo() async {
    setState(() => _isLoading = true);

    //String station = _stationController.text;
    var response = await http.get(api.buildUrl(_x, _y));
    String responseBody = response.body;
    xml2Json.parse(responseBody);
    var jsonString = xml2Json.toParker();
    print('res >> $jsonString');

    var json = jsonDecode(jsonString);
    print(json);
    Map<String, dynamic> errorMessage = json['response']['comMsgHeader'];

    if (errorMessage['returnCode'] != api.STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['errMsg'];
        print('error >> $errMessage');

        _data = const [];
        _isLoading = false;
      });
      return;
    }

    List<dynamic> busStationAroundList =
        json['response']['msgBody']['busStationAroundList'];
    final int cnt = busStationAroundList.length;

    List<lbsStation> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = busStationAroundList[i];
      return lbsStation(
        item['centerYn'],
        item['districtCd'],
        item['mobileNo'],
        item['regionName'],
        item['stationId'],
        item['stationName'],
        item['x'],
        item['y'],
        item['distance'],
      );
    });

    print('list >>> ${list[0].stationName}');

    setState(() {
      _data = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment(-0.7, 0),
                    child: Text(
                      '나와 가장 가까운 정류소',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
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
                        '\'${_data[0].stationName}\'\n정류소 선택하기',
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 16.0, right: 10.0, left: 10.0),
                          child: InkWell(
                            onTap: onClick,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _data[index].stationName,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${_data[index].distance} (m)',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      itemCount: _data.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
