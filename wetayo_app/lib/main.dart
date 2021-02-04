import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';
//import 'second_page.dart';

void main() => runApp(
      MaterialApp(
        title: 'MyApp',
        home: MyApp(),
        debugShowCheckedModeBanner: false,
        // C:\flutter\packages\flutter\lib\src\material -> this.debugShowCheckedModeBanner” and set it to false
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tabs(),
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var _currentIndex = 0;
  //NavigationBarIndex _currentIndex = new NavigationBarIndex();
  List _listPageData = [MainPage(), MainPage(), MainPage()];

  @override
  Widget build(BuildContext context) {
    //_navigateAndDisplaySelection(context);

    return Scaffold(
      //appBar: AppBar(title: Text('Bus App')),
      //body: this._listPageData[_currentIndex.currentIndex],
      body: this._listPageData[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        /*onTap: (int index) {
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

/*
  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondPage()));
    /* setState(() {
      this._currentIndex = context as int;
    });
*/
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }*/
}
