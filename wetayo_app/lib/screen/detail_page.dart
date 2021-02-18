import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map item;

  const DetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(item["title"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      item["medium_cover_image"],
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Container(
            color: Colors.blue[300],
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(blurRadius: 5, color: Colors.white)
                          ]),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              item["rating"].toString(),
                              style: TextStyle(color: Colors.yellow),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(blurRadius: 15, color: Colors.grey)
                        ]),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    child: Text(item["summary"]),
                  ),
                ],
              )),
            ),
          )),
    );
  }
}
