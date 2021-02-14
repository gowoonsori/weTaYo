import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/lbs_station.dart';
import '../api/lbs_api.dart' as api;

class LbsScreen extends StatefulWidget {
  _LbsScreenState createState() => _LbsScreenState();
}

class _LbsScreenState extends State<LbsScreen> {
  List<lbsStation> _data = [];
  bool _isLoading = false;

  String _x = '126.7309';
  String _y = '37.3412';

  List<Card> _buildCards() {
    print('>>> _data.length? ${_data.length}');

    if (_data.length == 0) {
      return <Card>[];
    }

    List<Card> res = [];
    for (lbsStation info in _data) {
      Card card = Card(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      info.stationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      info.distance,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
      res.add(card);
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _onClick() {
    _getInfo();
  }

  _getInfo() async {
    setState(() => _isLoading = true);

    //String station = _stationController.text;
    var response = await http.get(api.buildUrl(_x, _y));
    String responseBody = response.body;
    print('res >> $responseBody');

    var json = jsonDecode(responseBody);
    print(json);
    Map<String, dynamic> errorMessage = json['comMsgHeader'];

    if (errorMessage['returnCode'] != api.STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['resultMessage'];
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
        //item['rowNum'],
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

    setState(() {
      _data = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text('정류소 이름'),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 150,
                        child: TextField(),
                      ),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      RaisedButton(
                        child: Text('조회'),
                        onPressed: _onClick,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('정류소 정보'),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: _buildCards(),
                  ),
                )
              ],
            ),
    );
  }
}
