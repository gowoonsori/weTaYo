import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wetayo_app/screen/detail_page.dart';

class ServerPage extends StatefulWidget {
  _ServerPage createState() => _ServerPage();
}

class _ServerPage extends State<ServerPage> {
  void onClickMovie(BuildContext context, Map _item) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql("""query{
            getRoute(regionName:"시흥"){
              routeId 
              routeNumber
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
    );
  }

  Widget _buildList(BuildContext context, QueryResult result) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: result.data["getRoute"].length,
        itemBuilder: (context, index) {
          Map item = result.data["getRoute"][index];
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
                  item["routeId"].toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      item["routeNumber".toString()],
                      style: TextStyle(color: Colors.yellow),
                    )
                  ],
                ),
                trailing: Text("routeNumber\n${item["routeNumber"]}"),
              ),
            ),
          );
        });
  }
}
