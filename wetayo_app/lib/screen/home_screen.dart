import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _buttonState = 'OFF';

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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ButtonTheme(
            buttonColor: Color.fromRGBO(24, 76, 136, 0.5),
            minWidth: double.infinity,
            height: 100.0,
            child: RaisedButton(
              child: Text('정류소 \n선택하기'),
              padding: EdgeInsets.all(20),
              onPressed: onClick,
            ),
          )
        ],
      ),
    );
  }
}
