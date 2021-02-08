import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.black,
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.notifications,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.directions_bus_outlined,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
