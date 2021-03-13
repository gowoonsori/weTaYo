import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wetayo_app/model/bus_arrival.dart';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import '../api/arrival_api.dart' as arrival_api;

class DetailPage extends StatefulWidget {
  final String item;
  DetailPage({Key key, this.item}) : super(key: key);
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  final Xml2Json xml2Json = Xml2Json();
  List<busArrival> _data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getArrivalList();
  }

  _getArrivalList() async {
    setState(() => _isLoading = true);

    //String station = _stationController.text;
    var response = await http.get(arrival_api.buildUrl(widget.item));
    String responseBody = response.body;
    xml2Json.parse(responseBody);
    var jsonString = xml2Json.toParker();
    //print('res >> $jsonString');

    var json = jsonDecode(jsonString);
    print(json);
    Map<String, dynamic> errorMessage = json['response']['msgHeader'];

    print('errorcode >> ${errorMessage['resultCode']}');
    if (errorMessage['resultCode'] != arrival_api.STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['resultMessage'];
        print('error >> $errMessage');

        _data = const [];
        _isLoading = false;
      });
      return;
    }

    List<dynamic> busArrivalList =
        json['response']['msgBody']['busArrivalList'];
    final int cnt = busArrivalList.length;
    print('cnt >> $cnt');

    List<busArrival> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = busArrivalList[i];
      return busArrival(
        item['flag'],
        item['locationNo1'],
        item['locationNo2'],
        item['lowPlate1'],
        item['lowPlate2'],
        item['plateNo1'],
        item['plateNo2'],
        item['predictTime1'],
        item['predictTime2'],
        item['remainSeatCnt1'],
        item['remainSeatCnt2'],
        item['routeId'],
        item['staOrder'],
        item['stationId'],
      );
    });

    print('list >>> ${list[0].locationNo1}');

    setState(() {
      _data = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Text(widget.item),
                ),
                Positioned(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
