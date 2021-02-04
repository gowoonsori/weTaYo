import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:pratice3/second_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  String _text = "현재 위치 : 앎";
  //NavigationBarIndex _currentIndex;
  int _currentIndex;
  TabController controller;
  var _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    controller = TabController(vsync: this, length: 3);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _checkPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  _refresh() async {
    print('refresh current location');
    String _newText;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String result = "(${position.latitude}, ${position.longitude})";
      _newText = '현재 위치는 $result';
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
    print("complete!");
    return Scaffold(
      /* appBar: AppBar(
        title: Text('Home'),
      ),*/
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                width: double.infinity,
                height: 400.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    '정류장 탐색',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),

                  color: Color(0xff184C88), // 배경 색상
                  // color: Colors.blueAccent,

                  onPressed: () {
                    //_currentIndex.currentIndex = 1;
                    _refresh();
                    _currentIndex = 1;

                    // Navigator.pop(context, _currentIndex);
                    /*   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tabs_2()),
                    );*/
                  },
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
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.white),
                          ),
                          color: Color(0xff184C88), // 배경 색상
                          //color: Colors.blueAccent

                          onPressed: () {
                            flutterToast();
                          }))),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black54,
    );
  }
}

void flutterToast() {
  Fluttertoast.showToast(
      msg: 'No Favorite',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      fontSize: 18.0,
      textColor: Color(0xff184C88),
      //textColor: Colors.blueAccent,
      toastLength: Toast.LENGTH_SHORT);
}
