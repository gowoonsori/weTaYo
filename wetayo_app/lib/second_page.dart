import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice2/third_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geolocator/geolocator.dart';
import 'main_page.dart';

class Tabs_2 extends StatefulWidget {
  @override
  _Tabs_2State createState() => _Tabs_2State();
}

class _Tabs_2State extends State<Tabs_2> {
  var _currentIndex = 1;
  List _listPageData = [MainPage(), SecondPage(), SecondPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Bus App')),
      //body: this._listPageData[_currentIndex.currentIndex],
      body: this._listPageData[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        /* onTap: (int index) {
          if ((index == 0) || (index == 1)) {
            setState(() {
              this._currentIndex = index;
            });
          }
        }, */
        iconSize: 35.0,
        backgroundColor: Colors.black54,
        unselectedItemColor: Colors.white,
        fixedColor: Color(0xff184C88),
        //fixedColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus_outlined), title: Text('bus'))
        ],
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    // 새고로침 https://pub.dev/packages/pull_to_refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text("Select station"),
      ), */
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropMaterialHeader(backgroundColor: Color(0xff184C88)
            //backgroundColor: Colors.blueAccent
            ),
        child: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text(
                    '나와 가장 가까운 정류소 (500m 반경)',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'empty',
                              style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[300],
                            height: 20,
                            indent: 16,
                            endIndent: 16,
                          )
                        ])),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: double.infinity,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              '○○정류소\n(○○방향)\n선택하기',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            color: Color(0xff184C88), // 배경 색상
                            //color: Colors.blueAccent,

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tabs_3()),
                              );
                            }))),
              ],
            ),
          ),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class GeoLocatorService {
  Future<Position> getLocation() async {
    Position position =
        // ignore: deprecated_member_use
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return position;
  }
}
