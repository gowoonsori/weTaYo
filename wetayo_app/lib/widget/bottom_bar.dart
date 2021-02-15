import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Color(0xff184C88),
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.directions_bus_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
