import 'package:flutter/material.dart';
import 'package:practice2/second_Page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'main_page.dart';

class Tabs_3 extends StatefulWidget {
  @override
  _Tabs_3State createState() => _Tabs_3State();
}

class _Tabs_3State extends State<Tabs_3> {
  var _currentIndex = 2;
  List _listPageData = [MainPage(), SecondPage(), ThirdPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Bus App')),
      //body: this._listPageData[_currentIndex.currentIndex],
      body: this._listPageData[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        /* onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },*/
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

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Text("Select station"),
      ), */
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropMaterialHeader(backgroundColor: Color(0xff184C88)
            // backgroundColor: Colors.blueAccent
            ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Container(
          child: SafeArea(
              child: Column(children: <Widget>[
            Text(
              '○○정류소 (○○방향)',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 400.0,
                child: Center(
                    child: Text(
                  '(경기) 20-1\n',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))),
          ])),
        ),
      ),
      backgroundColor: Colors.black54,
    );
  }
}
