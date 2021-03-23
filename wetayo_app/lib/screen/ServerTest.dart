import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wetayo_app/screen/detail_page.dart';

class ServerPage extends StatefulWidget {
  _ServerPage createState() => _ServerPage();
}

class _ServerPage extends State<ServerPage> {
  // void onClickMovie(BuildContext context, Map _item) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => DetailPage(
  //               //item: _item,
  //               )));
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Query(
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
                child: Text("에러가 발생했습니다.\n${result.exception.toString()}"));
          }
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(result.data.toString());
            return _buildList(context, result);
          }
        },
      ),
    ));
  }

  Widget _buildList(BuildContext context, QueryResult result) {
    return ListView.builder(
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
                //onTap: () => onClickMovie(context, item),
                dense: true,
                //leading: Image.network(item["medium_cover_image"]),
                title: Text(
                  item["stationName"].toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
        });
  }
}
