import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wetayo_app/screen/detail_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class StationScreen extends StatefulWidget {
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  String _text = '현재 위치 : 모름';
  //String _x, _y; // 현재 위치의 위도, 경도 (x, y)
  String _x = '126.7309';
  String _y = '37.3412';

  String name;
  String mobileNum;

  void onClickMovie(BuildContext context, String _item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  item: _item,
                )));
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _refresh();
  }

  // GPS 권한 요청 함수
  _checkPermissions() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  // 내 위치 조희 함수
  _refresh() async {
    print('refresh current location');
    String _newText;
    String _newX, _newY;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String result = "(${position.latitude}, ${position.longitude})";
      _newText = '현재 위치는 $result ';
      _newX = position.latitude.toString();
      _newY = position.longitude.toString();
    } on PlatformException {
      _newText = '현재 위치는 사용할 수 없습니다.';
    }
    setState(() {
      _text = _newText;
      _x = _newX;
      _y = _newY;
    });

    print(_text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment(-0.7, 0),
              child: Text(
                '나와 가장 가까운 정류소',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 30.0),
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  '\'${name}\'\n정류소 선택하기',
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                color: Color(0xff184C88),
                //onPressed: _refresh,
                onPressed: () => onClickMovie(context, mobileNum),
                padding: const EdgeInsets.all(20.0),
              ),
            ),
            Container(
              alignment: Alignment(-0.5, 0),
              child: Text(
                '내 주변의 가장 가까운 정류소',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Query(
              options: QueryOptions(
                document: gql("""query{
            getStation(gpsY: 37.3740667 gpsX: 126.84246 distance: 0.02){
              stationId
              stationName
              mobileNumber
              distance
              }
              }"""),
              ),
              builder: (QueryResult result,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result.exception != null) {
                  return Center(
                      child:
                          Text("에러가 발생했습니다.\n${result.exception.toString()}"));
                }
                if (result.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(result.data.toString());
                  name = result.data["getStation"][0]["stationName"].toString();
                  mobileNum =
                      result.data["getStation"][0]["mobileNumber"].toString();
                  print(name);
                  return _buildList(context, result);
                }
              },
            ),
          ],
        ),
      ),
    );
    //rebuildAllChildren(context);
  }

  Widget _buildList(BuildContext context, QueryResult result) {
    return Expanded(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: result.data["getStation"].length,
            itemBuilder: (context, index) {
              Map item = result.data["getStation"][index];
              return Card(
                shape: StadiumBorder(),
                elevation: 20,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () => onClickMovie(context, item['mobileNumber']),
                    dense: true,
                    //leading: Image.network(item["medium_cover_image"]),
                    title: Text(
                      item["stationName"].toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          item["mobileNumber".toString()],
                          style: TextStyle(color: Colors.yellow),
                        )
                      ],
                    ),
                    trailing: Text("distance\n${item["distance"]}"),
                  ),
                ),
              );
            }));
  }
}
