import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wetayo_app/model/bus_arrival.dart';
import 'package:wetayo_app/model/bus_route.dart';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import '../api/arrival_api.dart' as arrival_api;
import '../api/route_api.dart' as route_api;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';

class DetailPage extends StatefulWidget {
  final String item;
  DetailPage({Key key, this.item}) : super(key: key);
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  final CarouselController _controller = CarouselController();
  final Xml2Json xml2Json = Xml2Json();
  List<busArrival> _data = [];
  bool _isLoading = false;
  String routeName = '조회를 실패했습니다.';

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

  _getRouteName(String routeNum) async {
    var response = await http.get(route_api.buildUrl(routeNum));
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

    List<dynamic> routeInfoList = json['response']['msgBody'];
    final int cnt = routeInfoList.length;
    print('cnt >> $cnt');

    List<busRoute> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = routeInfoList[i];
      return busRoute(
        item['companyId'],
        item['companyName'],
        item['companyTel'],
        item['districtCd'],
        item['downFirstTime'],
        item['downLastTime'],
        item['endMobileNo'],
        item['endStationId'],
        item['endStationName'],
        item['peekAlloc'],
        item['regionName'],
        item['routeId'],
        item['routeName'],
        item['routeTypeCd'],
        item['routeTypeName'],
        item['startMobileNo'],
        item['startStationId'],
        item['startStationName'],
        item['upFirstTime'],
        item['upLastTime'],
        item['nPeekAlloc'],
      );
    });

    setState(() {
      print('list >> $list');
      routeName = list[0].routeName;
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
                Positioned(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: CarouselSlider.builder(
                    itemCount: _data.length,
                    options: CarouselOptions(
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.vertical,
                        autoPlay: false),
                    carouselController: _controller,
                    itemBuilder: (context, index, idx) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            //_getRouteName(_data[index].routeId),
                            //Text(routeName),
                            name(context, index),
                            Text(_data[index].predictTime1)
                          ],
                        ),
                      );
                    },
                  )),
            Row(
              children: <Widget>[
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.previousPage(),
                    child: Text('<-'),
                  ),
                ),
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.nextPage(),
                    child: Text('->'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget name(BuildContext context, int index) {
    _getRouteName(_data[index].routeId);
    print('routename >> $routeName');
    return Text(routeName);
  }
}
