import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _urlPrefix =
    'http://openapi.gbis.go.kr/ws/rest/busstationservice/searcharound?serviceKey=';
const String _serviceKey =
    'Q2kheZxOB4Se5Iqm4ZVPAaA6Vaf9%2BdfUAIvymf%2BBWd3VoYvRmkjMQrQmE9LrIyizUYlkkW65HDZTmswAPgDDVA%3D%3D';
const String _xPrefix = '&x=';
const String _defaultX = '126.7309';
const String _yPrefix = '&y=';
const String _defaultY = '37.3412';

const String STATUS_OK = '00';

final Xml2Json xml2Json = Xml2Json();

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class SubwayArrival {
  String _centerYn;
  String _districtCd;
  String _mobileNo;
  String _regionName;
  String _stationId;
  String _stationName;
  String _x;
  String _y;
  String _distance;

  SubwayArrival(
      this._centerYn,
      this._districtCd,
      this._mobileNo,
      this._regionName,
      this._stationId,
      this._stationName,
      this._x,
      this._y,
      this._distance);

  String get centerYn => _centerYn;
  String get districtCd => _districtCd;
  String get mobileNo => _mobileNo;
  String get regionName => _regionName;
  String get stationId => _stationId;
  String get stationName => _stationName;
  String get x => _x;
  String get y => _y;
  String get distance => _distance;
}

class MainPageState extends State<MainPage> {
  String _centerYn;
  String _districtCd;
  String _mobileNo;
  String _regionName;
  String _stationId;
  String _stationName;
  String x;
  String y;
  String _distance;

  String _x = '126.7309';
  String _y = '37.3412';

  String _buildUrl(String x, String y) {
    StringBuffer sb = StringBuffer();
    sb.write(_urlPrefix);
    sb.write(_serviceKey);
    sb.write(_xPrefix);
    sb.write(x);
    sb.write(_yPrefix);
    sb.write(y);
    return sb.toString();
  }

  _httpGet(String url) async {
    var response = await http.get(_buildUrl(_x, _y));
    String responseBody = response.body;

    xml2Json.parse(responseBody);
    var jsonString = xml2Json.toParker();
    print('res >> $xml2Json');

    var json = jsonDecode(jsonString);
    print('json >> $json');
    Map<String, dynamic> errorMessage = json['response']['comMsgHeader'];

    if (errorMessage['returnCode'] != STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['errMsg'];
        //_rowNum = -1;
        //_subwayId = '';
        //_trainLineNm = '';
        //_subwayHeading = '';
        //_arvlMsg2 = errMessage;
      });
      return;
    }

    List<dynamic> realtimeArrivalList =
        json['response']['msgBody']['busStationAroundList'];
    final int cnt = realtimeArrivalList.length;
    print('cnt >>> $cnt');

    List<SubwayArrival> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = realtimeArrivalList[i];
      return SubwayArrival(
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

    SubwayArrival first = list[0];
    setState(() {
      _centerYn = first.centerYn;
      _districtCd = first.districtCd;
      _mobileNo = first.mobileNo;
      _regionName = first.regionName;
      _stationId = first.stationId;
      _stationName = first.stationName;
      _x = first.x;
      _y = first.y;
      _distance = first.distance;
    });
  }

  @override
  void initState() {
    super.initState();
    _httpGet(_buildUrl(_x, _y));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버스 실시간 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('rowNum : $_centerYn'),
            Text('subwayId : $_districtCd'),
            Text('trainLineNm : $_mobileNo'),
            Text('subwayHeading : $_regionName'),
            Text('arvlMsg2 : $_distance'),
          ],
        ),
      ),
    );
  }
}
