import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wetayo_app/api/config.dart';
import 'package:wetayo_app/screen/ServerTest.dart';
import 'package:wetayo_app/screen/home_screen.dart';
import 'package:wetayo_app/screen/lbs_screen.dart';
import 'package:wetayo_app/screen/station_screen.dart';
import 'package:wetayo_app/screen/test.dart';
import 'package:wetayo_app/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeTayo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              GraphQLProvider(
                client: graphqlService.client,
                child: ServerPage(),
              ),
              StationScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
